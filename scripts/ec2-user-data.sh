#!/bin/bash
# EC2 User Data Script para desplegar Zuclubit Svelte Site
# Compatible con Amazon Linux 2023

set -e  # Salir si hay algún error

# Variables de configuración
REPO_URL="https://github.com/tu-usuario/zuclubit-site.git"  # Actualizar con tu repo
APP_DIR="/var/www/zuclubit-site"
NGINX_CONF="/etc/nginx/conf.d/zuclubit.conf"
LOG_FILE="/var/log/zuclubit-deployment.log"

# Función para logging
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== Iniciando despliegue de Zuclubit Site ==="

# 1. Actualizar el sistema
log "Actualizando paquetes del sistema..."
dnf update -y

# 2. Instalar nginx
log "Instalando nginx..."
dnf install -y nginx

# 3. Instalar Node.js y npm (versión LTS)
log "Instalando Node.js y npm..."
dnf install -y nodejs npm

# Verificar versiones instaladas
log "Node version: $(node --version)"
log "NPM version: $(npm --version)"

# 4. Instalar git si no está instalado
log "Instalando git..."
dnf install -y git

# 5. Crear directorio de la aplicación
log "Creando directorio de aplicación..."
mkdir -p "$APP_DIR"
cd "$APP_DIR"

# 6. Clonar el repositorio (o descomentar para usar archivos locales)
log "Clonando repositorio..."
# OPCIÓN 1: Clonar desde GitHub (descomentar y actualizar REPO_URL arriba)
# git clone "$REPO_URL" .

# OPCIÓN 2: Si los archivos ya están en el AMI o S3, copiarlos aquí
# Ejemplo con S3:
# aws s3 sync s3://tu-bucket/zuclubit-site/ "$APP_DIR"

# Para desarrollo/testing: crear estructura básica
# (Eliminar esto cuando uses un repo real)
cat > "$APP_DIR/.deployment-note" << 'EOF'
IMPORTANTE: Configura el método de obtención del código:
1. Descomentar la línea 'git clone' y actualizar REPO_URL
2. O configurar la sincronización desde S3
3. O incluir los archivos en un AMI personalizado
EOF

# 7. Instalar dependencias de Node.js
log "Instalando dependencias de npm..."
# Descomentar cuando tengas el código fuente:
# npm install

# 8. Construir la aplicación
log "Construyendo la aplicación..."
# Descomentar cuando tengas el código fuente:
# npm run build

# 9. Configurar nginx
log "Configurando nginx..."
cat > "$NGINX_CONF" << 'EOF'
server {
    listen 80;
    server_name _;

    root /var/www/zuclubit-site/dist;
    index index.html;

    # Logs
    access_log /var/log/nginx/zuclubit-access.log;
    error_log /var/log/nginx/zuclubit-error.log;

    # Compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss application/javascript;

    # Cache static assets
    location ~* \.(jpg|jpeg|png|gif|ico|css|js|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # SPA routing - redirect all to index.html
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
}
EOF

# 10. Crear directorio dist temporal (si no existe el build)
log "Preparando directorio de distribución..."
mkdir -p "$APP_DIR/dist"

# Crear página temporal de bienvenida
cat > "$APP_DIR/dist/index.html" << 'EOF'
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Zuclubit - Deployment en Progreso</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            text-align: center;
            padding: 2rem;
        }
        h1 { font-size: 2.5rem; margin-bottom: 1rem; }
        p { font-size: 1.2rem; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Zuclubit Site</h1>
        <p>Servidor configurado correctamente</p>
        <p>Actualiza el código fuente y reconstruye para ver tu aplicación</p>
    </div>
</body>
</html>
EOF

# 11. Configurar permisos
log "Configurando permisos..."
chown -R nginx:nginx "$APP_DIR"
chmod -R 755 "$APP_DIR"

# 12. Configurar SELinux (si está habilitado)
if [ -x "$(command -v setenforce)" ]; then
    log "Configurando SELinux..."
    chcon -R -t httpd_sys_content_t "$APP_DIR/dist"
fi

# 13. Habilitar e iniciar nginx
log "Iniciando nginx..."
systemctl enable nginx
systemctl start nginx
systemctl status nginx

# 14. Configurar firewall (si está habilitado)
if systemctl is-active --quiet firewalld; then
    log "Configurando firewall..."
    firewall-cmd --permanent --add-service=http
    firewall-cmd --permanent --add-service=https
    firewall-cmd --reload
fi

# 15. Verificación final
log "=== Verificación del despliegue ==="
log "Nginx status: $(systemctl is-active nginx)"
log "Node version: $(node --version)"
log "NPM version: $(npm --version)"

# Mostrar IP pública
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
log "Servidor disponible en: http://$PUBLIC_IP"

log "=== Despliegue completado ==="
log "NOTA: Recuerda configurar el método de obtención del código fuente"
log "Ver: $APP_DIR/.deployment-note"

# Crear script de actualización para uso futuro
cat > /usr/local/bin/update-zuclubit.sh << 'UPDATEEOF'
#!/bin/bash
# Script para actualizar la aplicación Zuclubit

set -e
APP_DIR="/var/www/zuclubit-site"

echo "Actualizando Zuclubit Site..."
cd "$APP_DIR"

# Obtener últimos cambios
git pull origin main

# Reinstalar dependencias si es necesario
npm install

# Reconstruir
npm run build

# Reiniciar nginx
systemctl reload nginx

echo "Actualización completada!"
UPDATEEOF

chmod +x /usr/local/bin/update-zuclubit.sh

log "Script de actualización creado en: /usr/local/bin/update-zuclubit.sh"
log "Uso: sudo /usr/local/bin/update-zuclubit.sh"

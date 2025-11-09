#!/bin/bash
# EC2 User Data Script para desplegar Zuclubit Svelte Site
# Compatible con Amazon Linux 2023

set -e  # Salir si hay alg�n error

# Variables de configuraci�n
REPO_URL="https://github.com/zuclubit/website.git"
APP_DIR="/var/www/zuclubit-site"
NGINX_CONF="/etc/nginx/conf.d/zuclubit.conf"
LOG_FILE="/var/log/zuclubit-deployment.log"

# Funci�n para logging
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

# 3. Instalar Node.js y npm (versi�n LTS)
log "Instalando Node.js y npm..."
dnf install -y nodejs npm

# Verificar versiones instaladas
log "Node version: $(node --version)"
log "NPM version: $(npm --version)"

# 4. Instalar git si no est� instalado
log "Instalando git..."
dnf install -y git

# 5. Crear directorio de la aplicaci�n
log "Creando directorio de aplicaci�n..."
mkdir -p "$APP_DIR"
cd "$APP_DIR"

# 6. Clonar el repositorio
log "Clonando repositorio..."
git clone "$REPO_URL" .

# 7. Instalar dependencias de Node.js
log "Instalando dependencias de npm..."
npm install

# 8. Construir la aplicaci�n
log "Construyendo la aplicaci�n..."
npm run build

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

# 10. Configurar permisos
log "Configurando permisos..."
chown -R nginx:nginx "$APP_DIR"
chmod -R 755 "$APP_DIR"

# 12. Configurar SELinux (si est� habilitado)
if [ -x "$(command -v setenforce)" ]; then
    log "Configurando SELinux..."
    chcon -R -t httpd_sys_content_t "$APP_DIR/dist"
fi

# 13. Habilitar e iniciar nginx
log "Iniciando nginx..."
systemctl enable nginx
systemctl start nginx
systemctl status nginx

# 14. Configurar firewall (si est� habilitado)
if systemctl is-active --quiet firewalld; then
    log "Configurando firewall..."
    firewall-cmd --permanent --add-service=http
    firewall-cmd --permanent --add-service=https
    firewall-cmd --reload
fi

# 15. Verificaci�n final
log "=== Verificaci�n del despliegue ==="
log "Nginx status: $(systemctl is-active nginx)"
log "Node version: $(node --version)"
log "NPM version: $(npm --version)"

# Mostrar IP p�blica
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
log "Servidor disponible en: http://$PUBLIC_IP"

log "=== Despliegue completado exitosamente ==="

# Crear script de actualizaci�n para uso futuro
cat > /usr/local/bin/update-zuclubit.sh << 'UPDATEEOF'
#!/bin/bash
# Script para actualizar la aplicaci�n Zuclubit

set -e
APP_DIR="/var/www/zuclubit-site"

echo "Actualizando Zuclubit Site..."
cd "$APP_DIR"

# Obtener �ltimos cambios
git pull origin main

# Reinstalar dependencias si es necesario
npm install

# Reconstruir
npm run build

# Reiniciar nginx
systemctl reload nginx

echo "Actualizaci�n completada!"
UPDATEEOF

chmod +x /usr/local/bin/update-zuclubit.sh

log "Script de actualizaci�n creado en: /usr/local/bin/update-zuclubit.sh"
log "Uso: sudo /usr/local/bin/update-zuclubit.sh"

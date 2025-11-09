#!/bin/bash
################################################################################
# EC2 User Data Script - Zuclubit Svelte Site Deployment
# Compatible con Amazon Linux 2023
# Descripción: Deployment automatizado del sitio web corporativo Zuclubit
# Version: 2.0
################################################################################

set -e  # Salir si hay algún error
set -o pipefail  # Capturar errores en pipes

################################################################################
# CONFIGURACIÓN
################################################################################

REPO_URL="https://github.com/zuclubit/website.git"
APP_DIR="/var/www/zuclubit-site"
NGINX_CONF="/etc/nginx/conf.d/zuclubit.conf"
LOG_FILE="/var/log/zuclubit-deployment.log"
ERROR_LOG="/var/log/zuclubit-deployment-errors.log"

# Colores para output (aunque no se vean en logs, se ven en cloud-init-output.log)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Contadores
STEP_COUNTER=0
TOTAL_STEPS=16
START_TIME=$(date +%s)

################################################################################
# FUNCIONES DE LOGGING
################################################################################

# Incrementar contador de pasos
increment_step() {
    STEP_COUNTER=$((STEP_COUNTER + 1))
}

# Log básico con timestamp
log_raw() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Log de información
log_info() {
    increment_step
    local progress="[$STEP_COUNTER/$TOTAL_STEPS]"
    echo -e "${BLUE}ℹ ${NC}${progress} [$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Log de éxito
log_success() {
    echo -e "${GREEN}✓${NC} [$(date '+%H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Log de error
log_error() {
    echo -e "${RED}✗${NC} [$(date '+%H:%M:%S')] ERROR: $1" | tee -a "$LOG_FILE" | tee -a "$ERROR_LOG"
}

# Log de advertencia
log_warning() {
    echo -e "${YELLOW}⚠${NC} [$(date '+%H:%M:%S')] WARNING: $1" | tee -a "$LOG_FILE"
}

# Log de detalle (sub-paso)
log_detail() {
    echo -e "  ${CYAN}→${NC} $1" | tee -a "$LOG_FILE"
}

# Header de sección
log_header() {
    echo "" | tee -a "$LOG_FILE"
    echo "═══════════════════════════════════════════════════════════════" | tee -a "$LOG_FILE"
    echo "  $1" | tee -a "$LOG_FILE"
    echo "═══════════════════════════════════════════════════════════════" | tee -a "$LOG_FILE"
}

# Footer de sección
log_section_complete() {
    echo -e "${GREEN}  ✓ $1 completado${NC}" | tee -a "$LOG_FILE"
    echo "" | tee -a "$LOG_FILE"
}

################################################################################
# FUNCIONES DE VALIDACIÓN
################################################################################

# Validar que un comando existe
validate_command() {
    local cmd=$1
    local name=$2
    if command -v "$cmd" &> /dev/null; then
        log_success "$name está disponible: $(command -v $cmd)"
        return 0
    else
        log_error "$name no está disponible"
        return 1
    fi
}

# Validar que un servicio está activo
validate_service() {
    local service=$1
    if systemctl is-active --quiet "$service"; then
        log_success "Servicio $service está activo"
        return 0
    else
        log_error "Servicio $service no está activo"
        systemctl status "$service" --no-pager | tee -a "$LOG_FILE"
        return 1
    fi
}

# Validar que un directorio existe
validate_directory() {
    local dir=$1
    local desc=$2
    if [ -d "$dir" ]; then
        log_success "$desc existe: $dir"
        log_detail "Contenido: $(ls -la "$dir" | wc -l) archivos/directorios"
        return 0
    else
        log_error "$desc no existe: $dir"
        return 1
    fi
}

# Validar que un archivo existe
validate_file() {
    local file=$1
    local desc=$2
    if [ -f "$file" ]; then
        log_success "$desc existe: $file"
        log_detail "Tamaño: $(du -h "$file" | cut -f1)"
        return 0
    else
        log_error "$desc no existe: $file"
        return 1
    fi
}

################################################################################
# INICIO DEL DEPLOYMENT
################################################################################

log_header "INICIO DE DEPLOYMENT - ZUCLUBIT WEBSITE"
log_raw "Timestamp: $(date)"
log_raw "Script Version: 2.0"
log_raw "Repository: $REPO_URL"
log_raw "Application Directory: $APP_DIR"
echo ""

################################################################################
# PASO 1: ACTUALIZAR EL SISTEMA
################################################################################

log_info "Actualizando paquetes del sistema"
log_detail "Ejecutando: dnf update -y"

if dnf update -y >> "$LOG_FILE" 2>&1; then
    log_success "Sistema actualizado correctamente"
else
    log_warning "Algunos paquetes no se actualizaron, continuando..."
fi

log_section_complete "Actualización del sistema"

################################################################################
# PASO 2: INSTALAR NGINX
################################################################################

log_info "Instalando servidor web nginx"
log_detail "Ejecutando: dnf install -y nginx"

if dnf install -y nginx >> "$LOG_FILE" 2>&1; then
    log_success "nginx instalado correctamente"
    NGINX_VERSION=$(nginx -v 2>&1 | cut -d'/' -f2)
    log_detail "Versión: $NGINX_VERSION"
    validate_command "nginx" "nginx"
else
    log_error "Falló la instalación de nginx"
    exit 1
fi

log_section_complete "Instalación de nginx"

################################################################################
# PASO 3: INSTALAR NODE.JS Y NPM
################################################################################

log_info "Instalando Node.js y npm"
log_detail "Ejecutando: dnf install -y nodejs npm"

if dnf install -y nodejs npm >> "$LOG_FILE" 2>&1; then
    log_success "Node.js y npm instalados correctamente"

    # Validar instalación
    validate_command "node" "Node.js"
    validate_command "npm" "npm"

    NODE_VERSION=$(node --version)
    NPM_VERSION=$(npm --version)

    log_detail "Node.js: $NODE_VERSION"
    log_detail "npm: $NPM_VERSION"
else
    log_error "Falló la instalación de Node.js/npm"
    exit 1
fi

log_section_complete "Instalación de Node.js y npm"

################################################################################
# PASO 4: INSTALAR GIT
################################################################################

log_info "Instalando Git"
log_detail "Ejecutando: dnf install -y git"

if dnf install -y git >> "$LOG_FILE" 2>&1; then
    log_success "Git instalado correctamente"

    GIT_VERSION=$(git --version)
    log_detail "$GIT_VERSION"
    validate_command "git" "Git"
else
    log_error "Falló la instalación de Git"
    exit 1
fi

log_section_complete "Instalación de Git"

################################################################################
# PASO 5: CREAR DIRECTORIO DE LA APLICACIÓN
################################################################################

log_info "Creando estructura de directorios"
log_detail "Directorio de aplicación: $APP_DIR"

if mkdir -p "$APP_DIR"; then
    log_success "Directorio creado: $APP_DIR"
    validate_directory "$APP_DIR" "Directorio de aplicación"

    # Cambiar al directorio de trabajo
    cd "$APP_DIR" || exit 1
    log_detail "Directorio de trabajo actual: $(pwd)"
else
    log_error "No se pudo crear el directorio: $APP_DIR"
    exit 1
fi

log_section_complete "Creación de directorios"

################################################################################
# PASO 6: CLONAR REPOSITORIO
################################################################################

log_info "Clonando repositorio desde GitHub"
log_detail "URL: $REPO_URL"
log_detail "Destino: $APP_DIR"

CLONE_START=$(date +%s)

if git clone "$REPO_URL" . >> "$LOG_FILE" 2>&1; then
    CLONE_END=$(date +%s)
    CLONE_TIME=$((CLONE_END - CLONE_START))

    log_success "Repositorio clonado correctamente"
    log_detail "Tiempo de clonación: ${CLONE_TIME}s"

    # Verificar branch
    CURRENT_BRANCH=$(git branch --show-current)
    LAST_COMMIT=$(git log -1 --pretty=format:"%h - %s (%an, %ar)")

    log_detail "Branch: $CURRENT_BRANCH"
    log_detail "Último commit: $LAST_COMMIT"

    # Contar archivos clonados
    FILE_COUNT=$(find . -type f | wc -l)
    log_detail "Archivos clonados: $FILE_COUNT"
else
    log_error "Falló la clonación del repositorio"
    exit 1
fi

log_section_complete "Clonación del repositorio"

################################################################################
# PASO 7: VERIFICAR ARCHIVOS DEL PROYECTO
################################################################################

log_info "Verificando estructura del proyecto"

# Validar archivos críticos
validate_file "package.json" "package.json"
validate_file "index.html" "index.html"
validate_file "vite.config.js" "vite.config.js"

# Verificar directorios del proyecto
if [ -d "src" ]; then
    SRC_FILES=$(find src -type f | wc -l)
    log_detail "Directorio src/: $SRC_FILES archivos"
fi

log_section_complete "Verificación de estructura del proyecto"

################################################################################
# PASO 8: INSTALAR DEPENDENCIAS NPM
################################################################################

log_info "Instalando dependencias de Node.js"
log_detail "Ejecutando: npm install"

NPM_START=$(date +%s)

if npm install >> "$LOG_FILE" 2>&1; then
    NPM_END=$(date +%s)
    NPM_TIME=$((NPM_END - NPM_START))

    log_success "Dependencias instaladas correctamente"
    log_detail "Tiempo de instalación: ${NPM_TIME}s"

    # Contar dependencias instaladas
    if [ -d "node_modules" ]; then
        DEP_COUNT=$(ls -1 node_modules | wc -l)
        log_detail "Dependencias instaladas: $DEP_COUNT paquetes"

        # Tamaño de node_modules
        NODE_MODULES_SIZE=$(du -sh node_modules | cut -f1)
        log_detail "Tamaño de node_modules: $NODE_MODULES_SIZE"
    fi
else
    log_error "Falló la instalación de dependencias npm"
    exit 1
fi

log_section_complete "Instalación de dependencias"

################################################################################
# PASO 9: CONSTRUIR LA APLICACIÓN
################################################################################

log_info "Construyendo aplicación Svelte con Vite"
log_detail "Ejecutando: npm run build"

BUILD_START=$(date +%s)

if npm run build >> "$LOG_FILE" 2>&1; then
    BUILD_END=$(date +%s)
    BUILD_TIME=$((BUILD_END - BUILD_START))

    log_success "Aplicación construida correctamente"
    log_detail "Tiempo de construcción: ${BUILD_TIME}s"

    # Validar directorio dist
    validate_directory "$APP_DIR/dist" "Directorio de distribución"

    # Verificar archivos en dist
    if [ -d "dist" ]; then
        DIST_FILES=$(find dist -type f | wc -l)
        DIST_SIZE=$(du -sh dist | cut -f1)
        log_detail "Archivos generados: $DIST_FILES"
        log_detail "Tamaño de dist: $DIST_SIZE"

        # Verificar index.html
        validate_file "dist/index.html" "dist/index.html"
    fi
else
    log_error "Falló la construcción de la aplicación"
    exit 1
fi

log_section_complete "Construcción de la aplicación"

################################################################################
# PASO 10: CONFIGURAR NGINX
################################################################################

log_info "Configurando servidor web nginx"
log_detail "Archivo de configuración: $NGINX_CONF"

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

if [ -f "$NGINX_CONF" ]; then
    log_success "Configuración de nginx creada"
    validate_file "$NGINX_CONF" "Configuración de nginx"

    # Validar sintaxis de nginx
    log_detail "Validando sintaxis de configuración..."
    if nginx -t >> "$LOG_FILE" 2>&1; then
        log_success "Sintaxis de configuración correcta"
    else
        log_error "Error en la sintaxis de configuración de nginx"
        nginx -t 2>&1 | tee -a "$LOG_FILE"
        exit 1
    fi
else
    log_error "No se pudo crear la configuración de nginx"
    exit 1
fi

log_section_complete "Configuración de nginx"

################################################################################
# PASO 11: CONFIGURAR PERMISOS
################################################################################

log_info "Configurando permisos del sistema de archivos"
log_detail "Propietario: nginx:nginx"
log_detail "Permisos: 755"

if chown -R nginx:nginx "$APP_DIR"; then
    log_success "Propietario configurado correctamente"
else
    log_error "No se pudo cambiar el propietario"
    exit 1
fi

if chmod -R 755 "$APP_DIR"; then
    log_success "Permisos configurados correctamente"
    log_detail "$(ls -ld $APP_DIR)"
else
    log_error "No se pudo cambiar los permisos"
    exit 1
fi

log_section_complete "Configuración de permisos"

################################################################################
# PASO 12: CONFIGURAR SELINUX
################################################################################

log_info "Verificando y configurando SELinux"

if [ -x "$(command -v setenforce)" ]; then
    log_detail "SELinux detectado, configurando contextos..."

    if chcon -R -t httpd_sys_content_t "$APP_DIR/dist" 2>> "$LOG_FILE"; then
        log_success "Contextos SELinux configurados"

        # Verificar contexto
        CONTEXT=$(ls -Z "$APP_DIR/dist" | head -1)
        log_detail "Contexto: $CONTEXT"
    else
        log_warning "No se pudo configurar SELinux, puede requerir ajuste manual"
    fi
else
    log_detail "SELinux no está instalado o activo"
    log_success "Paso omitido (no requerido)"
fi

log_section_complete "Configuración de SELinux"

################################################################################
# PASO 13: HABILITAR E INICIAR NGINX
################################################################################

log_info "Iniciando servidor web nginx"

# Habilitar nginx en el arranque
log_detail "Habilitando nginx en el arranque del sistema..."
if systemctl enable nginx >> "$LOG_FILE" 2>&1; then
    log_success "nginx habilitado en el arranque"
else
    log_warning "No se pudo habilitar nginx en el arranque"
fi

# Iniciar nginx
log_detail "Iniciando servicio nginx..."
if systemctl start nginx >> "$LOG_FILE" 2>&1; then
    log_success "Servicio nginx iniciado"

    # Validar que está corriendo
    sleep 2
    validate_service "nginx"

    # Mostrar información del servicio
    NGINX_PID=$(systemctl show nginx --property=MainPID --value)
    log_detail "PID del proceso: $NGINX_PID"

    # Verificar puertos en escucha
    LISTENING_PORTS=$(ss -tlnp | grep nginx | awk '{print $4}' | cut -d':' -f2 | sort -u | tr '\n' ',' | sed 's/,$//')
    log_detail "Puertos en escucha: $LISTENING_PORTS"
else
    log_error "No se pudo iniciar nginx"
    systemctl status nginx --no-pager | tee -a "$LOG_FILE"
    exit 1
fi

log_section_complete "Inicio de nginx"

################################################################################
# PASO 14: CONFIGURAR FIREWALL
################################################################################

log_info "Configurando firewall del sistema"

if systemctl is-active --quiet firewalld; then
    log_detail "firewalld está activo, configurando reglas..."

    # HTTP
    if firewall-cmd --permanent --add-service=http >> "$LOG_FILE" 2>&1; then
        log_success "Regla HTTP agregada"
    fi

    # HTTPS
    if firewall-cmd --permanent --add-service=https >> "$LOG_FILE" 2>&1; then
        log_success "Regla HTTPS agregada"
    fi

    # Recargar firewall
    if firewall-cmd --reload >> "$LOG_FILE" 2>&1; then
        log_success "Firewall recargado"

        # Listar servicios activos
        ACTIVE_SERVICES=$(firewall-cmd --list-services)
        log_detail "Servicios activos: $ACTIVE_SERVICES"
    fi
else
    log_detail "firewalld no está activo"
    log_success "Paso omitido (firewall no requerido)"
fi

log_section_complete "Configuración de firewall"

################################################################################
# PASO 15: CREAR SCRIPT DE ACTUALIZACIÓN
################################################################################

log_info "Creando script de actualización"
log_detail "Ubicación: /usr/local/bin/update-zuclubit.sh"

cat > /usr/local/bin/update-zuclubit.sh << 'UPDATEEOF'
#!/bin/bash
# Script para actualizar la aplicación Zuclubit
# Uso: sudo /usr/local/bin/update-zuclubit.sh

set -e
APP_DIR="/var/www/zuclubit-site"
LOG_FILE="/var/log/zuclubit-updates.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== Iniciando actualización de Zuclubit Site ==="
cd "$APP_DIR"

# Obtener últimos cambios
log "Obteniendo últimos cambios desde GitHub..."
git pull origin main

# Reinstalar dependencias si package.json cambió
log "Verificando dependencias..."
npm install

# Reconstruir aplicación
log "Reconstruyendo aplicación..."
npm run build

# Reiniciar nginx
log "Reiniciando nginx..."
systemctl reload nginx

log "=== Actualización completada exitosamente ==="
log "Última actualización: $(git log -1 --pretty=format:'%h - %s (%ar)')"
UPDATEEOF

if chmod +x /usr/local/bin/update-zuclubit.sh; then
    log_success "Script de actualización creado"
    validate_file "/usr/local/bin/update-zuclubit.sh" "Script de actualización"
    log_detail "Uso: sudo /usr/local/bin/update-zuclubit.sh"
else
    log_warning "No se pudo hacer el script ejecutable"
fi

log_section_complete "Creación de scripts auxiliares"

################################################################################
# PASO 16: VERIFICACIÓN FINAL Y REPORTES
################################################################################

log_info "Realizando verificaciones finales"

# Verificar servicio nginx
validate_service "nginx"

# Verificar directorio dist
validate_directory "$APP_DIR/dist" "Directorio de distribución"

# Verificar index.html en dist
validate_file "$APP_DIR/dist/index.html" "Archivo principal index.html"

# Obtener IP pública
log_detail "Obteniendo información de red..."
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4 2>/dev/null || echo "No disponible")
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id 2>/dev/null || echo "No disponible")
AVAILABILITY_ZONE=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone 2>/dev/null || echo "No disponible")

# Test HTTP local
log_detail "Verificando respuesta HTTP local..."
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost 2>/dev/null || echo "000")

if [ "$HTTP_STATUS" = "200" ]; then
    log_success "Servidor respondiendo correctamente (HTTP 200)"
else
    log_warning "Servidor retornó código HTTP: $HTTP_STATUS"
fi

log_section_complete "Verificaciones finales"

################################################################################
# REPORTE FINAL
################################################################################

END_TIME=$(date +%s)
TOTAL_TIME=$((END_TIME - START_TIME))
MINUTES=$((TOTAL_TIME / 60))
SECONDS=$((TOTAL_TIME % 60))

log_header "DEPLOYMENT COMPLETADO EXITOSAMENTE"
echo ""
log_raw "╔════════════════════════════════════════════════════════════════╗"
log_raw "║                   ZUCLUBIT WEBSITE DEPLOYED                    ║"
log_raw "╚════════════════════════════════════════════════════════════════╝"
echo ""
log_raw "📊 Estadísticas del Deployment:"
log_raw "   • Tiempo total: ${MINUTES}m ${SECONDS}s"
log_raw "   • Pasos completados: $STEP_COUNTER/$TOTAL_STEPS"
log_raw "   • Repositorio: $REPO_URL"
log_raw "   • Branch: $CURRENT_BRANCH"
log_raw ""
log_raw "🖥️  Información del Servidor:"
log_raw "   • Instance ID: $INSTANCE_ID"
log_raw "   • Availability Zone: $AVAILABILITY_ZONE"
log_raw "   • IP Pública: $PUBLIC_IP"
log_raw "   • Node.js: $NODE_VERSION"
log_raw "   • npm: $NPM_VERSION"
log_raw ""
log_raw "🌐 Acceso Web:"
log_raw "   • URL: http://$PUBLIC_IP"
log_raw "   • Estado: HTTP $HTTP_STATUS"
log_raw ""
log_raw "📁 Archivos y Directorios:"
log_raw "   • Aplicación: $APP_DIR"
log_raw "   • Archivos en dist: $DIST_FILES"
log_raw "   • Tamaño dist: $DIST_SIZE"
log_raw ""
log_raw "📋 Logs y Configuración:"
log_raw "   • Deployment log: $LOG_FILE"
log_raw "   • Error log: $ERROR_LOG"
log_raw "   • nginx config: $NGINX_CONF"
log_raw "   • nginx access: /var/log/nginx/zuclubit-access.log"
log_raw "   • nginx error: /var/log/nginx/zuclubit-error.log"
log_raw ""
log_raw "🔧 Comandos Útiles:"
log_raw "   • Ver logs: sudo tail -f $LOG_FILE"
log_raw "   • Estado nginx: sudo systemctl status nginx"
log_raw "   • Actualizar sitio: sudo /usr/local/bin/update-zuclubit.sh"
log_raw "   • Reiniciar nginx: sudo systemctl restart nginx"
log_raw ""
log_raw "✅ Deployment finalizado: $(date)"
log_raw "═══════════════════════════════════════════════════════════════"

echo ""
echo "🎉 ¡Deployment completado exitosamente!"
echo "🌐 Sitio disponible en: http://$PUBLIC_IP"
echo ""

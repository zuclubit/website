#!/bin/bash

# ============================================
# Zuclubit - CloudFlare Pages Deployment
# ============================================
# Despliega el frontend a CloudFlare Pages con HTTPS
#
# Uso:
#   ./deploy-cloudflare.sh              # Deploy a production
#   ./deploy-cloudflare.sh --preview    # Deploy a preview
#   ./deploy-cloudflare.sh --help       # Mostrar ayuda
# ============================================

set -e  # Exit on error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Variables
PROJECT_NAME="zuclubit-site"
BUILD_DIR="dist"

# Funciones
print_step() {
    echo -e "${BLUE}▶ $1${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${CYAN}ℹ $1${NC}"
}

show_help() {
    echo "Zuclubit CloudFlare Pages Deployment Script"
    echo ""
    echo "Uso:"
    echo "  ./deploy-cloudflare.sh              Deploy a production"
    echo "  ./deploy-cloudflare.sh --preview    Deploy a preview (testing)"
    echo "  ./deploy-cloudflare.sh --help       Mostrar esta ayuda"
    echo ""
    echo "Variables de entorno:"
    echo "  PROJECT_NAME       Nombre del proyecto CloudFlare (default: $PROJECT_NAME)"
    echo ""
    echo "Características:"
    echo "  ✅ HTTPS automático"
    echo "  ✅ CDN global (330+ ubicaciones)"
    echo "  ✅ Deploy en segundos"
    echo "  ✅ Preview URLs para testing"
    echo "  ✅ Rollback instantáneo"
    exit 0
}

# Parse arguments
DEPLOY_MODE="production"
while [[ $# -gt 0 ]]; do
    case $1 in
        --preview)
            DEPLOY_MODE="preview"
            shift
            ;;
        --help)
            show_help
            ;;
        *)
            print_error "Opción desconocida: $1"
            show_help
            ;;
    esac
done

echo ""
echo "╔════════════════════════════════════════╗"
echo "║   ZUCLUBIT - CLOUDFLARE DEPLOYMENT    ║"
echo "╚════════════════════════════════════════╝"
echo ""

# 1. Verificar que estamos en el directorio correcto
print_step "Verificando directorio del proyecto..."
if [ ! -f "package.json" ]; then
    print_error "No se encontró package.json. Ejecuta este script desde la raíz del proyecto."
    exit 1
fi
print_success "Directorio correcto"

# 2. Verificar Wrangler CLI
print_step "Verificando Wrangler CLI..."
if ! command -v wrangler &> /dev/null; then
    print_error "Wrangler CLI no está instalado"
    print_info "Instálalo con: npm install -g wrangler"
    exit 1
fi
WRANGLER_VERSION=$(wrangler --version)
print_success "Wrangler CLI instalado (versión: $WRANGLER_VERSION)"

# 3. Verificar autenticación
print_step "Verificando autenticación CloudFlare..."
if ! wrangler whoami &> /dev/null; then
    print_error "No estás autenticado en CloudFlare"
    print_info "Ejecuta: wrangler login"
    exit 1
fi
print_success "Autenticado con CloudFlare"

# 4. Limpiar build anterior
print_step "Limpiando build anterior..."
rm -rf $BUILD_DIR/
print_success "Build anterior eliminado"

# 5. Verificar dependencias
print_step "Verificando dependencias..."
if [ ! -d "node_modules" ]; then
    print_warning "Instalando dependencias..."
    npm install
    print_success "Dependencias instaladas"
else
    print_success "Dependencias ya instaladas"
fi

# 6. Build del proyecto
print_step "Ejecutando build..."
npm run build
if [ $? -eq 0 ]; then
    print_success "Build completado exitosamente"
else
    print_error "Build falló"
    exit 1
fi

# 7. Verificar que el build generó archivos
if [ ! -d "$BUILD_DIR" ] || [ -z "$(ls -A $BUILD_DIR)" ]; then
    print_error "El directorio $BUILD_DIR está vacío o no existe"
    exit 1
fi
print_success "Archivos de build generados"

# 8. Deploy a CloudFlare Pages
print_step "Desplegando a CloudFlare Pages ($DEPLOY_MODE)..."

DEPLOY_OUTPUT=$(mktemp)

if [ "$DEPLOY_MODE" = "preview" ]; then
    # Preview deployment
    wrangler pages deploy $BUILD_DIR \
        --project-name=$PROJECT_NAME \
        --commit-dirty=true \
        --branch=preview 2>&1 | tee $DEPLOY_OUTPUT
else
    # Production deployment
    wrangler pages deploy $BUILD_DIR \
        --project-name=$PROJECT_NAME \
        --commit-dirty=true \
        --branch=main 2>&1 | tee $DEPLOY_OUTPUT
fi

if [ ${PIPESTATUS[0]} -eq 0 ]; then
    print_success "Deployment exitoso"
else
    print_error "Error al desplegar"
    rm -f $DEPLOY_OUTPUT
    exit 1
fi

# 9. Extraer URL del deployment
DEPLOYMENT_URL=$(grep -o 'https://[a-zA-Z0-9.-]*\.pages\.dev' $DEPLOY_OUTPUT | head -1)
rm -f $DEPLOY_OUTPUT

# 10. Mostrar información del deployment
echo ""
echo "╔════════════════════════════════════════╗"
echo "║         DEPLOYMENT EXITOSO            ║"
echo "╚════════════════════════════════════════╝"
echo ""

if [ -n "$DEPLOYMENT_URL" ]; then
    print_success "URL: $DEPLOYMENT_URL"
else
    print_success "URL: https://$PROJECT_NAME.pages.dev"
fi

print_success "Proyecto: $PROJECT_NAME"
print_success "CDN: CloudFlare (330+ ubicaciones globales)"
print_success "HTTPS: ✅ Habilitado automáticamente"
print_success "Modo: $DEPLOY_MODE"

echo ""

# Mostrar tamaño del deployment
DIST_SIZE=$(du -sh $BUILD_DIR/ | cut -f1)
print_success "Tamaño del build: $DIST_SIZE"

# Mostrar archivos principales
echo ""
echo "Archivos desplegados:"
find $BUILD_DIR -type f -name "*.html" -o -name "*.css" -o -name "*.js" | while read file; do
    size=$(du -h "$file" | cut -f1)
    name=$(basename "$file")
    echo "  - $name ($size)"
done

echo ""
print_info "Dashboard CloudFlare: https://dash.cloudflare.com/pages"
print_info "Analytics: https://dash.cloudflare.com/$PROJECT_NAME/analytics"

echo ""
print_success "Deployment completado en $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# Tips adicionales
if [ "$DEPLOY_MODE" = "preview" ]; then
    echo "💡 Tips:"
    echo "  - Esta es una URL preview temporal para testing"
    echo "  - Para deploy a producción: ./deploy-cloudflare.sh"
    echo "  - La URL preview expira después de un tiempo"
    echo ""
fi

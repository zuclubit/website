#!/bin/bash

# ============================================
# Zuclubit - Script de Deployment Automático
# ============================================
# Despliega el frontend a S3 y opcionalmente invalida CloudFront
#
# Uso:
#   ./deploy.sh              # Deploy normal
#   ./deploy.sh --cloudfront # Deploy + invalidar CloudFront cache
#   ./deploy.sh --help       # Mostrar ayuda
# ============================================

set -e  # Exit on error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Variables
BUCKET_NAME="zuclubit-website-1762706724"
REGION="us-east-1"
CLOUDFRONT_ID=""  # Añadir cuando tengas CloudFront

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

show_help() {
    echo "Zuclubit Deployment Script"
    echo ""
    echo "Uso:"
    echo "  ./deploy.sh              Deploy a S3"
    echo "  ./deploy.sh --cloudfront Deploy + invalidar CloudFront"
    echo "  ./deploy.sh --help       Mostrar esta ayuda"
    echo ""
    echo "Variables de entorno:"
    echo "  BUCKET_NAME       Nombre del bucket S3 (default: $BUCKET_NAME)"
    echo "  CLOUDFRONT_ID     ID de distribución CloudFront"
    exit 0
}

# Parse arguments
INVALIDATE_CLOUDFRONT=false
while [[ $# -gt 0 ]]; do
    case $1 in
        --cloudfront)
            INVALIDATE_CLOUDFRONT=true
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
echo "║   ZUCLUBIT - DEPLOYMENT AUTOMÁTICO    ║"
echo "╚════════════════════════════════════════╝"
echo ""

# 1. Verificar que estamos en el directorio correcto
print_step "Verificando directorio del proyecto..."
if [ ! -f "package.json" ]; then
    print_error "No se encontró package.json. Ejecuta este script desde la raíz del proyecto."
    exit 1
fi
print_success "Directorio correcto"

# 2. Verificar AWS CLI
print_step "Verificando AWS CLI..."
if ! command -v aws &> /dev/null; then
    print_error "AWS CLI no está instalado"
    exit 1
fi
print_success "AWS CLI instalado"

# 3. Verificar credenciales AWS
print_step "Verificando credenciales AWS..."
if ! aws sts get-caller-identity &> /dev/null; then
    print_error "No hay credenciales AWS configuradas"
    exit 1
fi
print_success "Credenciales AWS configuradas"

# 4. Verificar que el bucket existe
print_step "Verificando bucket S3: $BUCKET_NAME..."
if ! aws s3 ls "s3://$BUCKET_NAME" &> /dev/null; then
    print_error "El bucket $BUCKET_NAME no existe"
    exit 1
fi
print_success "Bucket S3 existe"

# 5. Limpiar build anterior
print_step "Limpiando build anterior..."
rm -rf dist/
print_success "Build anterior eliminado"

# 6. Instalar dependencias (si es necesario)
print_step "Verificando dependencias..."
if [ ! -d "node_modules" ]; then
    print_warning "Instalando dependencias..."
    npm install
    print_success "Dependencias instaladas"
else
    print_success "Dependencias ya instaladas"
fi

# 7. Build del proyecto
print_step "Ejecutando build..."
npm run build
if [ $? -eq 0 ]; then
    print_success "Build completado exitosamente"
else
    print_error "Build falló"
    exit 1
fi

# 8. Verificar que el build generó archivos
if [ ! -d "dist" ] || [ -z "$(ls -A dist)" ]; then
    print_error "El directorio dist está vacío o no existe"
    exit 1
fi
print_success "Archivos de build generados"

# 9. Subir archivos a S3
print_step "Subiendo archivos a S3..."

# Subir todos los archivos excepto index.html con cache largo
aws s3 sync dist/ s3://$BUCKET_NAME/ \
    --delete \
    --cache-control "public, max-age=31536000, immutable" \
    --exclude "index.html" \
    --exclude "*.html"

# Subir archivos HTML sin cache
aws s3 sync dist/ s3://$BUCKET_NAME/ \
    --cache-control "public, max-age=0, must-revalidate" \
    --exclude "*" \
    --include "*.html"

if [ $? -eq 0 ]; then
    print_success "Archivos subidos a S3"
else
    print_error "Error al subir archivos a S3"
    exit 1
fi

# 10. Invalidar CloudFront (si está habilitado)
if [ "$INVALIDATE_CLOUDFRONT" = true ]; then
    if [ -z "$CLOUDFRONT_ID" ]; then
        print_warning "CLOUDFRONT_ID no está configurado. Saltando invalidación."
    else
        print_step "Invalidando cache de CloudFront..."
        aws cloudfront create-invalidation \
            --distribution-id "$CLOUDFRONT_ID" \
            --paths "/*" > /dev/null
        print_success "CloudFront invalidado"
    fi
fi

# 11. Mostrar información del deployment
echo ""
echo "╔════════════════════════════════════════╗"
echo "║         DEPLOYMENT EXITOSO            ║"
echo "╚════════════════════════════════════════╝"
echo ""
print_success "URL: http://$BUCKET_NAME.s3-website-$REGION.amazonaws.com"
print_success "Bucket: s3://$BUCKET_NAME"
print_success "Región: $REGION"
echo ""

# Mostrar tamaño del deployment
DIST_SIZE=$(du -sh dist/ | cut -f1)
print_success "Tamaño del build: $DIST_SIZE"

# Mostrar archivos principales
echo ""
echo "Archivos desplegados:"
ls -lh dist/ | grep -E '\.(html|css|js)$' | awk '{print "  - " $9 " (" $5 ")"}'

echo ""
print_success "Deployment completado en $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

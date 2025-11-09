#!/bin/bash

# ============================================
# Verificar configuración de dominio
# ============================================

set -e

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

DOMAIN="zuclubit.com"
WWW_DOMAIN="www.zuclubit.com"

echo ""
echo "╔════════════════════════════════════════╗"
echo "║   VERIFICACIÓN DE DOMINIO CUSTOM      ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Función para verificar
check_status() {
    local url=$1
    local name=$2

    echo -e "${BLUE}▶ Verificando $name...${NC}"

    # Test HTTP status
    status=$(curl -o /dev/null -s -w "%{http_code}" -L "$url" 2>/dev/null || echo "000")

    if [ "$status" = "200" ]; then
        echo -e "${GREEN}✓ $name - HTTP $status (OK)${NC}"

        # Verificar HTTPS
        if [[ $url == https://* ]]; then
            ssl_info=$(curl -vI "$url" 2>&1 | grep -E "SSL certificate|subject:" | head -2)
            echo -e "${GREEN}  ✓ HTTPS habilitado${NC}"
        fi

        return 0
    elif [ "$status" = "000" ]; then
        echo -e "${RED}✗ $name - No responde (DNS no configurado o no propagado)${NC}"
        return 1
    else
        echo -e "${YELLOW}⚠ $name - HTTP $status${NC}"
        return 1
    fi
}

# Función para verificar DNS
check_dns() {
    local domain=$1
    local name=$2

    echo -e "${BLUE}▶ Verificando DNS para $name...${NC}"

    cname=$(dig +short "$domain" CNAME | head -1)

    if [ -z "$cname" ]; then
        # Intentar con A record
        a_record=$(dig +short "$domain" A | head -1)
        if [ -z "$a_record" ]; then
            echo -e "${RED}✗ No hay registro DNS para $domain${NC}"
            return 1
        else
            echo -e "${YELLOW}⚠ Usando A record: $a_record${NC}"
            return 0
        fi
    else
        if [[ $cname == *"pages.dev"* ]]; then
            echo -e "${GREEN}✓ CNAME correcto: $cname${NC}"
            return 0
        else
            echo -e "${YELLOW}⚠ CNAME apunta a: $cname${NC}"
            echo -e "${YELLOW}  Debería apuntar a: zuclubit-site.pages.dev${NC}"
            return 1
        fi
    fi
}

# Verificar DNS
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " 1. VERIFICACIÓN DNS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_dns "$DOMAIN" "zuclubit.com"
DNS1=$?
echo ""

check_dns "$WWW_DOMAIN" "www.zuclubit.com"
DNS2=$?
echo ""

# Verificar conectividad HTTP/HTTPS
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " 2. VERIFICACIÓN HTTPS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_status "https://$DOMAIN" "https://zuclubit.com"
HTTP1=$?
echo ""

check_status "https://$WWW_DOMAIN" "https://www.zuclubit.com"
HTTP2=$?
echo ""

# Verificar CloudFlare Pages backup
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " 3. VERIFICACIÓN BACKUP (pages.dev)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

check_status "https://zuclubit-site.pages.dev" "CloudFlare Pages"
HTTP3=$?
echo ""

# Resumen
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo " RESUMEN"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

total_checks=5
passed_checks=0

[ $DNS1 -eq 0 ] && ((passed_checks++))
[ $DNS2 -eq 0 ] && ((passed_checks++))
[ $HTTP1 -eq 0 ] && ((passed_checks++))
[ $HTTP2 -eq 0 ] && ((passed_checks++))
[ $HTTP3 -eq 0 ] && ((passed_checks++))

if [ $passed_checks -eq $total_checks ]; then
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}✓ ¡TODO PERFECTO!${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${GREEN}✓ DNS configurado correctamente${NC}"
    echo -e "${GREEN}✓ HTTPS funcionando${NC}"
    echo -e "${GREEN}✓ Dominio custom activo${NC}"
    echo ""
    echo "URLs activas:"
    echo "  → https://zuclubit.com"
    echo "  → https://www.zuclubit.com"
    echo "  → https://zuclubit-site.pages.dev"
    echo ""
elif [ $passed_checks -ge 3 ]; then
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}⚠ PARCIALMENTE CONFIGURADO${NC}"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Verificaciones: $passed_checks/$total_checks pasaron"
    echo ""
    echo "Posibles causas:"
    echo "  - DNS aún propagándose (espera 5-10 minutos)"
    echo "  - Certificado SSL generándose"
    echo "  - Configuración incompleta"
    echo ""
    echo "Acciones:"
    echo "  1. Espera 5-10 minutos"
    echo "  2. Ejecuta este script nuevamente"
    echo "  3. Verifica CloudFlare Dashboard"
    echo ""
else
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}✗ CONFIGURACIÓN PENDIENTE${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Verificaciones: $passed_checks/$total_checks pasaron"
    echo ""
    echo "Acción requerida:"
    echo "  1. Ve al Dashboard: https://dash.cloudflare.com/pages/view/zuclubit-site"
    echo "  2. Click en 'Custom domains'"
    echo "  3. Agrega: zuclubit.com y www.zuclubit.com"
    echo "  4. Espera 2-5 minutos"
    echo "  5. Ejecuta este script nuevamente"
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Información adicional
if [ $HTTP1 -ne 0 ] || [ $HTTP2 -ne 0 ]; then
    echo "💡 Tips:"
    echo ""
    echo "  - Limpia cache DNS: sudo dscacheutil -flushcache"
    echo "  - Prueba en modo incógnito"
    echo "  - Verifica estado: https://www.cloudflarestatus.com/"
    echo ""
fi

echo "Ejecutado: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

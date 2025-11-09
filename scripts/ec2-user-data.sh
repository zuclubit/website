#!/bin/bash
################################################################################
# EC2 User Data Bootstrap Script - Zuclubit Website
# Este script descarga y ejecuta el deployment completo desde GitHub
################################################################################

set -e

SCRIPT_URL="https://raw.githubusercontent.com/zuclubit/website/main/scripts/ec2-user-data-full.sh"
SCRIPT_PATH="/tmp/ec2-user-data-full.sh"
LOG_FILE="/var/log/zuclubit-bootstrap.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "=== Bootstrap de Zuclubit Website ==="
log "Descargando script de deployment completo..."
log "URL: $SCRIPT_URL"

# Descargar el script completo desde GitHub
if curl -fsSL "$SCRIPT_URL" -o "$SCRIPT_PATH"; then
    log "✓ Script descargado exitosamente"
    log "Tamaño: $(du -h "$SCRIPT_PATH" | cut -f1)"
else
    log "✗ ERROR: No se pudo descargar el script"
    log "Verificando conectividad a GitHub..."
    curl -I https://github.com 2>&1 | tee -a "$LOG_FILE"
    exit 1
fi

# Hacer el script ejecutable
chmod +x "$SCRIPT_PATH"
log "✓ Permisos de ejecución configurados"

# Ejecutar el script completo
log "=== Iniciando deployment completo ==="
log "Ejecutando: $SCRIPT_PATH"
echo ""

if bash "$SCRIPT_PATH" 2>&1 | tee -a "$LOG_FILE"; then
    log ""
    log "=== Bootstrap completado exitosamente ==="
    exit 0
else
    EXIT_CODE=$?
    log ""
    log "✗ ERROR: El deployment falló con código: $EXIT_CODE"
    log "Revisar logs en: $LOG_FILE"
    log "Revisar logs de deployment en: /var/log/zuclubit-deployment.log"
    exit $EXIT_CODE
fi

# Sistema de Logging del Deployment - Zuclubit Website

## Versión 2.0 - Sistema de Logging Profesional

El script `ec2-user-data.sh` ha sido completamente mejorado con un sistema de logging robusto y profesional que proporciona feedback detallado durante todo el proceso de deployment.

## 🎯 Características Principales

### 1. Sistema de Logging Multi-Nivel

El script ahora utiliza diferentes tipos de logs para categorizar la información:

| Nivel | Símbolo | Uso |
|-------|---------|-----|
| **INFO** | ℹ | Inicio de cada paso del deployment |
| **SUCCESS** | ✓ | Operaciones completadas exitosamente |
| **ERROR** | ✗ | Errores críticos que detienen el deployment |
| **WARNING** | ⚠ | Advertencias que no detienen el proceso |
| **DETAIL** | → | Información adicional de cada paso |

### 2. Progreso Visual

Cada paso muestra un indicador de progreso:
```
[1/16] [08:30:15] Actualizando paquetes del sistema
  → Ejecutando: dnf update -y
✓ [08:31:42] Sistema actualizado correctamente
  ✓ Actualización del sistema completado
```

### 3. Funciones de Validación Automática

El script valida cada componente después de instalarlo:

- **validate_command()**: Verifica que comandos estén disponibles
- **validate_service()**: Confirma que servicios estén activos
- **validate_directory()**: Valida existencia de directorios
- **validate_file()**: Verifica archivos críticos

### 4. Medición de Tiempo

Operaciones largas incluyen medición de tiempo:
```
✓ [08:32:15] Repositorio clonado correctamente
  → Tiempo de clonación: 23s
```

### 5. Información Detallada

Cada paso proporciona información contextual relevante:

```
✓ [08:33:10] Node.js y npm instalados correctamente
✓ [08:33:11] Node.js está disponible: /usr/bin/node
✓ [08:33:11] npm está disponible: /usr/bin/npm
  → Node.js: v18.18.2
  → npm: 9.8.1
```

## 📊 16 Pasos del Deployment

1. **Actualización del sistema**
   - Actualiza paquetes de Amazon Linux 2023
   - Verifica actualizaciones exitosas

2. **Instalación de nginx**
   - Instala servidor web nginx
   - Valida comando nginx disponible
   - Reporta versión instalada

3. **Instalación de Node.js y npm**
   - Instala runtime de Node.js
   - Valida ambos comandos
   - Muestra versiones instaladas

4. **Instalación de Git**
   - Instala control de versiones Git
   - Verifica disponibilidad
   - Reporta versión

5. **Creación de directorios**
   - Crea `/var/www/zuclubit-site`
   - Valida existencia
   - Confirma directorio de trabajo

6. **Clonación del repositorio**
   - Clona desde GitHub
   - Mide tiempo de clonación
   - Muestra branch y último commit
   - Cuenta archivos clonados

7. **Verificación de estructura**
   - Valida `package.json`
   - Verifica `index.html`
   - Confirma `vite.config.js`
   - Cuenta archivos en `src/`

8. **Instalación de dependencias**
   - Ejecuta `npm install`
   - Mide tiempo de instalación
   - Cuenta paquetes instalados
   - Reporta tamaño de `node_modules`

9. **Construcción de la aplicación**
   - Ejecuta `npm run build`
   - Mide tiempo de build
   - Valida directorio `dist/`
   - Cuenta archivos generados
   - Reporta tamaño del bundle

10. **Configuración de nginx**
    - Crea archivo de configuración
    - Valida sintaxis con `nginx -t`
    - Confirma archivo creado

11. **Configuración de permisos**
    - Establece propietario nginx:nginx
    - Configura permisos 755
    - Muestra permisos resultantes

12. **Configuración de SELinux**
    - Detecta si SELinux está activo
    - Configura contextos si es necesario
    - Verifica contextos aplicados

13. **Inicio de nginx**
    - Habilita en arranque del sistema
    - Inicia el servicio
    - Valida que esté corriendo
    - Muestra PID del proceso
    - Lista puertos en escucha

14. **Configuración de firewall**
    - Detecta si firewalld está activo
    - Agrega reglas HTTP y HTTPS
    - Recarga configuración
    - Lista servicios activos

15. **Creación de scripts auxiliares**
    - Crea script de actualización
    - Hace ejecutable
    - Valida creación exitosa

16. **Verificación final**
    - Valida servicio nginx activo
    - Confirma directorio dist
    - Verifica index.html
    - Obtiene información de red
    - Realiza test HTTP local
    - Genera reporte final

## 📋 Reporte Final

Al finalizar el deployment, se genera un reporte completo:

```
═══════════════════════════════════════════════════════════════
  DEPLOYMENT COMPLETADO EXITOSAMENTE
═══════════════════════════════════════════════════════════════

╔════════════════════════════════════════════════════════════════╗
║                   ZUCLUBIT WEBSITE DEPLOYED                    ║
╚════════════════════════════════════════════════════════════════╝

📊 Estadísticas del Deployment:
   • Tiempo total: 5m 42s
   • Pasos completados: 16/16
   • Repositorio: https://github.com/zuclubit/website.git
   • Branch: main

🖥️  Información del Servidor:
   • Instance ID: i-0abc123def456
   • Availability Zone: us-east-2a
   • IP Pública: 3.14.159.265
   • Node.js: v18.18.2
   • npm: 9.8.1

🌐 Acceso Web:
   • URL: http://3.14.159.265
   • Estado: HTTP 200

📁 Archivos y Directorios:
   • Aplicación: /var/www/zuclubit-site
   • Archivos en dist: 12
   • Tamaño dist: 256K

📋 Logs y Configuración:
   • Deployment log: /var/log/zuclubit-deployment.log
   • Error log: /var/log/zuclubit-deployment-errors.log
   • nginx config: /etc/nginx/conf.d/zuclubit.conf
   • nginx access: /var/log/nginx/zuclubit-access.log
   • nginx error: /var/log/nginx/zuclubit-error.log

🔧 Comandos Útiles:
   • Ver logs: sudo tail -f /var/log/zuclubit-deployment.log
   • Estado nginx: sudo systemctl status nginx
   • Actualizar sitio: sudo /usr/local/bin/update-zuclubit.sh
   • Reiniciar nginx: sudo systemctl restart nginx

✅ Deployment finalizado: 2025-11-09 08:35:42
═══════════════════════════════════════════════════════════════
```

## 📁 Archivos de Log

### Deployment Log Principal
```bash
/var/log/zuclubit-deployment.log
```
Contiene toda la información del deployment inicial con timestamps, pasos completados, y detalles técnicos.

### Error Log
```bash
/var/log/zuclubit-deployment-errors.log
```
Captura específicamente errores y problemas para facilitar troubleshooting.

### Logs de nginx
```bash
/var/log/nginx/zuclubit-access.log  # Accesos HTTP
/var/log/nginx/zuclubit-error.log   # Errores de nginx
```

### Logs de actualizaciones
```bash
/var/log/zuclubit-updates.log
```
Registra todas las actualizaciones realizadas con el script de actualización.

## 🔍 Comandos de Monitoreo

### Ver logs en tiempo real

```bash
# Deployment log
sudo tail -f /var/log/zuclubit-deployment.log

# Cloud-init output (con colores)
sudo tail -f /var/log/cloud-init-output.log

# Errores específicos
sudo tail -f /var/log/zuclubit-deployment-errors.log

# Accesos web
sudo tail -f /var/log/nginx/zuclubit-access.log
```

### Buscar en logs

```bash
# Buscar errores
sudo grep "ERROR" /var/log/zuclubit-deployment.log

# Buscar warnings
sudo grep "WARNING" /var/log/zuclubit-deployment.log

# Ver solo pasos completados
sudo grep "completado" /var/log/zuclubit-deployment.log

# Ver tiempos de ejecución
sudo grep "Tiempo" /var/log/zuclubit-deployment.log
```

### Ver estadísticas del deployment

```bash
# Ver reporte final
sudo tail -50 /var/log/zuclubit-deployment.log

# Contar pasos exitosos
sudo grep -c "✓" /var/log/zuclubit-deployment.log

# Ver duración total
sudo grep "Tiempo total" /var/log/zuclubit-deployment.log
```

## 🛠️ Troubleshooting

### Si el deployment falla

1. **Verificar el error específico:**
   ```bash
   sudo grep "ERROR" /var/log/zuclubit-deployment.log
   sudo cat /var/log/zuclubit-deployment-errors.log
   ```

2. **Ver log completo de cloud-init:**
   ```bash
   sudo cat /var/log/cloud-init-output.log
   ```

3. **Verificar último paso exitoso:**
   ```bash
   sudo grep "completado" /var/log/zuclubit-deployment.log | tail -1
   ```

4. **Reintentar manualmente desde el paso que falló:**
   ```bash
   # Navegar al directorio
   cd /var/www/zuclubit-site

   # Ejecutar comando específico del paso que falló
   sudo npm install  # Por ejemplo
   ```

### Logs de componentes individuales

```bash
# Ver status de nginx
sudo systemctl status nginx -l

# Ver logs de systemd para nginx
sudo journalctl -u nginx -n 50

# Verificar sintaxis de nginx
sudo nginx -t

# Ver procesos de nginx
ps aux | grep nginx
```

## 💡 Mejores Prácticas

1. **Siempre revisar los logs después del deployment**
   ```bash
   sudo tail -100 /var/log/zuclubit-deployment.log
   ```

2. **Guardar reporte final para documentación**
   ```bash
   sudo tail -50 /var/log/zuclubit-deployment.log > ~/deployment-report.txt
   ```

3. **Monitorear errores periódicamente**
   ```bash
   sudo cat /var/log/zuclubit-deployment-errors.log
   ```

4. **Verificar que el sitio responda**
   ```bash
   curl -I http://localhost
   ```

## 🎨 Colores en los Logs

Los logs utilizan códigos de color ANSI que son visibles en:
- `/var/log/cloud-init-output.log`
- Output de terminal si ejecutas el script manualmente
- Herramientas de visualización que soporten colores ANSI

| Color | Significado |
|-------|-------------|
| 🔵 Azul | Información |
| 🟢 Verde | Éxito |
| 🔴 Rojo | Error |
| 🟡 Amarillo | Advertencia |
| 🔷 Cyan | Detalles |

## 📈 Mejoras Futuras Planificadas

- [ ] Notificaciones por email al completar deployment
- [ ] Integración con CloudWatch Logs
- [ ] Métricas de rendimiento durante el build
- [ ] Backup automático antes de actualizaciones
- [ ] Health checks periódicos post-deployment
- [ ] Alertas automáticas en caso de fallos

---

**Versión del Script:** 2.0
**Última Actualización:** 2025-11-09
**Mantenedor:** Zuclubit DevOps Team

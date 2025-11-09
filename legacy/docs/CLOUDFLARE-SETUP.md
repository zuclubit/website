# Configuración de CloudFlare para Zuclubit

Esta guía te llevará paso a paso para configurar CloudFlare y obtener HTTPS gratuito para tu sitio.

## ¿Por qué CloudFlare?

✅ **HTTPS gratuito** (certificado SSL automático)
✅ **CDN global** (450+ ubicaciones)
✅ **DDoS protection** incluido
✅ **WAF básico** (Web Application Firewall)
✅ **Cache inteligente** (reduce costos de S3)
✅ **Analytics** detallados

**Costo: $0/mes** (plan Free)

---

## Opción 1: Con Dominio Propio (zuclubit.com)

### Paso 1: Crear cuenta CloudFlare

1. Ve a https://www.cloudflare.com/
2. Click en "Sign Up"
3. Ingresa tu email y crea una contraseña
4. Verifica tu email

### Paso 2: Agregar tu dominio

1. Click en "Add a Site"
2. Ingresa tu dominio: `zuclubit.com`
3. Click en "Add site"
4. Selecciona el plan **Free** (es suficiente)
5. Click en "Continue"

### Paso 3: Escanear DNS existentes

CloudFlare escaneará tus registros DNS actuales (si los tienes).

### Paso 4: Agregar registro DNS para S3

En la sección "DNS Records":

```
Tipo:     CNAME
Nombre:   @
Destino:  zuclubit-website-1762706724.s3-website-us-east-1.amazonaws.com
Proxy:    ✅ Activado (nube naranja)
TTL:      Auto
```

Para subdominio `www`:
```
Tipo:     CNAME
Nombre:   www
Destino:  zuclubit-website-1762706724.s3-website-us-east-1.amazonaws.com
Proxy:    ✅ Activado (nube naranja)
TTL:      Auto
```

**Importante**: La nube naranja debe estar activada para usar CDN y HTTPS.

### Paso 5: Cambiar nameservers en tu registrador de dominio

CloudFlare te dará 2 nameservers, por ejemplo:
```
amber.ns.cloudflare.com
diego.ns.cloudflare.com
```

**Debes cambiarlos en donde compraste tu dominio:**

#### GoDaddy
1. Login a GoDaddy
2. My Products → Domain → DNS
3. Nameservers → Change → Custom
4. Ingresa los 2 nameservers de CloudFlare
5. Guarda los cambios

#### Namecheap
1. Login a Namecheap
2. Domain List → Manage
3. Nameservers → Custom DNS
4. Ingresa los 2 nameservers de CloudFlare
5. Save

#### Google Domains
1. Login a Google Domains
2. Manage → DNS
3. Name servers → Use custom name servers
4. Ingresa los 2 nameservers de CloudFlare
5. Save

**⏱ Propagación DNS: 2-48 horas** (usualmente 1-2 horas)

### Paso 6: Configurar SSL/TLS

Mientras esperas la propagación:

1. En CloudFlare Dashboard → SSL/TLS
2. Modo de cifrado: **Flexible**
3. Always Use HTTPS: **Activado** ✅
4. Automatic HTTPS Rewrites: **Activado** ✅

### Paso 7: Configurar Reglas de Cache

1. CloudFlare Dashboard → Caching → Configuration
2. **Caching Level**: Standard
3. **Browser Cache TTL**: 4 hours

### Paso 8: Configurar Page Rule (Opcional pero recomendado)

1. CloudFlare Dashboard → Rules → Page Rules
2. Click "Create Page Rule"
3. URL: `*zuclubit.com/*`
4. Settings:
   - Cache Level: **Cache Everything**
   - Edge Cache TTL: **a month**
5. Save

### Paso 9: Verificar configuración

Espera 1-2 horas y luego:

```bash
# Verificar DNS
dig zuclubit.com

# Verificar HTTPS
curl -I https://zuclubit.com
```

---

## Opción 2: Sin Dominio (Usar Workers de CloudFlare)

Si **NO tienes dominio propio**, puedes usar CloudFlare Workers para obtener HTTPS:

### Paso 1: Crear cuenta CloudFlare Workers

1. Ve a https://workers.cloudflare.com/
2. Sign up (gratuito)
3. Elige un subdominio: `zuclubit.workers.dev`

### Paso 2: Crear Worker

1. Click "Create a Worker"
2. Reemplaza el código con:

```javascript
// CloudFlare Worker para proxy a S3
const S3_URL = 'http://zuclubit-website-1762706724.s3-website-us-east-1.amazonaws.com';

addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {
  // Obtener la URL solicitada
  const url = new URL(request.url);

  // Construir URL de S3
  const s3Url = new URL(url.pathname + url.search, S3_URL);

  // Hacer request a S3
  const response = await fetch(s3Url, {
    method: request.method,
    headers: request.headers,
  });

  // Clonar respuesta para modificar headers
  const newResponse = new Response(response.body, response);

  // Agregar headers de seguridad
  newResponse.headers.set('X-Content-Type-Options', 'nosniff');
  newResponse.headers.set('X-Frame-Options', 'DENY');
  newResponse.headers.set('X-XSS-Protection', '1; mode=block');

  // Cache control
  if (url.pathname.includes('/assets/')) {
    newResponse.headers.set('Cache-Control', 'public, max-age=31536000, immutable');
  } else {
    newResponse.headers.set('Cache-Control', 'public, max-age=0, must-revalidate');
  }

  return newResponse;
}
```

3. Click "Save and Deploy"
4. Tu sitio estará en: `https://zuclubit.workers.dev` 🎉

**Ventajas**:
- ✅ HTTPS gratuito automático
- ✅ Dominio `*.workers.dev` incluido
- ✅ CDN global
- ✅ 100,000 requests/día gratis

---

## Opción 3: Dominio Temporal con FreeDNS

Si quieres un dominio memorable sin pagar:

### Paso 1: Obtener dominio gratuito

1. Ve a https://freedns.afraid.org/
2. Regístrate
3. Registry → New Domain
4. Elige un dominio: `zuclubit.mooo.com` (o similar)

### Paso 2: Configurar DNS

```
Type: CNAME
Subdomain: @
Destination: zuclubit-website-1762706724.s3-website-us-east-1.amazonaws.com
```

### Paso 3: Agregar a CloudFlare

Sigue los pasos de la Opción 1 pero con tu dominio gratuito.

---

## Verificación Final

Una vez configurado CloudFlare, verifica:

### 1. HTTPS funciona

```bash
curl -I https://tu-dominio.com
# Debe retornar: HTTP/2 200
```

### 2. Redirección HTTP → HTTPS

```bash
curl -I http://tu-dominio.com
# Debe retornar: 301 Moved Permanently
# Location: https://tu-dominio.com
```

### 3. Cache funciona

```bash
curl -I https://tu-dominio.com/assets/index.js
# Buscar header: cf-cache-status: HIT
```

### 4. Probar desde navegador

1. Abre https://tu-dominio.com
2. Click en el candado (🔒) en la barra de direcciones
3. Debe decir "Conexión segura"
4. Certificado emitido por CloudFlare

---

## Configuración Avanzada (Opcional)

### Security Headers

CloudFlare Dashboard → Transform Rules → Modify Response Header:

```
Header: Strict-Transport-Security
Value: max-age=31536000; includeSubDomains; preload

Header: Content-Security-Policy
Value: default-src 'self' https:; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com;

Header: X-Frame-Options
Value: DENY

Header: X-Content-Type-Options
Value: nosniff

Header: Referrer-Policy
Value: strict-origin-when-cross-origin
```

### Firewall Rules

CloudFlare Dashboard → Security → WAF:

1. Activar "OWASP Core Ruleset"
2. Crear regla custom para bloquear bots:

```
(cf.bot_management.score lt 30) and not (cf.bot_management.verified_bot)
Action: Block
```

### Rate Limiting

CloudFlare Dashboard → Security → Rate Limiting:

```
If incoming requests match:
  URL: *
  Method: ALL
Then:
  Limit: 100 requests
  Period: 1 minute
  Action: Block for 10 minutes
```

### Analytics & Monitoring

CloudFlare Dashboard → Analytics:

- Requests: Ver tráfico en tiempo real
- Performance: Tiempos de carga
- Security: Amenazas bloqueadas
- Cache: Hit ratio (objetivo: >90%)

---

## Troubleshooting

### Error 522: Connection timed out

**Causa**: CloudFlare no puede conectar con S3

**Solución**:
```bash
# Verificar que S3 sea accesible públicamente
curl -I http://zuclubit-website-1762706724.s3-website-us-east-1.amazonaws.com

# Si falla, revisar:
# 1. Bucket policy permite GetObject público
# 2. Website hosting está habilitado
# 3. URL del CNAME es correcta
```

### Error 525: SSL handshake failed

**Causa**: Modo SSL incorrecto

**Solución**:
1. CloudFlare → SSL/TLS
2. Cambiar a modo **Flexible**
3. Esperar 5 minutos

### Error 1000: DNS points to prohibited IP

**Causa**: Intentando usar IP directa en lugar de CNAME

**Solución**:
- Cambiar registro A por CNAME
- Usar URL de S3, no IP

### Sitio muestra contenido viejo

**Causa**: Cache de CloudFlare

**Solución**:
```bash
# Purgar cache desde Dashboard
CloudFlare → Caching → Purge Everything

# O usar API
curl -X POST "https://api.cloudflare.com/client/v4/zones/ZONE_ID/purge_cache" \
  -H "Authorization: Bearer YOUR_API_TOKEN" \
  -H "Content-Type: application/json" \
  --data '{"purge_everything":true}'
```

---

## Costos Comparados

| Configuración | Costo/mes | HTTPS | CDN | WAF |
|---------------|-----------|-------|-----|-----|
| **Solo S3** | $1 | ❌ | ❌ | ❌ |
| **S3 + CloudFlare** | $1 | ✅ | ✅ | ✅ |
| **S3 + CloudFront** | $2-3 | ✅ | ✅ | ❌ |
| **CloudFlare Workers** | $0-1 | ✅ | ✅ | ✅ |

## Mi Recomendación

Para Zuclubit, te recomiendo:

**Fase 1 (Ahora)**: S3 + CloudFlare Free
- Costo: $1/mes
- HTTPS inmediato
- CDN global
- Perfecto para MVP

**Fase 2 (Producción)**: S3 + CloudFlare Pro + CloudFront
- Costo: $20-25/mes
- Máximo rendimiento
- WAF avanzado
- 100% uptime SLA

---

## Próximos Pasos

Una vez CloudFlare esté configurado:

1. ✅ Actualizar el script `deploy.sh` con tu dominio
2. ✅ Configurar GitHub Actions para CI/CD automático
3. ✅ Implementar backend con Lambda + API Gateway
4. ✅ Configurar DynamoDB para base de datos
5. ✅ Agregar autenticación con Cognito

---

## Recursos

- **CloudFlare Docs**: https://developers.cloudflare.com/
- **CloudFlare Community**: https://community.cloudflare.com/
- **CloudFlare Status**: https://www.cloudflarestatus.com/
- **SSL Labs Test**: https://www.ssllabs.com/ssltest/

---

**¿Tienes dudas?** Déjame saber y te ayudo con cualquier paso.

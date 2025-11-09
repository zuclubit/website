# CloudFlare Pages - Guía Completa

## ✅ Estado Actual

**Tu sitio está LIVE en CloudFlare Pages con HTTPS:**

🌐 **URL**: https://zuclubit-site.pages.dev
🔒 **HTTPS**: Activado automáticamente
🚀 **CDN**: 330+ ubicaciones globales
💰 **Costo**: $0/mes

---

## 🎯 Ventajas de CloudFlare Pages

### vs S3 Solo

| Característica | S3 Solo | CloudFlare Pages |
|----------------|---------|------------------|
| **HTTPS** | ❌ | ✅ Gratis |
| **CDN** | ❌ | ✅ Global |
| **Costo** | $1/mes | $0/mes |
| **Deploy** | Manual | CLI/Git |
| **Preview URLs** | ❌ | ✅ |
| **Rollback** | Manual | 1 click |
| **Analytics** | ❌ | ✅ Incluido |

### vs CloudFront

| Característica | CloudFront | CloudFlare Pages |
|----------------|------------|------------------|
| **HTTPS** | ✅ Con ACM | ✅ Automático |
| **CDN** | ✅ 450 POPs | ✅ 330 POPs |
| **Costo** | $1-2/mes | $0/mes |
| **Setup** | 2-5 días | 5 minutos |
| **Verificación** | Requerida | No requerida |
| **WAF** | $10+/mes | ✅ Gratis |

---

## 🚀 Deployment

### Opción 1: CLI (Recomendado)

```bash
# Deploy a producción
./deploy-cloudflare.sh

# Deploy preview para testing
./deploy-cloudflare.sh --preview
```

### Opción 2: Git Integration (CI/CD Automático)

CloudFlare Pages puede auto-deployar desde Git:

#### Setup en Dashboard:

1. Ve a: https://dash.cloudflare.com/pages
2. Click en tu proyecto "zuclubit-site"
3. Settings → Builds & deployments
4. Connect to Git → Selecciona tu repo
5. Configuración:
   ```
   Build command: npm run build
   Build output: dist
   Root directory: /
   ```

**Beneficios:**
- ✅ Deploy automático en cada push
- ✅ Preview deployments en cada PR
- ✅ Rollback con un click
- ✅ Deploy logs completos

### Opción 3: Wrangler CLI directo

```bash
# Deploy manual
wrangler pages deploy dist --project-name=zuclubit-site

# Con branch específico
wrangler pages deploy dist --project-name=zuclubit-site --branch=production

# Preview deployment
wrangler pages deploy dist --project-name=zuclubit-site --branch=preview
```

---

## 📁 Estructura de Deployment

```
Tu código local
    ↓
npm run build (genera /dist)
    ↓
Wrangler CLI upload
    ↓
CloudFlare Pages (CDN global)
    ↓
https://zuclubit-site.pages.dev
```

---

## 🔧 Configuración Avanzada

### Custom Domain

#### Opción A: Dominio en CloudFlare

Si tu dominio ya está en CloudFlare:

1. Dashboard → Pages → zuclubit-site
2. Custom domains → Set up a custom domain
3. Agregar: `zuclubit.com` y `www.zuclubit.com`
4. CloudFlare configura DNS automáticamente
5. HTTPS se activa automáticamente

#### Opción B: Dominio externo

Si tu dominio está en otro registrador:

1. Dashboard → Pages → zuclubit-site → Custom domains
2. Agregar dominio: `zuclubit.com`
3. CloudFlare te dará registros DNS:
   ```
   CNAME: @ → zuclubit-site.pages.dev
   CNAME: www → zuclubit-site.pages.dev
   ```
4. Agrega estos registros en tu registrador (GoDaddy, Namecheap, etc.)
5. Espera propagación DNS (2-48 horas)

### Environment Variables

Para diferentes ambientes (producción, staging):

```bash
# Via CLI
wrangler pages secret put API_URL --project-name=zuclubit-site

# O en wrangler.toml
[env.production.vars]
API_URL = "https://api.zuclubit.com"
STRIPE_PUBLIC_KEY = "pk_live_..."

[env.preview.vars]
API_URL = "https://api-staging.zuclubit.com"
STRIPE_PUBLIC_KEY = "pk_test_..."
```

En tu código Svelte:
```javascript
const API_URL = import.meta.env.VITE_API_URL || 'http://localhost:3000';
```

### Redirects

Agregar a `wrangler.toml`:

```toml
# Redirect www a apex
[[redirects]]
from = "https://www.zuclubit.com/*"
to = "https://zuclubit.com/:splat"
status = 301

# Redirect old paths
[[redirects]]
from = "/old-page"
to = "/new-page"
status = 301

# SPA fallback (para rutas de Svelte)
[[redirects]]
from = "/*"
to = "/index.html"
status = 200
```

### Headers de Seguridad

Agregar a `wrangler.toml`:

```toml
[[headers]]
for = "/*"
[headers.values]
X-Frame-Options = "DENY"
X-Content-Type-Options = "nosniff"
X-XSS-Protection = "1; mode=block"
Referrer-Policy = "strict-origin-when-cross-origin"
Permissions-Policy = "geolocation=(), microphone=(), camera=()"

[[headers]]
for = "/assets/*"
[headers.values]
Cache-Control = "public, max-age=31536000, immutable"

[[headers]]
for = "/*.html"
[headers.values]
Cache-Control = "public, max-age=0, must-revalidate"
```

### Functions (CloudFlare Workers)

CloudFlare Pages incluye Functions (Workers) gratis:

Crea `functions/api/hello.js`:

```javascript
// Este endpoint estará en: https://zuclubit-site.pages.dev/api/hello
export async function onRequest(context) {
  return new Response(JSON.stringify({
    message: "Hello from CloudFlare Pages Function!",
    timestamp: new Date().toISOString()
  }), {
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    }
  });
}
```

**Límites del plan Free:**
- 100,000 requests/día
- 10ms CPU time/request

---

## 📊 Analytics & Monitoring

### Web Analytics (Gratis)

1. Dashboard → Pages → zuclubit-site → Analytics
2. Activar Web Analytics
3. Ver:
   - Page views
   - Unique visitors
   - Top pages
   - Countries
   - Devices/browsers

### Performance Metrics

CloudFlare Pages incluye:
- **Core Web Vitals**: LCP, FID, CLS
- **Requests**: Total, por país
- **Bandwidth**: Transfer out
- **Build logs**: Historial completo

### Real User Monitoring (RUM)

Agregar a `index.html`:

```html
<!-- CloudFlare Web Analytics -->
<script defer src='https://static.cloudflareinsights.com/beacon.min.js'
        data-cf-beacon='{"token": "YOUR_TOKEN"}'></script>
```

---

## 🔄 Rollback & Versioning

### Ver deployments

```bash
# Listar deployments
wrangler pages deployment list --project-name=zuclubit-site

# Ver detalles de un deployment
wrangler pages deployment tail --project-name=zuclubit-site
```

### Rollback desde Dashboard

1. Dashboard → Pages → zuclubit-site → Deployments
2. Ver lista de todos los deployments
3. Click en "..." → "Rollback to this deployment"
4. Confirmar

**Rollback instantáneo** - sin rebuild necesario!

### Preview Deployments

Cada branch genera una URL preview:

```
main → https://zuclubit-site.pages.dev (producción)
feature-x → https://feature-x.zuclubit-site.pages.dev
preview → https://preview.zuclubit-site.pages.dev
```

---

## 💰 Costos & Límites

### Plan Free (Actual)

```
✅ Requests: 100,000/día
✅ Bandwidth: 100 GB/mes
✅ Builds: 500/mes
✅ Concurrent builds: 1
✅ Deploy size: 25 MB
✅ Custom domains: Ilimitados
✅ HTTPS: Incluido
✅ Analytics: Básico
```

### Plan Pro ($20/mes)

```
✅ Requests: Ilimitados
✅ Bandwidth: Ilimitado
✅ Builds: 5,000/mes
✅ Concurrent builds: 5
✅ Deploy size: 100 MB
✅ Analytics: Avanzado
✅ Soporte prioritario
```

**Para 99% de proyectos, el plan Free es suficiente.**

---

## 🛠 Comandos Útiles

### Gestión del proyecto

```bash
# Ver información del proyecto
wrangler pages project list

# Ver deployments
wrangler pages deployment list --project-name=zuclubit-site

# Ver logs en tiempo real
wrangler pages deployment tail --project-name=zuclubit-site

# Eliminar proyecto (¡cuidado!)
wrangler pages project delete zuclubit-site
```

### Development local

```bash
# Desarrollar localmente con Wrangler
wrangler pages dev dist

# Con variables de entorno
wrangler pages dev dist --binding API_URL=http://localhost:3000

# Con hot reload (via npm)
npm run dev
```

### Testing

```bash
# Preview deployment para testing
./deploy-cloudflare.sh --preview

# Acceder a la preview URL
# https://[hash].zuclubit-site.pages.dev
```

---

## 🔐 Seguridad

### Access Control

CloudFlare Pages incluye Access (gratis para pequeños equipos):

```bash
# Proteger preview deployments
wrangler pages access add --project-name=zuclubit-site \
  --allow-email user@example.com
```

### WAF Rules

Configurar en Dashboard:

1. Security → WAF
2. Crear reglas custom:
   ```
   # Bloquear países específicos
   (ip.geoip.country in {"CN" "RU"}) → Block

   # Rate limiting
   (http.request.uri.path eq "/api/*") → Rate Limit (100/min)

   # Bot protection
   (cf.bot_management.score lt 30) → Challenge
   ```

### DDoS Protection

Incluido automáticamente en todos los planes.

---

## 🚨 Troubleshooting

### Build falla

```bash
# Ver logs detallados
wrangler pages deployment tail --project-name=zuclubit-site

# Verificar build local
npm run build

# Limpiar cache y rebuild
rm -rf node_modules dist
npm install
npm run build
```

### 404 en rutas (SPA)

Agregar redirect a `wrangler.toml`:

```toml
[[redirects]]
from = "/*"
to = "/index.html"
status = 200
```

### Cambios no se reflejan

```bash
# Limpiar cache CloudFlare
wrangler pages deployment purge-cache --project-name=zuclubit-site

# O desde Dashboard:
# Caching → Configuration → Purge Everything
```

### Error "Unauthorized"

```bash
# Re-autenticar
wrangler logout
wrangler login
```

---

## 📈 Optimizaciones

### Preload crítico

Agregar a `index.html`:

```html
<!-- Preload fonts -->
<link rel="preload" href="/assets/font.woff2" as="font" crossorigin>

<!-- Preconnect a APIs
<link rel="preconnect" href="https://api.zuclubit.com">

<!-- DNS prefetch -->
<link rel="dns-prefetch" href="https://fonts.googleapis.com">
```

### Lazy loading

En Svelte components:

```javascript
const HeavyComponent = () => import('./HeavyComponent.svelte');
```

### Image optimization

CloudFlare Images (opcional, $5/mes):

```html
<!-- Original -->
<img src="/images/hero.jpg">

<!-- CloudFlare Image Resizing -->
<img src="https://zuclubit-site.pages.dev/cdn-cgi/image/width=800,quality=85/images/hero.jpg">
```

---

## 🔗 Integración con Backend

### API Gateway + Lambda

```javascript
// En tu Svelte app
const API_URL = 'https://api.zuclubit.com';

async function fetchData() {
  const response = await fetch(`${API_URL}/users`);
  return response.json();
}
```

### CloudFlare Workers como Backend

Crear `functions/api/*.js` para endpoints serverless directamente en Pages.

---

## 📚 Recursos

- **Dashboard**: https://dash.cloudflare.com/pages
- **Docs**: https://developers.cloudflare.com/pages/
- **Wrangler Docs**: https://developers.cloudflare.com/workers/wrangler/
- **Community**: https://community.cloudflare.com/
- **Status**: https://www.cloudflarestatus.com/

---

## 🎉 Resumen

Has migrado exitosamente a CloudFlare Pages:

```
✅ HTTPS gratuito
✅ CDN global (330+ ubicaciones)
✅ Deploy en 30 segundos
✅ Costo: $0/mes
✅ Rollback instantáneo
✅ Analytics incluido
```

**Próximos pasos:**
1. Configurar dominio personalizado
2. Agregar backend con Functions o Lambda
3. Setup CI/CD con Git integration
4. Implementar monitoring avanzado

---

Tu sitio está ahora en la mejor infraestructura serverless posible! 🚀

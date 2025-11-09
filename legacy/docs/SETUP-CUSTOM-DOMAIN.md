# Configurar Dominio Personalizado - zuclubit.com

## 🎯 Objetivo
Configurar `zuclubit.com` para que apunte a tu sitio de CloudFlare Pages

---

## ✅ Requisitos
- ✅ Dominio `zuclubit.com` debe estar en CloudFlare (como nameserver)
- ✅ Proyecto CloudFlare Pages: `zuclubit-site` (ya creado)
- ✅ Acceso al Dashboard de CloudFlare

---

## 📋 Paso a Paso (5 minutos)

### Paso 1: Acceder a CloudFlare Pages

1. **Ir al Dashboard de CloudFlare Pages:**
   ```
   https://dash.cloudflare.com/pages
   ```

2. **Buscar y hacer click en tu proyecto:**
   - Busca: `zuclubit-site`
   - Click en el proyecto

### Paso 2: Agregar Dominio Custom

1. **En la página del proyecto, buscar la sección "Custom domains"**
   - Está en las pestañas superiores

2. **Click en "Set up a custom domain"** (o "Add domain")

3. **Ingresar tu dominio:**
   ```
   zuclubit.com
   ```

4. **Click en "Continue" o "Add domain"**

### Paso 3: Agregar Subdominios (Opcional pero Recomendado)

Repite el proceso para agregar `www`:

1. Click en "Set up a custom domain" nuevamente
2. Ingresar:
   ```
   www.zuclubit.com
   ```
3. Click en "Continue"

### Paso 4: Configuración Automática de DNS

**CloudFlare configurará automáticamente los registros DNS:**

Si tu dominio **YA ESTÁ en CloudFlare** (usando nameservers de CloudFlare):

✅ **CloudFlare agregará automáticamente:**
```
CNAME @ zuclubit-site.pages.dev
CNAME www zuclubit-site.pages.dev
```

Si tu dominio **NO ESTÁ en CloudFlare** (está en otro proveedor):

⚠️ **Deberás agregar manualmente estos registros en tu proveedor de DNS:**
```
Type:    CNAME
Name:    @
Target:  zuclubit-site.pages.dev
Proxy:   Yes (nube naranja) - solo si es posible

Type:    CNAME
Name:    www
Target:  zuclubit-site.pages.dev
Proxy:   Yes (nube naranja) - solo si es posible
```

### Paso 5: Esperar Activación

**Tiempo de propagación:**
- Si el dominio está en CloudFlare: **Instantáneo** (30 segundos - 2 minutos)
- Si el dominio está en otro proveedor: **2-48 horas** (típicamente 2-4 horas)

**Verificar estado:**
- En CloudFlare Pages → Custom domains
- Verás el estado: "Active" (verde) cuando esté listo

### Paso 6: HTTPS Automático

CloudFlare activará HTTPS automáticamente:
- ✅ Certificado SSL gratuito
- ✅ Auto-renovación
- ✅ Sin configuración adicional

**Tu sitio estará disponible en:**
- https://zuclubit.com ✅
- https://www.zuclubit.com ✅
- https://zuclubit-site.pages.dev ✅ (seguirá funcionando)

---

## 🔍 Verificación Rápida

### Verificar desde terminal:

```bash
# Verificar DNS (puede tardar unos minutos)
dig zuclubit.com

# Verificar que apunte a CloudFlare Pages
dig zuclubit.com CNAME

# Test HTTPS
curl -I https://zuclubit.com
```

### Verificar desde navegador:

1. Abre: https://zuclubit.com
2. Verifica el candado 🔒 en la barra de direcciones
3. Click en el candado → Debe decir "Conexión segura"

---

## 🎨 Configuración Avanzada (Opcional)

### Redirect www → apex (o viceversa)

Si quieres que `www.zuclubit.com` redirija a `zuclubit.com`:

1. CloudFlare Dashboard → Pages → zuclubit-site
2. Settings → Functions
3. Crear archivo `functions/_middleware.js`:

```javascript
export async function onRequest(context) {
  const url = new URL(context.request.url);

  // Redirect www to apex
  if (url.hostname === 'www.zuclubit.com') {
    return Response.redirect(
      `https://zuclubit.com${url.pathname}${url.search}`,
      301
    );
  }

  return context.next();
}
```

### Configurar redirects

Agregar a `wrangler.toml`:

```toml
[[redirects]]
from = "https://www.zuclubit.com/*"
to = "https://zuclubit.com/:splat"
status = 301

[[redirects]]
from = "/old-page"
to = "/new-page"
status = 301
```

### Headers personalizados

Agregar a `wrangler.toml`:

```toml
[[headers]]
for = "/*"
[headers.values]
X-Frame-Options = "DENY"
X-Content-Type-Options = "nosniff"
Strict-Transport-Security = "max-age=31536000; includeSubDomains; preload"
```

---

## 🚨 Troubleshooting

### Error: "Domain is already in use"

**Causa:** El dominio ya está asignado a otro proyecto CloudFlare Pages

**Solución:**
1. Busca en qué proyecto está el dominio:
   ```bash
   wrangler pages project list
   ```
2. Ve a ese proyecto y remueve el dominio
3. Luego agrégalo a `zuclubit-site`

### Error: "Unable to verify domain ownership"

**Causa:** El dominio no está en CloudFlare o los nameservers no están correctos

**Solución:**
1. Verifica que el dominio use nameservers de CloudFlare:
   ```bash
   dig NS zuclubit.com
   ```
2. Debe mostrar algo como:
   ```
   amber.ns.cloudflare.com
   diego.ns.cloudflare.com
   ```
3. Si no es así, debes transferir el dominio a CloudFlare o cambiar nameservers

### Dominio muestra "DNS_PROBE_FINISHED_NXDOMAIN"

**Causa:** DNS aún no propagado

**Solución:**
- Espera 5-10 minutos más
- Limpia cache DNS:
  ```bash
  # macOS
  sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

  # Linux
  sudo systemd-resolve --flush-caches

  # Windows
  ipconfig /flushdns
  ```

### Certificado SSL no activa

**Causa:** CloudFlare aún está generando el certificado

**Solución:**
- Espera 5-15 minutos
- CloudFlare genera certificados SSL automáticamente
- Si persiste después de 1 hora, contacta soporte CloudFlare

### Sitio muestra "Too many redirects"

**Causa:** Loop de redirección

**Solución:**
1. CloudFlare Dashboard → SSL/TLS
2. Cambiar modo a: **Full** (no Flexible, no Full Strict)
3. Espera 5 minutos

---

## 📊 Después de la Configuración

### Verificar que todo funcione:

```bash
# Test todas las URLs
curl -I https://zuclubit.com
curl -I https://www.zuclubit.com
curl -I https://zuclubit-site.pages.dev

# Todas deben retornar HTTP/2 200
```

### Actualizar scripts de deployment

Los scripts ya funcionarán automáticamente con tu dominio custom.

### Configurar SEO

Actualiza tu `index.html`:

```html
<!-- Canonical URL -->
<link rel="canonical" href="https://zuclubit.com" />

<!-- Open Graph -->
<meta property="og:url" content="https://zuclubit.com/" />

<!-- Twitter Card -->
<meta property="twitter:url" content="https://zuclubit.com/" />
```

---

## 🎯 Checklist Final

Después de configurar, verifica:

- [ ] https://zuclubit.com carga correctamente
- [ ] https://www.zuclubit.com carga correctamente
- [ ] HTTPS muestra candado verde 🔒
- [ ] Certificado SSL es válido (click en candado)
- [ ] No hay errores de "mixed content"
- [ ] Todos los assets cargan correctamente
- [ ] Sitio funciona en modo incógnito
- [ ] Sitio funciona desde diferentes dispositivos

---

## 📈 Métricas Post-Configuración

### CloudFlare Analytics

Una vez configurado, podrás ver:

1. **Dashboard → Analytics**
   - Requests por dominio
   - Bandwidth usage
   - Top countries
   - Devices/browsers

2. **Dashboard → Speed**
   - Core Web Vitals
   - Load times
   - Optimization score

3. **Dashboard → Security**
   - Threats blocked
   - Bot traffic
   - Security events

---

## 🎉 Resultado Final

Después de completar estos pasos, tendrás:

```
✅ zuclubit.com → Tu sitio CloudFlare Pages
✅ www.zuclubit.com → Tu sitio CloudFlare Pages
✅ HTTPS habilitado automáticamente
✅ Certificado SSL renovación automática
✅ CDN global (330+ ubicaciones)
✅ Sin cambios en deployment workflow
```

**URLs funcionales:**
- https://zuclubit.com (principal)
- https://www.zuclubit.com (con www)
- https://zuclubit-site.pages.dev (pages.dev seguirá funcionando)

---

## 📞 Soporte

Si tienes problemas:

1. **CloudFlare Support:**
   - Community: https://community.cloudflare.com/
   - Chat: Dashboard → Help → Chat

2. **Verificar estado:**
   - CloudFlare Status: https://www.cloudflarestatus.com/

3. **Documentación:**
   - Custom Domains: https://developers.cloudflare.com/pages/configuration/custom-domains/

---

**¡Tu dominio estará configurado en menos de 5 minutos!** 🚀

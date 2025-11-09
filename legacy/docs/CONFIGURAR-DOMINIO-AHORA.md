# ⚡ Configurar zuclubit.com AHORA (2 minutos)

## ✅ Estado: Tu dominio YA está en CloudFlare

```
✅ Dominio: zuclubit.com
✅ Nameservers: CloudFlare (mcgrory, melina)
✅ Proyecto Pages: zuclubit-site
✅ Todo listo para configurar
```

---

## 🚀 Pasos Exactos (2 minutos)

### 1. Abre el Dashboard de CloudFlare Pages

Click en este link:
```
https://dash.cloudflare.com/pages/view/zuclubit-site
```

O manualmente:
- Ve a: https://dash.cloudflare.com/pages
- Click en: `zuclubit-site`

### 2. Agregar Dominio Custom

1. **Busca la pestaña "Custom domains"** (arriba)
2. **Click en "Set up a custom domain"** (botón azul)
3. **Escribe:** `zuclubit.com`
4. **Click en "Continue"**

**CloudFlare hará automáticamente:**
- ✅ Crear registro CNAME
- ✅ Configurar DNS
- ✅ Activar HTTPS
- ✅ Generar certificado SSL

**Tiempo:** 30 segundos - 2 minutos

### 3. Agregar www (Recomendado)

Repite el paso 2 pero con:
```
www.zuclubit.com
```

**Resultado:**
- https://zuclubit.com → Tu sitio ✅
- https://www.zuclubit.com → Tu sitio ✅

---

## 🔍 Verificar que funcionó

### Desde el Dashboard

En CloudFlare Pages → Custom domains, verás:

```
✅ zuclubit.com - Active (verde)
✅ www.zuclubit.com - Active (verde)
```

### Desde terminal

```bash
# Verificar DNS
dig zuclubit.com CNAME +short

# Test HTTPS (espera 1-2 min si recién configuraste)
curl -I https://zuclubit.com
```

### Desde navegador

Abre: https://zuclubit.com

Debe mostrar tu sitio con candado 🔒

---

## 📋 Checklist Post-Configuración

- [ ] https://zuclubit.com funciona
- [ ] https://www.zuclubit.com funciona
- [ ] Candado verde 🔒 en ambos
- [ ] Certificado SSL válido
- [ ] Sitio carga rápido

---

## 🎉 ¡Listo!

Una vez configurado, tendrás:

```
✅ Dominio profesional (zuclubit.com)
✅ HTTPS gratuito
✅ CDN global
✅ Sin cambios en deployment
✅ Deploy sigue siendo: npm run deploy:cloudflare
```

**URLs finales:**
- https://zuclubit.com (⭐ principal)
- https://www.zuclubit.com
- https://zuclubit-site.pages.dev (backup)

---

## 🔧 Siguiente paso opcional

Una vez funcione, puedes configurar redirect de www → apex:

Crear `functions/_middleware.js`:

```javascript
export async function onRequest(context) {
  const url = new URL(context.request.url);

  if (url.hostname === 'www.zuclubit.com') {
    return Response.redirect(
      `https://zuclubit.com${url.pathname}${url.search}`,
      301
    );
  }

  return context.next();
}
```

Luego deploy:
```bash
npm run deploy:cloudflare
```

---

**Tiempo total: 2 minutos** ⚡

¡Empieza ahora! → https://dash.cloudflare.com/pages/view/zuclubit-site

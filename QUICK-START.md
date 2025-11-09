# Zuclubit - Quick Start Guide

## 🚀 URLs Activas

### Producción (CloudFlare Pages) - RECOMENDADO
```
🔒 HTTPS: https://zuclubit-site.pages.dev
📊 Dashboard: https://dash.cloudflare.com/pages/view/zuclubit-site
✅ Status: LIVE
💰 Costo: $0/mes
```

### Alternativa (S3 - Backup)
```
⚠️  HTTP: http://zuclubit-website-1762706724.s3-website-us-east-1.amazonaws.com
📊 AWS Console: https://s3.console.aws.amazon.com/s3/buckets/zuclubit-website-1762706724
⚠️  Status: LIVE (sin HTTPS)
💰 Costo: $1/mes
```

---

## ⚡ Deployment en 10 Segundos

### CloudFlare (Recomendado)
```bash
npm run deploy:cloudflare
```

### S3 (Backup)
```bash
npm run deploy:s3
```

---

## 📝 Comandos Comunes

### Desarrollo Local
```bash
npm run dev                    # http://localhost:5173
```

### Build
```bash
npm run build                  # Genera /dist
```

### Deploy
```bash
npm run deploy:cloudflare      # → CloudFlare Pages (producción)
npm run deploy:cloudflare:preview  # → Preview URL (testing)
npm run deploy:s3              # → S3 (backup)
```

---

## 🏗️ Arquitectura Actual

```
┌─────────────────────────────────────────────────────────┐
│  Usuario                                                │
└──────────────────┬──────────────────────────────────────┘
                   │
                   ▼
        ┌──────────────────────┐
        │  CloudFlare Pages    │ ⭐ PRINCIPAL
        │  - HTTPS automático  │
        │  - CDN (330+ POPs)   │
        │  - WAF incluido      │
        └──────────┬───────────┘
                   │
                   └─→ https://zuclubit-site.pages.dev


        ┌──────────────────────┐
        │  S3 Bucket (Backup)  │ 💾 ALTERNATIVA
        │  - HTTP solamente    │
        │  - Sin CDN           │
        └──────────────────────┘
```

---

## 📂 Estructura de Archivos

```
zuclubit-site/
├── src/                          # Código fuente Svelte
│   ├── App.svelte
│   ├── main.js
│   └── components/
├── dist/                         # Build output (generado)
├── deploy-cloudflare.sh          # 🚀 Deploy a CloudFlare
├── deploy.sh                     # Deploy a S3
├── wrangler.toml                 # Configuración CloudFlare
├── package.json                  # Scripts npm
└── Docs/
    ├── QUICK-START.md           # 👈 Este archivo
    ├── CLOUDFLARE-PAGES.md      # Guía completa CloudFlare
    ├── DEPLOYMENT.md            # Guía completa S3
    └── README-SERVERLESS.md     # Arquitectura serverless
```

---

## 🔧 Configuración

### Dominio Personalizado

1. **Ir a CloudFlare Dashboard:**
   https://dash.cloudflare.com/pages/view/zuclubit-site

2. **Custom domains → Add domain**
   - Agregar: `zuclubit.com`
   - CloudFlare configura DNS automáticamente
   - HTTPS se activa automáticamente

3. **Listo!** Tu sitio estará en:
   - https://zuclubit.com
   - https://www.zuclubit.com

### Variables de Entorno

Si necesitas API keys o configuración:

```bash
# Via CLI
wrangler pages secret put API_KEY --project-name=zuclubit-site

# O en wrangler.toml
[env.production.vars]
API_URL = "https://api.zuclubit.com"
```

---

## 🐛 Troubleshooting

### Cambios no se reflejan

```bash
# Limpiar cache
rm -rf dist node_modules
npm install
npm run build
npm run deploy:cloudflare
```

### Error en deployment

```bash
# Re-autenticar CloudFlare
wrangler logout
wrangler login

# Re-intentar
npm run deploy:cloudflare
```

### Ver logs

```bash
# CloudFlare
wrangler pages deployment tail --project-name=zuclubit-site

# Build local
npm run build
```

---

## 📊 Monitoreo

### CloudFlare Analytics
https://dash.cloudflare.com/pages/view/zuclubit-site/analytics

- Requests
- Bandwidth
- Page views
- Countries
- Devices

### Performance

```bash
# Test de velocidad
curl -w "@-" -o /dev/null -s https://zuclubit-site.pages.dev <<'EOF'
    time_namelookup:  %{time_namelookup}\n
       time_connect:  %{time_connect}\n
    time_appconnect:  %{time_appconnect}\n
      time_redirect:  %{time_redirect}\n
   time_pretransfer:  %{time_pretransfer}\n
 time_starttransfer:  %{time_starttransfer}\n
                    ----------\n
         time_total:  %{time_total}\n
EOF
```

---

## 🆘 Ayuda Rápida

| Pregunta | Respuesta |
|----------|-----------|
| ¿Cómo desplegar? | `npm run deploy:cloudflare` |
| ¿Cuál es mi URL? | https://zuclubit-site.pages.dev |
| ¿Tiene HTTPS? | ✅ Sí, automático |
| ¿Cuánto cuesta? | $0/mes (plan Free) |
| ¿Cómo hacer rollback? | Dashboard → Deployments → Rollback |
| ¿Preview URL? | `npm run deploy:cloudflare:preview` |
| ¿Dominio custom? | Dashboard → Custom domains |

---

## 🎯 Workflow Recomendado

### Desarrollo
```bash
1. git checkout -b feature/nueva-funcionalidad
2. npm run dev                           # Desarrollar
3. npm run build                         # Verificar build
4. npm run deploy:cloudflare:preview     # Preview URL
5. Revisar preview URL
6. git commit -m "Add nueva funcionalidad"
7. git push
```

### Producción
```bash
1. git checkout main
2. git merge feature/nueva-funcionalidad
3. npm run deploy:cloudflare             # Deploy a prod
4. Verificar: https://zuclubit-site.pages.dev
5. git tag -a v1.0.1 -m "Release v1.0.1"
6. git push --tags
```

---

## 📞 Soporte

### CloudFlare
- Dashboard: https://dash.cloudflare.com
- Docs: https://developers.cloudflare.com/pages/
- Community: https://community.cloudflare.com/
- Status: https://www.cloudflarestatus.com/

### AWS (S3 Backup)
- Console: https://console.aws.amazon.com/s3/
- Docs: https://docs.aws.amazon.com/s3/

---

## ✅ Checklist Post-Deployment

- [x] Sitio desplegado en CloudFlare Pages
- [x] HTTPS habilitado
- [x] CDN global activo
- [ ] Dominio personalizado configurado (zuclubit.com)
- [ ] Git integration para CI/CD
- [ ] Analytics configurado
- [ ] Backend/API implementado
- [ ] Monitoring/alertas configurados

---

**¡Tu sitio está LIVE y listo para escalar!** 🚀

Para más detalles, ver documentación completa en los archivos *.md

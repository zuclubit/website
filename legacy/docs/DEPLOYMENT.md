# Zuclubit - Guía de Deployment

## Arquitectura Serverless

```
Usuario → CloudFlare (CDN + HTTPS) → S3 (Static Hosting) → CloudFront (opcional)
```

## Recursos AWS Desplegados

- **S3 Bucket**: `zuclubit-website-1762706724`
- **Región**: `us-east-1` (Virginia)
- **URL Directa**: http://zuclubit-website-1762706724.s3-website-us-east-1.amazonaws.com

## Deployment Automático

### Uso Rápido

```bash
# Deploy normal a S3
./deploy.sh

# Deploy + invalidar CloudFront (cuando esté configurado)
./deploy.sh --cloudfront

# Ver ayuda
./deploy.sh --help
```

### Prerequisitos

1. AWS CLI instalado y configurado
2. Credenciales con permisos para:
   - S3: `PutObject`, `DeleteObject`, `ListBucket`
   - CloudFront: `CreateInvalidation` (opcional)
3. Node.js y npm instalados

### Configuración de AWS CLI

Si no tienes AWS CLI configurado:

```bash
aws configure
AWS Access Key ID: [TU_ACCESS_KEY]
AWS Secret Access Key: [TU_SECRET_KEY]
Default region name: us-east-1
Default output format: json
```

## Configurar CloudFlare (HTTPS Gratuito)

### Paso 1: Crear cuenta en CloudFlare

1. Ve a https://www.cloudflare.com/
2. Crea una cuenta gratuita
3. Agrega tu dominio (o crea un subdominio temporal)

### Paso 2: Configurar DNS

En CloudFlare Dashboard:

```
Tipo: CNAME
Nombre: @ (o www)
Contenido: zuclubit-website-1762706724.s3-website-us-east-1.amazonaws.com
Proxy: Activado (nube naranja)
TTL: Auto
```

### Paso 3: Configurar SSL/TLS

En CloudFlare → SSL/TLS:

```
Modo de cifrado: Flexible
Always Use HTTPS: Activado
Automatic HTTPS Rewrites: Activado
Minimum TLS Version: TLS 1.2
```

### Paso 4: Configurar Cache

En CloudFlare → Caching → Configuration:

```
Browser Cache TTL: 4 horas
Caching Level: Standard
```

### Paso 5: Configurar Page Rules (opcional)

```
URL: *zuclubit.com/*
Settings:
  - Cache Level: Cache Everything
  - Edge Cache TTL: 1 month
  - Browser Cache TTL: 1 day
```

## Estructura del Proyecto

```
zuclubit-site/
├── dist/                    # Build output (generado)
│   ├── index.html
│   └── assets/
│       ├── *.css
│       ├── *.js
│       └── *.png
├── src/                     # Código fuente
│   ├── App.svelte
│   ├── main.js
│   └── components/
├── deploy.sh               # Script de deployment
├── package.json
└── vite.config.js
```

## Comandos Útiles

### Build local

```bash
npm run build
```

### Preview local

```bash
npm run preview
```

### Desarrollo

```bash
npm run dev
```

### Ver contenido del bucket S3

```bash
aws s3 ls s3://zuclubit-website-1762706724/ --recursive --human-readable
```

### Sincronizar manualmente

```bash
aws s3 sync dist/ s3://zuclubit-website-1762706724/ --delete
```

### Descargar backup del bucket

```bash
aws s3 sync s3://zuclubit-website-1762706724/ ./backup/
```

## Monitoreo y Logs

### CloudFlare Analytics

- Dashboard → Analytics → Traffic
- Requests, bandwidth, cache ratio
- Geographic distribution

### AWS CloudWatch (cuando uses CloudFront)

```bash
aws cloudwatch get-metric-statistics \
  --namespace AWS/CloudFront \
  --metric-name Requests \
  --dimensions Name=DistributionId,Value=YOUR_DISTRIBUTION_ID \
  --start-time 2024-01-01T00:00:00Z \
  --end-time 2024-01-02T00:00:00Z \
  --period 3600 \
  --statistics Sum
```

## Costos Estimados (Tráfico bajo: 10K visitas/mes)

### Solo S3
- Storage (5GB): $0.12/mes
- Requests (10K): $0.01/mes
- Transfer OUT (10GB): $0.90/mes
- **Total**: ~$1/mes

### S3 + CloudFlare (Free Plan)
- S3: $1/mes
- CloudFlare: $0/mes (plan gratuito)
- **Total**: ~$1/mes
- **Beneficios**: HTTPS, CDN global, WAF básico

### S3 + CloudFront + CloudFlare
- S3: $1/mes
- CloudFront: $1-2/mes (con free tier)
- CloudFlare: $0/mes
- **Total**: ~$2-3/mes
- **Beneficios**: Máximo rendimiento, AWS WAF

## Troubleshooting

### Error: "NoSuchBucket"

```bash
# Verificar que el bucket existe
aws s3 ls | grep zuclubit
```

### Error: "AccessDenied"

```bash
# Verificar credenciales
aws sts get-caller-identity

# Verificar permisos del bucket
aws s3api get-bucket-policy --bucket zuclubit-website-1762706724
```

### Página no carga

1. Verificar archivos en S3:
   ```bash
   aws s3 ls s3://zuclubit-website-1762706724/
   ```

2. Verificar configuración de hosting:
   ```bash
   aws s3api get-bucket-website --bucket zuclubit-website-1762706724
   ```

3. Limpiar cache del navegador (Ctrl+Shift+R)

### CloudFlare muestra error 522

- Verificar que la URL de S3 es correcta en el CNAME
- Cambiar modo SSL a "Flexible"
- Esperar propagación DNS (hasta 24 horas)

## Seguridad

### S3 Bucket Policies

El bucket tiene política de lectura pública solo para GetObject:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::zuclubit-website-1762706724/*"
    }
  ]
}
```

### CloudFlare Security

- DDoS protection: Incluido en plan gratuito
- WAF: Reglas básicas incluidas
- Rate limiting: Disponible en planes pagos

## Próximos Pasos

- [ ] Configurar dominio personalizado (zuclubit.com)
- [ ] Habilitar CloudFront (requiere verificación AWS)
- [ ] Configurar CI/CD con GitHub Actions
- [ ] Implementar backend con Lambda + API Gateway
- [ ] Configurar AWS WAF
- [ ] Implementar monitoring con CloudWatch

## Soporte

Para problemas o preguntas:
- AWS Support: https://console.aws.amazon.com/support
- CloudFlare Support: https://support.cloudflare.com
- Documentación AWS S3: https://docs.aws.amazon.com/s3/
- Documentación CloudFlare: https://developers.cloudflare.com/

# Verificación de Cuenta AWS para CloudFront

## Por qué necesitas verificación

AWS requiere verificación manual de cuenta para crear recursos CloudFront en cuentas nuevas como medida de seguridad contra abuso.

## Cómo solicitar verificación

### Opción 1: AWS Support (Recomendado)

1. **Ir a AWS Support Center**
   - URL: https://console.aws.amazon.com/support/home

2. **Crear caso de soporte**
   - Click en "Create case"
   - Service: "Account and billing support" (es GRATIS)
   - Category: "Account"
   - Subject: "Request CloudFront service verification"

3. **Descripción del caso** (copia esto):

```
Subject: Request CloudFront Service Verification

Hello AWS Support,

I am trying to create a CloudFront distribution for my website but
receiving the following error:

"Your account must be verified before you can add new CloudFront
resources. To verify your account, please contact AWS Support."

Account ID: [TU_ACCOUNT_ID]
Use Case: Static website hosting for my business website (zuclubit.com)
Expected Traffic: Low to medium (< 100K requests/month)

Could you please verify my account to enable CloudFront resources?

Thank you.
```

4. **Obtener tu Account ID**:
```bash
aws sts get-caller-identity --query Account --output text
```

5. **Enviar caso**
   - Click "Submit"

### Tiempo de Respuesta

- **Típico**: 1-2 días hábiles
- **Máximo**: 3-5 días hábiles

### Qué esperar

AWS Support te enviará un email cuando:
1. Reciban tu solicitud (inmediato)
2. Estén procesando (1-24 horas)
3. Aprueben tu cuenta (1-2 días)

## Una vez aprobado

Cuando AWS verifique tu cuenta, ejecuta:

```bash
# Crear CloudFront distribution
aws cloudfront create-distribution \
  --distribution-config file://cloudfront-config.json

# El archivo cloudfront-config.json ya existe en /tmp/
# (fue generado durante el intento anterior)
```

## CloudFront vs CloudFlare - Comparación

| Característica | CloudFront | CloudFlare Free |
|----------------|------------|-----------------|
| **HTTPS** | ✅ Con ACM (gratis) | ✅ Gratis |
| **CDN** | ✅ 450+ ubicaciones | ✅ 330+ ubicaciones |
| **Costo/mes** | $1-2 | $0 |
| **Setup** | 2-5 días | 10 minutos |
| **WAF** | $10+/mes | ✅ Básico gratis |
| **DDoS** | ✅ Incluido | ✅ Incluido |
| **Cache control** | Avanzado | Bueno |
| **Lambda@Edge** | ✅ Sí | ❌ (Workers $5/mes) |
| **Integración AWS** | Perfecta | Buena |

## Mi Recomendación

### Para AHORA:
**Usa CloudFlare** mientras esperas verificación
- HTTPS inmediato
- Gratis
- Puedes cambiar después

### Para PRODUCCIÓN:
**CloudFront + CloudFlare**
```
Usuario → CloudFlare (WAF + DDoS)
         └→ CloudFront (CDN + Lambda@Edge)
            └→ S3 (Origin)
```

Beneficios de ambos:
- Doble CDN (máximo rendimiento)
- CloudFlare protege CloudFront
- Failover automático
- Mejor en cada continente

## Verificar estado de verificación

```bash
# Intentar crear distribución test
aws cloudfront create-distribution \
  --distribution-config file://cloudfront-config.json

# Si falla con mismo error → aún no verificado
# Si falla con otro error → verificado (ajustar config)
# Si funciona → ¡verificado!
```

## Alternativa: Route 53 Health Checks

Si AWS tarda mucho, puedes acelerar con:

1. Crear hosted zone en Route 53
2. Configurar health checks
3. AWS ve actividad legítima
4. Verificación puede ser más rápida

```bash
# Crear hosted zone
aws route53 create-hosted-zone \
  --name zuclubit.com \
  --caller-reference $(date +%s)
```

## Scripts para CloudFront (cuando esté listo)

### Crear distribución

```bash
#!/bin/bash
BUCKET_NAME="zuclubit-website-1762706724"

aws cloudfront create-distribution \
  --distribution-config file://cloudfront-config.json \
  --output json > cloudfront-info.json

# Obtener ID y URL
DIST_ID=$(cat cloudfront-info.json | jq -r '.Distribution.Id')
DIST_URL=$(cat cloudfront-info.json | jq -r '.Distribution.DomainName')

echo "CloudFront Distribution ID: $DIST_ID"
echo "CloudFront URL: https://$DIST_URL"
echo $DIST_ID > /tmp/cloudfront-dist-id.txt
```

### Invalidar cache

```bash
#!/bin/bash
DIST_ID=$(cat /tmp/cloudfront-dist-id.txt)

aws cloudfront create-invalidation \
  --distribution-id $DIST_ID \
  --paths "/*"
```

### Actualizar deploy.sh

Cuando tengas CloudFront, actualiza esta variable en `deploy.sh`:

```bash
CLOUDFRONT_ID="E1234ABCD5678"  # Tu Distribution ID
```

Luego puedes usar:
```bash
./deploy.sh --cloudfront
```

## Costos de CloudFront

### Free Tier (12 meses)
- 1 TB transfer OUT
- 10,000,000 requests HTTP/HTTPS
- 2,000,000 CloudFront Function invocations

### Después del Free Tier

**Transfer OUT:**
- Primeros 10 TB: $0.085/GB
- 10-50 TB: $0.080/GB

**Requests:**
- HTTP: $0.0075 per 10,000
- HTTPS: $0.010 per 10,000

**Ejemplo (10K visitas/mes, 10GB transfer):**
```
Transfer OUT (10GB): $0.85/mes
Requests (10K):      $0.10/mes
Total:               $0.95/mes
```

## Arquitectura Final Recomendada

Una vez tengas CloudFront verificado:

```
┌─────────────────────────────────────────┐
│  Usuario                                │
└──────────┬──────────────────────────────┘
           │
           ▼
    ┌─────────────┐
    │ CloudFlare  │ (opcional - WAF avanzado)
    └──────┬──────┘
           │
           ▼
    ┌──────────────┐
    │  CloudFront  │ (CDN + HTTPS + Lambda@Edge)
    └──────┬───────┘
           │
           ▼
    ┌─────────────┐
    │  S3 Bucket  │ (Origin - privado)
    └─────────────┘
```

**Beneficios:**
- Máxima seguridad (CloudFlare WAF)
- Máximo rendimiento (CloudFront CDN)
- Lambda@Edge para lógica en edge
- S3 puede ser privado (más seguro)

## Contactos Útiles

- **AWS Support**: https://console.aws.amazon.com/support/home
- **AWS CloudFront Forum**: https://forums.aws.amazon.com/forum.jspa?forumID=46
- **AWS Status**: https://status.aws.amazon.com/

---

**Resumen**: Por ahora usa CloudFlare (gratis, inmediato). Cuando AWS verifique tu cuenta, puedes agregar CloudFront encima para arquitectura híbrida.

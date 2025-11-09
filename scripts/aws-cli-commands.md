# Comandos AWS CLI para Zuclubit Website

## Configuración inicial

Asegúrate de tener configurado AWS CLI con tus credenciales:

```bash
# Verificar configuración
aws sts get-caller-identity

# Si necesitas configurar:
aws configure
```

## Opción 1: Script automatizado (Recomendado)

```bash
cd /Users/oscarvalois/Documents/Github/zuclubit-site/scripts
chmod +x create-ec2-instance.sh
./create-ec2-instance.sh
```

## Opción 2: Comandos manuales paso a paso

### 1. Obtener la AMI más reciente de Amazon Linux 2023 ARM64

```bash
AMI_ID=$(aws ec2 describe-images \
    --region us-east-2 \
    --owners amazon \
    --filters \
        "Name=name,Values=al2023-ami-2023*-kernel-6.1-arm64" \
        "Name=state,Values=available" \
    --query 'sort_by(Images, &CreationDate)[-1].ImageId' \
    --output text)

echo "AMI ID: $AMI_ID"
```

### 2. Obtener VPC predeterminada

```bash
VPC_ID=$(aws ec2 describe-vpcs \
    --region us-east-2 \
    --filters "Name=isDefault,Values=true" \
    --query 'Vpcs[0].VpcId' \
    --output text)

echo "VPC ID: $VPC_ID"
```

### 3. Crear Security Group

```bash
# Crear el security group
SG_ID=$(aws ec2 create-security-group \
    --region us-east-2 \
    --group-name zuclubit-web-sg \
    --description "Security group for Zuclubit website" \
    --vpc-id $VPC_ID \
    --query 'GroupId' \
    --output text)

echo "Security Group ID: $SG_ID"
```

### 4. Configurar reglas del Security Group

```bash
# SSH (puerto 22)
aws ec2 authorize-security-group-ingress \
    --region us-east-2 \
    --group-id $SG_ID \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

# HTTP (puerto 80)
aws ec2 authorize-security-group-ingress \
    --region us-east-2 \
    --group-id $SG_ID \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

# HTTPS (puerto 443)
aws ec2 authorize-security-group-ingress \
    --region us-east-2 \
    --group-id $SG_ID \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0
```

### 5. Lanzar la instancia EC2

```bash
INSTANCE_ID=$(aws ec2 run-instances \
    --region us-east-2 \
    --image-id $AMI_ID \
    --instance-type t4g.micro \
    --key-name devops_key_par \
    --security-group-ids $SG_ID \
    --user-data file:///Users/oscarvalois/Documents/Github/zuclubit-site/scripts/ec2-user-data.sh \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=zuclubit-website}]' \
    --metadata-options "HttpTokens=required,HttpPutResponseHopLimit=1,HttpEndpoint=enabled" \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "Instance ID: $INSTANCE_ID"
```

### 6. Esperar a que la instancia esté corriendo

```bash
aws ec2 wait instance-running \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID

echo "✅ Instancia corriendo!"
```

### 7. Obtener información de la instancia

```bash
aws ec2 describe-instances \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID \
    --query 'Reservations[0].Instances[0].[InstanceId,PublicIpAddress,PublicDnsName,State.Name]' \
    --output table
```

### 8. Obtener solo la IP pública

```bash
PUBLIC_IP=$(aws ec2 describe-instances \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

echo "IP Pública: $PUBLIC_IP"
echo "Web: http://$PUBLIC_IP"
echo "SSH: ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP"
```

## Comandos de gestión de la instancia

### Ver estado de la instancia

```bash
aws ec2 describe-instances \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID \
    --query 'Reservations[0].Instances[0].State.Name' \
    --output text
```

### Detener la instancia

```bash
aws ec2 stop-instances \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID
```

### Iniciar la instancia

```bash
aws ec2 start-instances \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID
```

### Reiniciar la instancia

```bash
aws ec2 reboot-instances \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID
```

### Terminar (eliminar) la instancia

```bash
aws ec2 terminate-instances \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID
```

### Ver logs del deployment

```bash
ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP \
    'sudo tail -f /var/log/zuclubit-deployment.log'
```

### Conectarse por SSH

```bash
ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP
```

### Ver estado de nginx

```bash
ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP \
    'sudo systemctl status nginx'
```

## Información de la configuración

**Región:** us-east-2 (Ohio)
**Tipo de instancia:** t4g.micro (ARM64 - Free Tier)
**AMI:** Amazon Linux 2023 (última versión)
**Key Pair:** devops_key_par
**Security Group:** zuclubit-web-sg

### Características Free Tier

- **t4g.micro**: 750 horas/mes gratis durante 12 meses
- **2 vCPUs ARM (Graviton2)**
- **1 GB RAM**
- **EBS**: 30 GB SSD gratis/mes
- **Transferencia de datos**: 100 GB salida/mes gratis

## Troubleshooting

### Si el user-data no se ejecuta correctamente

```bash
# Ver logs de cloud-init
ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP
sudo cat /var/log/cloud-init-output.log
```

### Si nginx no inicia

```bash
ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP
sudo journalctl -u nginx -n 50
```

### Verificar que el sitio se construyó correctamente

```bash
ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP
ls -la /var/www/zuclubit-site/dist/
```

## Scripts útiles

### Script de limpieza (eliminar todo)

```bash
#!/bin/bash
# Eliminar instancia
aws ec2 terminate-instances --region us-east-2 --instance-ids $INSTANCE_ID

# Esperar a que termine
aws ec2 wait instance-terminated --region us-east-2 --instance-ids $INSTANCE_ID

# Eliminar security group
aws ec2 delete-security-group --region us-east-2 --group-id $SG_ID

echo "✅ Recursos eliminados"
```

### Script de backup

```bash
#!/bin/bash
# Crear snapshot del volumen EBS
VOLUME_ID=$(aws ec2 describe-instances \
    --region us-east-2 \
    --instance-ids $INSTANCE_ID \
    --query 'Reservations[0].Instances[0].BlockDeviceMappings[0].Ebs.VolumeId' \
    --output text)

aws ec2 create-snapshot \
    --region us-east-2 \
    --volume-id $VOLUME_ID \
    --description "Backup de zuclubit-website $(date +%Y-%m-%d)"
```

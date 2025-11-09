#!/bin/bash
# Script para crear instancia EC2 para Zuclubit Website
# Región: us-east-2 (Ohio)
# Tipo: t4g.micro (ARM64 - Free Tier eligible)

set -e

# Variables de configuración
REGION="us-east-2"
INSTANCE_TYPE="t4g.micro"
KEY_NAME="devops_key_par"
INSTANCE_NAME="zuclubit-website"
SECURITY_GROUP_NAME="zuclubit-web-sg"

echo "=== Creando instancia EC2 para Zuclubit Website ==="
echo "Región: $REGION"
echo "Tipo: $INSTANCE_TYPE"

# 1. Obtener la AMI más reciente de Amazon Linux 2023 ARM64
echo -e "\n[1/5] Obteniendo AMI más reciente de Amazon Linux 2023 ARM64..."
AMI_ID=$(aws ec2 describe-images \
    --region $REGION \
    --owners amazon \
    --filters \
        "Name=name,Values=al2023-ami-2023*-kernel-6.1-arm64" \
        "Name=state,Values=available" \
    --query 'sort_by(Images, &CreationDate)[-1].ImageId' \
    --output text)

echo "AMI ID: $AMI_ID"

# 2. Obtener la VPC predeterminada
echo -e "\n[2/5] Obteniendo VPC predeterminada..."
VPC_ID=$(aws ec2 describe-vpcs \
    --region $REGION \
    --filters "Name=isDefault,Values=true" \
    --query 'Vpcs[0].VpcId' \
    --output text)

echo "VPC ID: $VPC_ID"

# 3. Crear o actualizar Security Group
echo -e "\n[3/5] Configurando Security Group..."

# Verificar si el security group ya existe
SG_ID=$(aws ec2 describe-security-groups \
    --region $REGION \
    --filters "Name=group-name,Values=$SECURITY_GROUP_NAME" "Name=vpc-id,Values=$VPC_ID" \
    --query 'SecurityGroups[0].GroupId' \
    --output text 2>/dev/null || echo "None")

if [ "$SG_ID" == "None" ] || [ -z "$SG_ID" ]; then
    echo "Creando nuevo Security Group..."
    SG_ID=$(aws ec2 create-security-group \
        --region $REGION \
        --group-name $SECURITY_GROUP_NAME \
        --description "Security group for Zuclubit website" \
        --vpc-id $VPC_ID \
        --query 'GroupId' \
        --output text)

    echo "Security Group creado: $SG_ID"

    # Agregar reglas de ingreso
    echo "Agregando regla SSH (puerto 22)..."
    aws ec2 authorize-security-group-ingress \
        --region $REGION \
        --group-id $SG_ID \
        --protocol tcp \
        --port 22 \
        --cidr 0.0.0.0/0

    echo "Agregando regla HTTP (puerto 80)..."
    aws ec2 authorize-security-group-ingress \
        --region $REGION \
        --group-id $SG_ID \
        --protocol tcp \
        --port 80 \
        --cidr 0.0.0.0/0

    echo "Agregando regla HTTPS (puerto 443)..."
    aws ec2 authorize-security-group-ingress \
        --region $REGION \
        --group-id $SG_ID \
        --protocol tcp \
        --port 443 \
        --cidr 0.0.0.0/0
else
    echo "Security Group ya existe: $SG_ID"
fi

# 4. Crear la instancia EC2
echo -e "\n[4/5] Lanzando instancia EC2..."

# Codificar el user-data script en base64
USER_DATA_SCRIPT="$(dirname "$0")/ec2-user-data.sh"

if [ ! -f "$USER_DATA_SCRIPT" ]; then
    echo "Error: No se encuentra el script ec2-user-data.sh"
    exit 1
fi

INSTANCE_ID=$(aws ec2 run-instances \
    --region $REGION \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SG_ID \
    --user-data file://$USER_DATA_SCRIPT \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
    --metadata-options "HttpTokens=required,HttpPutResponseHopLimit=1,HttpEndpoint=enabled" \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "Instancia creada: $INSTANCE_ID"

# 5. Esperar a que la instancia esté corriendo
echo -e "\n[5/5] Esperando a que la instancia esté corriendo..."
aws ec2 wait instance-running \
    --region $REGION \
    --instance-ids $INSTANCE_ID

echo -e "\n✅ Instancia corriendo!"

# Obtener información de la instancia
INSTANCE_INFO=$(aws ec2 describe-instances \
    --region $REGION \
    --instance-ids $INSTANCE_ID \
    --query 'Reservations[0].Instances[0].[PublicIpAddress,PublicDnsName]' \
    --output text)

PUBLIC_IP=$(echo $INSTANCE_INFO | awk '{print $1}')
PUBLIC_DNS=$(echo $INSTANCE_INFO | awk '{print $2}')

# Mostrar información
echo -e "\n=== Información de la instancia ==="
echo "Instance ID: $INSTANCE_ID"
echo "IP Pública: $PUBLIC_IP"
echo "DNS Público: $PUBLIC_DNS"
echo "Security Group: $SG_ID"
echo "AMI: $AMI_ID"
echo ""
echo "=== Acceso ==="
echo "SSH: ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP"
echo "Web: http://$PUBLIC_IP"
echo ""
echo "=== Comandos útiles ==="
echo "Ver estado: aws ec2 describe-instances --region $REGION --instance-ids $INSTANCE_ID"
echo "Detener: aws ec2 stop-instances --region $REGION --instance-ids $INSTANCE_ID"
echo "Iniciar: aws ec2 start-instances --region $REGION --instance-ids $INSTANCE_ID"
echo "Terminar: aws ec2 terminate-instances --region $REGION --instance-ids $INSTANCE_ID"
echo ""
echo "=== Logs de deployment ==="
echo "Espera 5-10 minutos para que se complete el deployment."
echo "Para ver logs: ssh -i ~/Documents/S3cts/zuclubit/site/devops_key_par.pem ec2-user@$PUBLIC_IP 'sudo tail -f /var/log/zuclubit-deployment.log'"
echo ""
echo "✅ Deployment iniciado exitosamente!"

# Módulos de Terraform para la infraestructura de AWS

Este repositorio contiene módulos de Terraform para desplegar una infraestructura en AWS, incluyendo un clúster EKS, configuraciones de red, instancias RDS y grupos de seguridad. A continuación, se describen los módulos y sus configuraciones.

## Módulos

### EKS (Elastic Kubernetes Service)
Archivo: `eks.tf`

Este módulo configura un clúster EKS y un grupo de nodos asociados. Los recursos principales incluyen:

- `aws_eks_cluster.cluster_obligatorio`: Configuración del clúster EKS.
  - `name`: Nombre del clúster.
  - `role_arn`: ARN del rol de IAM.
  - `version`: Versión de Kubernetes.
  - `vpc_config`: Configuración de la VPC para el clúster.

- `aws_eks_node_group.node_group_obligatorio`: Grupo de nodos del clúster EKS.
  - `cluster_name`: Nombre del clúster.
  - `node_group_name`: Nombre del grupo de nodos.
  - `node_role_arn`: ARN del rol de IAM para los nodos.
  - `scaling_config`: Configuración de escalado (tamaño deseado, mínimo y máximo).
  - `subnet_ids`: IDs de las subnets.

- `null_resource.kubectl`: Recurso para ejecutar un comando local de kubectl.
  - `command`: Comando para actualizar la configuración de kubeconfig.

### Network
Archivo: `network.tf`

Este módulo configura la red de AWS, incluyendo una VPC y dos subnets.

- `aws_vpc.vpc_obligatorio`: Configuración de la VPC.
  - `cidr_block`: Bloque CIDR de la VPC.
  - `enable_dns_support`: Habilitar soporte DNS.
  - `enable_dns_hostnames`: Habilitar nombres de host DNS.

- `aws_subnet.subnet_A_obligatorio`: Configuración de la Subnet A.
  - `vpc_id`: ID de la VPC.
  - `cidr_block`: Bloque CIDR de la subnet.
  - `availability_zone`: Zona de disponibilidad.
  - `map_public_ip_on_launch`: Mapear IP pública al lanzar.

- `aws_subnet.subnet_B_obligatorio`: Configuración de la Subnet B.
  - `vpc_id`: ID de la VPC.
  - `cidr_block`: Bloque CIDR de la subnet.
  - `availability_zone`: Zona de disponibilidad.
  - `map_public_ip_on_launch`: Mapear IP pública al lanzar.

### RDS (Relational Database Service)
Archivo: `rds.tf`

Este módulo configura una instancia RDS y un grupo de subnets para la base de datos.

- `aws_db_subnet_group.db_subnet_group`: Configuración del grupo de subnets para RDS.
  - `name`: Nombre del grupo de subnets.
  - `subnet_ids`: IDs de las subnets.

- `aws_db_instance.rds_obligatorio`: Configuración de la instancia RDS.
  - `identifier`: Identificador de la instancia.
  - `engine`: Motor de base de datos (e.g., MySQL).
  - `instance_class`: Clase de la instancia.
  - `allocated_storage`: Almacenamiento asignado (en GB).
  - `name`: Nombre de la base de datos.
  - `username`: Nombre de usuario.
  - `password`: Contraseña.
  - `parameter_group_name`: Nombre del grupo de parámetros.
  - `db_subnet_group_name`: Nombre del grupo de subnets.
  - `multi_az`: Si la instancia es multi-AZ.
  - `publicly_accessible`: Si la instancia es públicamente accesible.
  - `vpc_security_group_ids`: IDs de los grupos de seguridad.

### Security Groups
Archivo: `security-groups.tf`

Este módulo configura los grupos de seguridad necesarios para la infraestructura.

- `aws_security_group.sg_obligatorio`: Grupo de seguridad principal.
  - `ingress`: Reglas de entrada (e.g., SSH, HTTP).
  - `egress`: Reglas de salida.

- `aws_security_group.sg_db_obligatorio`: Grupo de seguridad para la base de datos.
  - `ingress`: Reglas de entrada (e.g., SSH, MySQL).
  - `egress`: Reglas de salida.

### Variables
Archivo: `vars.tf`

Este archivo define las variables utilizadas en los módulos anteriores.

- `vpc_cidr`: Bloque CIDR para la VPC.
- `subnet_A`: Bloque CIDR para la Subnet A.
- `subnet_B`: Bloque CIDR para la Subnet B.
- `az_1`: Zona de disponibilidad para la Subnet A.
- `az_2`: Zona de disponibilidad para la Subnet B.
- `region`: Región de AWS.
- `db_name`: Nombre de la base de datos.
- `db_user`: Nombre de usuario para la base de datos.
- `db_password`: Contraseña para la base de datos.

## Uso

Para usar estos módulos, asegúrate de tener configuradas las variables adecuadas en el archivo `vars.tf` y ejecuta los comandos de Terraform para desplegar la infraestructura.

```sh
terraform init
terraform plan
terraform apply

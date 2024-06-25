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


# Uso del módulo AWS en otra infraestructura

en este apartado proporcionamos instrucciones sobre cómo extraer y utilizar el módulo AWS del repositorio [Obligatorio-ISC](https://github.com/kevinmontaldo/Obligatorio-ISC) en su propia infraestructura.

## Requisitos

Antes de comenzar, asegúrese de cumplir con los siguientes requisitos:

1. **Cuenta de AWS**: Debe tener una cuenta de AWS con las credenciales configuradas.
2. **Terraform**: Debe tener Terraform instalado. Puede descargarlo desde [aquí](https://www.terraform.io/downloads.html).
3. **AWS CLI**: Debe tener AWS CLI instalado y configurado. Puede seguir las instrucciones [aquí](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

## Extracción del Módulo AWS

Para extraer y utilizar el módulo AWS del repositorio en su propia infraestructura, siga estos pasos:

1. **Clonar el repositorio**:
    ```sh
    git clone https://github.com/kevinmontaldo/Obligatorio-ISC.git
    ```

2. **Navegar al directorio del módulo AWS**:
    ```sh
    cd Obligatorio-ISC/modules/aws
    ```

3. **Copiar los archivos del módulo**:
    Copie los archivos relevantes del módulo AWS a su propio proyecto. Los archivos principales son:
    - `main.tf`
    - `provider.tf`
    - `vars.tf`
    - `terraform.tfvars`

4. **Configurar el perfil de AWS**:
    Asegúrese de tener configurado su perfil de AWS en `~/.aws/credentials`:
    ```ini
    [default]
    aws_access_key_id = YOUR_ACCESS_KEY
    aws_secret_access_key = YOUR_SECRET_KEY
    ```

5. **Modificar las variables**:
    Edite el archivo `terraform.tfvars` para adaptar las variables a su entorno y preferencias. Un ejemplo de variables puede ser:
    ```hcl
    region         = "us-east-1"
    vpc_cidr       = "10.0.0.0/16"
    subnet_A       = "10.0.1.0/24"
    subnet_B       = "10.0.2.0/24"
    az_1           = "us-east-1a"
    az_2           = "us-east-1b"
    db_name        = "mydatabase"
    db_user        = "admin"
    db_password    = "password"
    db_endpoint    = "mydb.cleardb.net"
    ```

6. **Inicializar y aplicar Terraform**:
    Navegue al directorio donde copió los archivos del módulo AWS y ejecute los siguientes comandos:
    ```sh
    terraform init
    terraform plan
    terraform apply 
    ```

## Contacto y soporte

Para cualquier duda o soporte adicional, puede crear un "issue" en el repositorio original o contactar a los integrantes del equipo:

- Kevin Montaldo - 292410
- Guillermo Ramirez - 292404
  
## Derechos reservados

© 2024 Kevin Montaldo y Guillermo Ramirez.

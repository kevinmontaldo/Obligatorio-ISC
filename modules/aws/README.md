### EKS (Elastic Kubernetes Service)
Archivo: `eks.tf`

Este archivo configura un clúster EKS y un grupo de nodos asociados. Los recursos principales incluyen:

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

Este archivo configura la red de AWS, incluyendo una VPC y dos subnets.

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

Este archivo configura una instancia RDS y un grupo de subnets para la base de datos.

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

Este archivo configura los grupos de seguridad necesarios para la infraestructura.

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

Para utilizar el módulo AWS del repositorio en su propia infraestructura, debe configurar las variables anteriores en un tfvars, a continuacion se muestra un ejemplo:

    ```sh
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

## Contacto y soporte

Para cualquier duda o soporte adicional, puede crear un "issue" en el repositorio original o contactar a los integrantes del equipo:

Kevin Montaldo - km292410@fi365.ort.edu.uy

Guillermo Ramirez - gr292404@fi365.ort.edu.uy


## Derechos reservados

© 2024 Kevin Montaldo y Guillermo Ramirez.

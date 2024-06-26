# Módulos de Terraform para Kubernetes en AWS

Este repositorio contiene módulos de Terraform para desplegar y gestionar aplicaciones en Kubernetes utilizando EKS (Elastic Kubernetes Service). A continuación, se describen los módulos y sus configuraciones.

## Módulos

### Despliegues Kubernetes
Archivo: `deployments.tf`

Este módulo configura varios recursos de Kubernetes, incluyendo ConfigMaps, Services, Jobs y Deployments.

- `kubectl_manifest.db-config`: Configuración de un ConfigMap para la base de datos.
  - `yaml_body`: Configuración YAML del ConfigMap que contiene las credenciales y endpoint de la base de datos.

- `kubectl_manifest.web-svc`: Configuración de un Service para la aplicación web.
  - `yaml_body`: Configuración YAML del Service, incluyendo el tipo de servicio (LoadBalancer), el selector y los puertos.
  - `depends_on`: Dependencia en el ConfigMap `db-config`.

- `kubectl_manifest.job-mysql-init`: Configuración de un Job para inicializar la base de datos MySQL.
  - `yaml_body`: Configuración YAML del Job, incluyendo la imagen Docker y el comando para inicializar la base de datos.
  - `depends_on`: Dependencia en el Service `web-svc`.

- `kubectl_manifest.web`: Configuración de un Deployment para la aplicación web.
  - `yaml_body`: Configuración YAML del Deployment, incluyendo el número de réplicas, los contenedores, las sondas de vivacidad y los volúmenes.
  - `depends_on`: Dependencia en el Job `job-mysql-init`.

### Proveedor
Archivo: `provider.tf`

Este archivo configura el proveedor de Terraform para Kubernetes.

- `terraform.required_providers`: Configuración del proveedor kubectl.
  - `kubectl`: Proveedor kubectl especificado por "gavinbunney/kubectl".

### Variables
Archivo: `vars.tf`

Este archivo define las variables utilizadas en los módulos anteriores.

- `region`: Región de AWS.
- `az_1`: Zona de disponibilidad.
- `db_name`: Nombre de la base de datos.
- `db_user`: Nombre de usuario de la base de datos.
- `db_password`: Contraseña de la base de datos.
- `db_endpoint`: Endpoint de la base de datos.

## Uso del módulo Kubernetes en otra infraestructura

Para extraer y utilizar el módulo Kubernetes del repositorio en su propia infraestructura, siga estos pasos:

1. **Clonar el repositorio**:
    ```sh
    git clone https://github.com/kevinmontaldo/Obligatorio-ISC.git
    ```

2. **Navegar al directorio del módulo Kubernetes**:
    ```sh
    cd Obligatorio-ISC/modules/kubernetes
    ```

3. **Copiar los archivos del módulo**:
   
    Copie los archivos relevantes del módulo Kubernetes a su propio proyecto. Los archivos principales son:
    - `deployments.tf`
    - `provider.tf`
    - `vars.tf`

5. **Configurar el perfil de AWS**:
   
    Asegúrese de tener configurado su perfil de AWS en `~/.aws/credentials`:
    ```ini
    [default]
    aws_access_key_id = YOUR_ACCESS_KEY
    aws_secret_access_key = YOUR_SECRET_KEY
    ```

6. **Modificar las variables**:
   
    Edite el archivo `vars.tf` para adaptar las variables a su entorno y preferencias. Un ejemplo de variables puede ser:
    ```hcl
    region         = "us-east-1"
    az_1           = "us-east-1a"
    db_name        = "your-db-name"
    db_user        = "your-db-user"
    db_password    = "your-db-password"
    db_endpoint    = "your-db-endpoint"
    ```

7. **Inicializar y aplicar Terraform**:
   
    Navegue al directorio donde copió los archivos del módulo Kubernetes y siga las [instrucciones de uso](https://github.com/kevinmontaldo/Obligatorio-ISC/tree/main?tab=readme-ov-file#instrucciones-de-uso) para inicializar y aplicar Terraform.

## Contacto y soporte

Para cualquier duda o soporte adicional, puede crear un "issue" en el repositorio original o contactar a los integrantes del equipo:

Kevin Montaldo - km292410@fi365.ort.edu.uy

Guillermo Ramirez - gr292404@fi365.ort.edu.uy


## Derechos reservados

© 2024 Kevin Montaldo y Guillermo Ramirez.

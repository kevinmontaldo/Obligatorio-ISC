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

## Uso

Para usar estos módulos, asegúrate de tener configuradas las variables adecuadas en el archivo `vars.tf` y ejecuta los comandos de Terraform para desplegar la infraestructura.

```sh
terraform init
terraform plan
terraform apply
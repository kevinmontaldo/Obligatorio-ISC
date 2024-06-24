# Módulos de Docker para Terraform en AWS

Este repositorio contiene módulos de Terraform para desplegar y gestionar imágenes Docker en AWS utilizando ECR (Elastic Container Registry). A continuación, se describen los módulos y sus configuraciones.

## Módulos

### ECR (Elastic Container Registry)
Archivo: `ecr.tf`

Este módulo configura un repositorio en ECR para almacenar las imágenes Docker.

- `aws_ecr_repository.web`: Configuración del repositorio ECR.
  - `force_delete`: Forzar eliminación del repositorio.
  - `name`: Nombre del repositorio.

### Imágenes Docker
Archivo: `imagenes.tf`

Este módulo construye y sube una imagen Docker para una aplicación web utilizando ECR.

- `docker_image.web`: Configuración para construir la imagen Docker.
  - `name`: Nombre de la imagen en el repositorio ECR.
  - `build`: Configuración de construcción.
    - `context`: Directorio de contexto para la construcción de la imagen.
    - `build_args`: Argumentos de construcción para la imagen (variables de entorno).

- `docker_registry_image.web`: Configuración para subir la imagen al registro Docker.
  - `name`: Nombre de la imagen en el repositorio ECR.
  - `depends_on`: Dependencias para asegurar el orden correcto de los recursos.

### Provider
Archivo: `provider.tf`

Este archivo configura el proveedor de Terraform para Docker.

- `terraform.required_providers`: Configuración del proveedor Docker.
  - `docker`: Proveedor Docker especificado por "kreuzwerker/docker".

### Variables
Archivo: `vars.tf`

Este archivo define las variables utilizadas en los módulos anteriores.

- `region`: Región de AWS.
- `db_endpoint`: Endpoint de la base de datos.
- `db_name`: Nombre de la base de datos.
- `db_user`: Nombre de usuario de la base de datos.
- `db_password`: Contraseña de la base de datos.
- `db_root_password`: Contraseña del usuario root de la base de datos.

## Uso

Para usar estos módulos, asegúrate de tener configuradas las variables adecuadas en el archivo `vars.tf` y ejecuta los comandos de Terraform para desplegar la infraestructura.

```sh
terraform init
terraform plan
terraform apply

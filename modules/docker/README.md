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

## Uso del módulo Docker en otra infraestructura

Para extraer y utilizar el módulo Docker del repositorio en su propia infraestructura, siga estos pasos:

1. **Clonar el repositorio**:
    ```sh
    git clone https://github.com/kevinmontaldo/Obligatorio-ISC.git
    ```

2. **Navegar al directorio del módulo Docker**:
    ```sh
    cd Obligatorio-ISC/modules/docker
    ```

3. **Copiar los archivos del módulo**:
    Copie los archivos relevantes del módulo Docker a su propio proyecto. Los archivos principales son:
    - `ecr.tf`
    - `imagenes.tf`
    - `provider.tf`
    - `vars.tf`

4. **Configurar el perfil de AWS**:
    Asegúrese de tener configurado su perfil de AWS en `~/.aws/credentials`:
    ```ini
    [default]
    aws_access_key_id = YOUR_ACCESS_KEY
    aws_secret_access_key = YOUR_SECRET_KEY
    ```

5. **Modificar las variables**:
    Edite el archivo `vars.tf` para adaptar las variables a su entorno y preferencias. Un ejemplo de variables puede ser:
    ```hcl
    region         = "us-east-1"
    db_endpoint    = "your-db-endpoint"
    db_name        = "your-db-name"
    db_user        = "your-db-user"
    db_password    = "your-db-password"
    db_root_password = "your-db-root-password"
    ```

6. **Inicializar y aplicar Terraform**:
    Navegue al directorio donde copió los archivos del módulo Docker y siga las [instrucciones de uso](https://github.com/kevinmontaldo/Obligatorio-ISC/tree/main?tab=readme-ov-file#instrucciones-de-uso) para inicializar y aplicar Terraform.

## Derechos reservados

© 2024 Kevin Montaldo y Guillermo Ramirez

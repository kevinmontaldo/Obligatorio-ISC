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

Este archivo especifica el provider requerido para Kubernetes.

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

Para utilizar el módulo Kubernetes del repositorio en su propia infraestructura, debe configurar las variables anteriores en un tfvars, a continuacion se muestra un ejemplo:

    ```hcl
    region         = "us-east-1"
    db_endpoint    = "your-db-endpoint"
    db_name        = "your-db-name"
    db_user        = "your-db-user"
    db_password    = "your-db-password"
    db_root_password = "your-db-root-password"
    ```

## Contacto y soporte

Para cualquier duda o soporte adicional, puede crear un "issue" en el repositorio original o contactar a los integrantes del equipo:

Kevin Montaldo - km292410@fi365.ort.edu.uy

Guillermo Ramirez - gr292404@fi365.ort.edu.uy


## Derechos reservados

© 2024 Kevin Montaldo y Guillermo Ramirez.

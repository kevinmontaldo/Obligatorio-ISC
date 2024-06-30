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
  - `yaml_body`: Configuración YAML del Deployment, incluyendo el número de réplicas, los contenedores, LivenessProbe y los volúmenes.
  - `depends_on`: Dependencia en el Job `job-mysql-init`.

### Proveedor
Archivo: `provider.tf`

Este archivo especifica el provider requerido para Kubernetes.

- `terraform.required_providers`: Configuración del proveedor kubectl.
  - `kubectl`: Proveedor kubectl especificado por "gavinbunney/kubectl".

### Variables
Archivo: `vars.tf`

Este archivo define las variables utilizadas.

- `region`: Región de AWS.
- `az_1`: Zona de disponibilidad.
- `db_name`: Nombre de la base de datos.
- `db_user`: Nombre de usuario de la base de datos.
- `db_password`: Contraseña de la base de datos.
- `db_endpoint`: Endpoint de la base de datos.

## Uso del módulo Kubernetes en otra infraestructura

Para utilizar el módulo Kubernetes de este repositorio en su propia infraestructura, es fundamental que tenga ya tenga los recursos en AWS ya desplegados. Puede tomar como referencia el despliegue del [módulo AWS](https://github.com/kevinmontaldo/Obligatorio-ISC/tree/main/modules/aws) para asegurarse de que todos los componentes necesarios estén presentes.

debe configurar las variables anteriores en un .tfvars, a continuacion se muestra un ejemplo:

  ```hcl
    region         = "us-east-1"
    az_1           = "us-east-1a"
    db_name        = "your-db-name"
    db_user        = "your-db-user"
    db_password    = "your-db-password"
    db_endpoint    = "your-db-endpoint"
  ```

## Contacto y soporte

Para cualquier duda o soporte adicional, puede crear un "issue" en el repositorio original o contactar a los integrantes del equipo:

Kevin Montaldo - km292410@fi365.ort.edu.uy

Guillermo Ramirez - gr292404@fi365.ort.edu.uy


## Derechos reservados

© 2024 Kevin Montaldo y Guillermo Ramirez.

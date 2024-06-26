# Obligatorio-ISC

## Información general

La URL de este repositorio es: [https://github.com/kevinmontaldo/Obligatorio-ISC](https://github.com/kevinmontaldo/Obligatorio-ISC)

Integrantes:

- Kevin Montaldo - 292410
- Guillermo Ramirez - 292404
## Diagrama general
![Diagrrama AWS](https://github.com/kevinmontaldo/Obligatorio-ISC/blob/main/Diagrama%20AWS.drawio.png)
## Módulos

Cada módulo realiza las actividades del provider correspondiente al módulo.

### AWS

El módulo de AWS contiene el código para implementar la infraestructura de la solución.
Se destacan los siguientes puntos:

- Network
  - VPC
  - Subnets
  - Internet Gateway
  - Route table
- Security Group
- Elastic Container Registry
  - Repositorio web
- Elastic Kubernetes Service
  - Cluster
  - Node Group
  - Conexión mediante kubectl
- Relational Database Service
  - Instancia de base de datos
  - Multi-AZ
  - Backups automatizados
- Scalable Storage in the Cloud
  - Versionado habilitado
  - Reglas de ciclo de vida para mover documentos a almacenamiento de menor costo

### Docker

El módulo de Docker crea la imagen de la aplicación de forma local y la almacena en un ECR.
Dicha imagen está almacenada en el directorio [imagenes-docker](imagenes-docker/apache-php).

### Kubernetes

El módulo de Kubernetes utiliza manifiestos para desplegar los recursos en EKS.
Se destacan los siguientes puntos:

- LivenessProbe en deployments web
- ConfigMap para configurar la conexión con la base de datos

## Documentación

- [Descripción del módulo AWS](modules/aws/README.md)
- [Descripción del módulo Docker](modules/docker/README.md)
- [Descripción imagen de Docker](imagenes-docker/apache-php/README.md)
- [Descripción del módulo Kubernetes](modules/kubernetes/README.md)

## Consideraciones

Debido a un problema con terraform, no es posible levantar toda la infraestructura con una sola ejecuccion del comando 'terraform apply', para hacer un despliegue desatendido se debe ejecutar el comando terraform apply -auto-approve 2 veces utlizando el operador ';'
El primer 'terraform apaply' deberia fallar y el segundo finalizar de forma exitosa.
## Instrucciones de uso

1. Configurar perfil en `~/.aws/credentials`.
2. Instalar Docker en la máquina local.
3. Instalar cliente de Kubernetes en la máquina local.
4. Clonar el repositorio ejecutando `git clone https://github.com/kevinmontaldo/Obligatorio-ISC.git`.
5. Modificar las variables en `terraform.tfvars` dependiendo de sus preferencias.
6. Inicializar el repositorio local ejecutando `terraform init`.
7. Entrar al directorio y ejecutar `terraform apply --auto-approve ; terraform apply --auto-approve`.
8. Obtener resultado del despliegue ejecutando `kubectl get all`.


## Contacto y soporte

Para cualquier duda o soporte adicional, puede crear un "issue" en el repositorio original o contactar a los integrantes del equipo:

Kevin Montaldo - km292410@fi365.ort.edu.uy

Guillermo Ramirez - gr292404@fi365.ort.edu.uy


## Derechos reservados

© 2024 Kevin Montaldo y Guillermo Ramirez.

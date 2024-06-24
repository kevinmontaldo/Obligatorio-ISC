# Obligatorio-ISC

## Informacion general

La url de este repositorio es: https://github.com/kevinmontaldo/Obligatorio-ISC

Integrantes:

- Kevin Montaldo - 292410
- Guillermo Ramirez - 292404

## Modulos

Cada modulo realiza las actividades del provider correspondiente al modulo.

### AWS

El modulo de aws contiene el codigo para implementar la infraestructura de la solucion.
Se destacan los siguientes puntos:

- Network
  - VPC
  - Subnets
  - Internet Gateway
  - Route table
- Security group
- Elastic Container Registry
  - Repositorio web
- Elastic Kubernetes Service
  - Cluster
  - Node Group
  - Conexion mediante kubectl
- Relational Database Service
  - Instancia de base de datos
  - Multi-AZ
  - Backups automatizados
- Scalable Storage in the Cloud
  - Versionado habilitado
  - Lifecycle rules para mover documentos a storage de menor costo


### Docker

El modulo de docker, crea la imagen de la aplicacion de forma local y la almacena en un ECR.
Dicha imagen esta almacenada en el directorio imagenes-docker.

### Kubernetes

El modulo de Kubernetes, utiliza manifiestos para desplegar los recursos en EKS.
Se destacan los siguientes puntos:

 - LivenessProbe en deployments web
 - ConfigMap para configurar la conexion con la base de datos
 
### Instrucciones de uso

- Configurar perfil en `~/.aws/credentials`
- Instalar Docker en maquina local
- Instalar cliente de Kubernetes
- Clonar el repositorio ejecutando "git clone https://github.com/kevinmontaldo/Obligatorio-ISC.git"
- Modificar las variables en terraform.tfvars dependiendo de sus preferencias
- Inicializar el repositorio local ejecutando `terraform init`
- Entrar al directorio y ejecutar "terraform apply --auto-approve"
- Obtener resultado del despliegue ejecutando "kubectl get all"

### Documentación

- [Descripción del módulo AWS](module/aws/README.md)
- [Descripción del módulo Docker](module/docker/README.md)
- [Descripción del módulo Kubernetes](module/kubernetes/README.md)




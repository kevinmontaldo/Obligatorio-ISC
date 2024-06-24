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

### Ejemplo de ejecuccion

$ kubectl get all
NAME                       READY   STATUS      RESTARTS   AGE
pod/job-mysql-init-c6v64   0/1     Completed   0          3m13s
pod/web-58f789fd97-5krvv   1/1     Running     0          3m13s
pod/web-58f789fd97-kr4j5   1/1     Running     0          3m13s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP                                                               PORT(S)        AGE
service/kubernetes   ClusterIP      10.100.0.1      <none>                                                                    443/TCP        16m
service/web          LoadBalancer   10.100.48.218   ab2eb36205003482cac28d4ad342a212-1521976150.us-east-1.elb.amazonaws.com   80:30551/TCP   3m13s

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/web   2/2     2            2           3m13s

NAME                             DESIRED   CURRENT   READY   AGE
replicaset.apps/web-58f789fd97   2         2         2       3m13s

NAME                       COMPLETIONS   DURATION   AGE
job.batch/job-mysql-init   1/1           33s        3m13s




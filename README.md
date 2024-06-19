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

- Network
  - VPC
  - Subnets
  - Internet Gateway
  - Route table
- Security group
- Elastic Container Registry
  - Repositorio db
  - Repositorio web
- Elastic Kubernetes Service
  - Cluster
  - Node Group
  - Conexion mediante kubectl


### Docker

El modulo de docker, crea las imagenes de la aplicacion y de la base de datos de forma local y las almacena en un ECR.
Dichas imagenes estan almacenadas en el directorio imagenes-docker.

### Kubernetes

El modulo de Kubernetes, utiliza manifiestos para desplegar los recursos en EKS.
Se utilizaron las siguientes caracteristicas dentro de los manifiestos:

 - LivenessProbe en deployments web
 - ConfigMap para configurar la conexion con la base de datos
 
### Instrucciones de uso

- Configurar perfil en `~/.aws/credentials`
- Clonar el repositorio ejecutando "git clone https://github.com/kevinmontaldo/Obligatorio-ISC.git"
- Modificar las variables en terraform.tfvars en caso de ser necesario
- Inicializar el repositorio local ejecutando `terraform init`
- Entrar al directorio y ejecutar "terraform apply --auto-approve"
- Obtener resultado del despliegue ejecutando "kubectl get all"

El despliegue se hace usando el equipo local para armar las imagenes de los servicios y subirlas al repositorio de ECR.

### Ejemplo de ejecuccion

kubectl get all

NAME                      READY   STATUS    RESTARTS   AGE
pod/db-5899b4b849-fl54t   1/1     Running   0          37s
pod/web-8949b49f5-8jbbc   1/1     Running   0          37s
pod/web-8949b49f5-clh6c   1/1     Running   0          37s

NAME                 TYPE           CLUSTER-IP       EXTERNAL-IP                                                               PORT(S)        AGE
service/db           ClusterIP      10.100.195.26    <none>                                                                    3306/TCP       37s
service/kubernetes   ClusterIP      10.100.0.1       <none>                                                                    443/TCP        6m35s
service/web          LoadBalancer   10.100.170.133   a0d78a2e3861147aa83a17aa8c58078e-1677858956.us-east-1.elb.amazonaws.com   80:31897/TCP   37s

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/db    1/1     1            1           37s
deployment.apps/web   2/2     2            2           37s

NAME                            DESIRED   CURRENT   READY   AGE
replicaset.apps/db-5899b4b849   1         1         1       37s
replicaset.apps/web-8949b49f5   2         2         2       37s

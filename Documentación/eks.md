
### Documentación/eks.md

```markdown
# Módulo EKS

Este archivo configura un clúster EKS y un grupo de nodos en AWS. Los recursos definidos son:

- **aws_eks_cluster.cluster_obligatorio**:
  - Crea un clúster EKS llamado `cluster_obligatorio`.
  - Utiliza un rol de IAM (`LabRole`) para el clúster.
  - Configura las subredes y los grupos de seguridad.

- **aws_eks_node_group.node_group_obligatorio**:
  - Define un grupo de nodos para el clúster EKS.
  - Configura el escalado automático del grupo de nodos.
  - Asocia el grupo de nodos con las subredes y el clúster EKS.

- **null_resource.kubectl**:
  - Ejecuta un comando local para actualizar la configuración de kubectl con el clúster EKS recién creado.

### Detalles Adicionales

- **aws_eks_cluster.cluster_obligatorio**:
  - `name`: Nombre del clúster EKS.
  - `role_arn`: ARN del rol IAM utilizado por el clúster.
  - `version`: Versión de Kubernetes utilizada.
  - `vpc_config`: Configuración de la VPC incluyendo subredes y grupos de seguridad.

- **aws_eks_node_group.node_group_obligatorio**:
  - `cluster_name`: Nombre del clúster EKS al que pertenece el grupo de nodos.
  - `node_group_name`: Nombre del grupo de nodos.
  - `node_role_arn`: ARN del rol IAM utilizado por los nodos.
  - `scaling_config`: Configuración de escalado automático.
  - `subnet_ids`: Lista de IDs de subredes donde se ubicarán los nodos.

- **null_resource.kubectl**:
  - `triggers`: Configuración para ejecutar siempre el comando local.
  - `provisioner "local-exec"`: Provisión que ejecuta el comando `aws eks --region ${var.region} update-kubeconfig --name cluster_obligatorio` para actualizar la configuración de kubectl.

Este módulo es crucial para la creación y gestión del clúster Kubernetes en AWS, permitiendo un despliegue eficiente y escalable de aplicaciones.

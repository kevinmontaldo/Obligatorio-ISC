

resource "aws_eks_cluster" "cluster_obligatorio" {
  name            = "cluster_obligatorio"
  role_arn        = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole" 
  version         = "1.26"
  vpc_config {
    subnet_ids                 = [aws_subnet.subnet_A_obligatorio.id, aws_subnet.subnet_B_obligatorio.id]
    security_group_ids         = [aws_security_group.sg_obligatorio.id] 
  }
}

resource "aws_eks_node_group" "node_group_obligatorio" {
  cluster_name    = aws_eks_cluster.cluster_obligatorio.name
  node_group_name = "node_group_obligatorio"
  node_role_arn   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/LabRole" 
  depends_on = [aws_eks_cluster.cluster_obligatorio]
  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 2
  }
  subnet_ids = [aws_subnet.subnet_A_obligatorio.id, aws_subnet.subnet_B_obligatorio.id]
}



resource "null_resource" "kubectl" {
  triggers = {
    always_run = "${timestamp()}"
  }
  depends_on = [aws_eks_node_group.node_group_obligatorio]
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name cluster_obligatorio"
  }
}

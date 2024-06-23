resource "aws_ecr_repository" "web" {
  force_delete = "true"
  name = "web"
}
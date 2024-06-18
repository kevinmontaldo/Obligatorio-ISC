resource "aws_ecr_repository" "db" {
  force_delete = "true"
  name = "db"
}

resource "aws_ecr_repository" "web" {
  force_delete = "true"
  name = "web"
}
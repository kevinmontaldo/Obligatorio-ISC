#Imagen para web
resource "docker_image" "web" {
  name         = "${local.aws_ecr_url}/web"
  build        {
    context    = "./imagenes-docker/apache-php/"
    build_args = {
      DB_ENDPOINT     = var.db_endpoint
      MYSQL_USER      = var.db_user
      MYSQL_PASSWORD  = var.db_password
      MYSQL_DATABASE  = var.db_name
    }
  }
}

resource "docker_registry_image" "web" {
  name = "${local.aws_ecr_url}/web"
  depends_on = [docker_image.web, aws_ecr_repository.web]
}
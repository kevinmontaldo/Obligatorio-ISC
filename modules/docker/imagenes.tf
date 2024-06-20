#Imagen para db
resource "docker_image" "db" {
  name         = "${local.aws_ecr_url}/db"
  build        {
    context    = "./imagenes-docker/mysql57/"
    build_args = {
      MYSQL_DATABASE = var.db_name
      MYSQL_USER = var.db_user
      MYSQL_PASSWORD = var.db_password
      MYSQL_ROOT_PASSWORD = var.db_root_password
    }
  }
}

#Imagen para web
resource "docker_image" "web" {
  name         = "${local.aws_ecr_url}/web"
  build        {
    context    = "./imagenes-docker/apache-php/"
  }
}

resource "docker_registry_image" "db" {
  name = "${local.aws_ecr_url}/db"
  depends_on = [docker_image.db]
}

resource "docker_registry_image" "web" {
  name = "${local.aws_ecr_url}/web"
  depends_on = [docker_image.web]
}
#Imagen para db
resource "docker_image" "db" {
  name         = "${local.aws_ecr_url}/db"
  build        {
    context    = "./imagenes-docker/mysql57/"
  }
}

resource "docker_registry_image" "db" {
  name = "${local.aws_ecr_url}/db"
}

#Imagen para web
resource "docker_image" "web" {
  name         = "${local.aws_ecr_url}/web"
  build        {
    context    = "./imagenes-docker/apache-php/"
  }
}

resource "docker_registry_image" "web" {
  name = "${local.aws_ecr_url}/web"
}
resource "aws_db_subnet_group" "db_subnet_group" {
  name = "db_subnet_group_obligatorio"
  subnet_ids = [aws_subnet.subnet_A_obligatorio.id, aws_subnet.subnet_B_obligatorio.id]

  tags = {
    Name = "db_subnet_group_obligatorio"
  }
}

resource "aws_db_instance" "rds_obligatorio" {
  allocated_storage    = 20
  db_name              = "${var.db_name}"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  identifier           = "rds-obligatorio"
  username             = "${var.db_user}"
  password             = "${var.db_password}"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.sg_db_obligatorio.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  backup_retention_period = 7
  backup_window           = "03:00-05:00"
  multi_az               = true
  depends_on = [aws_db_subnet_group.db_subnet_group]
}
resource "random_string" "dev-db-password" {
  length  = 32
  upper   = true
  number  = true
  special = false
}

resource "aws_db_instance" "dbdata" {
  identifier             = "dbdata"
  name                   = "dbdata"
  instance_class         = "db.t2.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "12.7"
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [aws_security_group.dev.id]
  username               = "dbdata"
  password               = "{random_string.dev-db-password.result}"
  }
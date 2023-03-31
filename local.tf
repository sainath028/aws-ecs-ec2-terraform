locals {
  instance_ami = data.aws_ami.ecs_ami.id
  vpc_cidr = "10.0.0.0/16"
  environment = "dev"
}
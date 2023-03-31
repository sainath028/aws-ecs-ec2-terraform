locals {
  instance_ami = data.aws_ami.ecs_ami.id
  tags = {
    Environment = "dev"
    Application = "ecs-ec2-app"
  }
  vpc_cidr = "10.0.0.0/16"
}

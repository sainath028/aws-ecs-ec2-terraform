data "aws_ami" "ecs_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }
}

resource "aws_launch_configuration" "ecs_launch_config" {
  image_id                    = local.instance_ami
  iam_instance_profile        = aws_iam_instance_profile.ecs.arn
  security_groups             = [aws_security_group.ecs_task.id]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=app-cluster >> /etc/ecs/ecs.config"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "ecs_ec2_asg" {
  name                 = "ECS EC2 ASG"
  vpc_zone_identifier  = aws_subnet.private.*.id
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
}


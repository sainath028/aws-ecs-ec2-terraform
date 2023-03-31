/* security group for ECS */
resource "aws_security_group" "ecs_task" {
  vpc_id = aws_vpc.default.id

  /* Created an inbound rule for ssh */
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["3.108.145.229/32"]
    security_groups = [aws_security_group.lb.id]
  }

  egress {
    description = "output from net"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = local.tags
}


# resource "aws_security_group" "ecs_task" {
#   name   = "ecs-task-security-group"
#   vpc_id = aws_vpc.default.id

#   ingress {
#     protocol        = "tcp"
#     from_port       = 80
#     to_port         = 80
#     security_groups = [aws_security_group.lb.id]
#   }

#   egress {
#     protocol    = "-1"
#     from_port   = 0
#     to_port     = 0
#     cidr_blocks = ["0.0.0.0/0"]
#   }
# }
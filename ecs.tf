resource "aws_ecs_cluster" "this" {
  name = "app-cluster"
}

# data "template_file" "task_definition_template" {
#   template = file("task-definitions/service.json.tpl")
#   vars = {
#     aws_cloudwatch_log_group = aws_cloudwatch_log_group.ecs.name
#   }
# }


# resource "aws_ecs_task_definition" "task_definition" {
#   family                   = "nginx"
#   container_definitions    = data.template_file.task_definition_template.rendered
#   requires_compatibilities = ["EC2"]
# }

# resource "aws_ecs_service" "nginx" {
#   name            = "nginx"
#   cluster         = aws_ecs_cluster.this.id
#   task_definition = aws_ecs_task_definition.task_definition.arn
#   launch_type     = "EC2"
#   desired_count   = 1

#   load_balancer {
#     target_group_arn = aws_lb_target_group.ecs.arn
#     container_name   = "nginx"
#     container_port   = 80
#   }

#   depends_on = [aws_lb_listener.http_forward]

#   tags = local.tags
# }
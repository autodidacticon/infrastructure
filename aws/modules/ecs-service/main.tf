resource "aws_cloudwatch_log_group" "logs" {
  name = var.service-name
}

resource "aws_ecs_task_definition" "definition" {
  family                = var.service-name
  cpu = 256
  memory = 512
  container_definitions = jsonencode([
    {
      cpu          = 256
      memory       = 512
      name         = var.service-name
      image        = var.image
      essential    = true
      portMappings = [
        {
          containerPort = var.port
          hostPort      = var.port
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options   = {
          awslogs-group         = aws_cloudwatch_log_group.logs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = var.service-name
        }
        secretOptions = null
      }
      environment = var.environment
    }
  ])
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn = var.execution-role-arn
}

resource "aws_ecs_service" "service" {
  name            = var.service-name
  cluster         = var.ecs-cluster-id
  task_definition = aws_ecs_task_definition.definition.arn
  desired_count   = 1

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    base = 0
    weight = 0
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    base = 0
    weight = 100
  }

  load_balancer {
    target_group_arn = var.target-group-arn
    container_name   = var.service-name
    container_port   = var.port
  }
  network_configuration {
    subnets = var.subnet-ids
    security_groups = var.security-groups
  }
}
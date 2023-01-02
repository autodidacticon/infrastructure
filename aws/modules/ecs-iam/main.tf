data "aws_iam_policy" "policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs-task-execution-role" {
  name               = "ecsTaskExecutionRole"
  managed_policy_arns = [data.aws_iam_policy.policy.arn]
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Sid       = "",
        Effect    = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

output "ecs-task-execution-role-arn" {
  value = aws_iam_role.ecs-task-execution-role.arn
}
resource "aws_ecs_task_definition" "flaskapp-main" {
  family                   = "my_flaskapp_test-main"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
   container_definitions    = <<TASK_DEFINITION
 [
    {
      "dnsSearchDomains": null,
      "environmentFiles": null,
      "logConfiguration": {
        "logDriver": "awslogs",
        "secretOptions": null,
        "options": {
          "awslogs-group": "/ecs/node",
          "awslogs-region": "us-east-1",
          "awslogs-stream-prefix": "ecs"
        }
      },
      "entryPoint": null,
      "portMappings":[
        {
          "hostPort": 5000,
          "protocol": "tcp",
          "containerPort": 5000
        }
      ],
      "command": null,
      "linuxParameters": null,
      "cpu": 0,
      "resourceRequirements": null,
      "ulimits": null,
      "dnsServers": null,
      "mountPoints": null,
      "workingDirectory": null,
      "secrets": null,
      "dockerSecurityOptions": null,
      "memory": null,
      "memoryReservation": null,
      "volumesFrom": [],
      "stopTimeout": null,
      "image":  "${data.aws_ecr_repository.example.repository_url}:${data.external.current_image.result["image_tag"]}",
      "startTimeout": null,
      "firelensConfiguration": null,
      "dependsOn": null,
      "disableNetworking": null,
      "interactive": null,
      "healthCheck": null,
      "essential": true,
      "links": [],
      "hostname": null,
      "extraHosts": null,
      "pseudoTerminal": null,
      "user": null,
      "readonlyRootFilesystem": null,
      "dockerLabels": null,
      "systemControls": null,
      "privileged": null,
      "name": "testapp"
    }
  ]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    
  }

}

resource "aws_ecs_service" "test-service-flaskapp-main" {
  name            = "testapp-service-flaskapp-main"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.flaskapp-main.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sg-all.id]
    subnets          = data.aws_subnets.subnet.ids
    assign_public_ip = true
  }
    load_balancer {
    target_group_arn = module.flaskapp-alb.elb-target-group-arn
    container_name   = "testapp"
    container_port   = 5000
  }

 
}

data "aws_ecr_repository" "example" {
  name = "flaskapp"
}


data "external" "current_image" {
  program = ["bash", "./ecr-image-filter.sh"]
}

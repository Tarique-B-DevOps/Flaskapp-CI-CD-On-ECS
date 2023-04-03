# Complete CI/CD pipeline for the Flaskapp on ECS with Github Actions and Terraform.

## Tools Used :
- Github Actions : Used to automate the CI/CD pipeline which includes stages like, Building image from Dockerfile, tagging it and pushing it to ECR repo and applying Terraform scripts to provision the infrastructure.
- **Terraform Scripts includes, ECS cluster, task definition, SG, iam roles, target group, and ALB**. 


- #### Pipeline = [Build Summary](https://github.com/Tarique-B-DevOps/Flaskapp-CI-CD-On-ECS/actions/runs/4593241508/jobs/8110982552) : [Deploy Summary](https://github.com/Tarique-B-DevOps/Flaskapp-CI-CD-On-ECS/actions/runs/4593241508/jobs/8110986530)

- #### Dockefile = [`Dockerfile`](Dockerfile)

- #### Pipeline Script = [`flaskapp-pipeline.yml`](.github/workflows/flaskapp-pipeline.yml)

- #### Terraform Configuration Files = [`terraform_iac`](terraform_iac)


# Screenshot

- ECS Fargate Cluster with Running Task :

![Cluster](https://user-images.githubusercontent.com/86839948/229345118-10d93366-9399-4ab4-90ff-d015fe2e42c9.jpg)

- Task Definition :

![task-def](https://user-images.githubusercontent.com/86839948/229345120-95b4f72a-9681-488c-8a32-df1728c80162.jpg)

- ECR Repository :

![ECR](https://user-images.githubusercontent.com/86839948/229345119-721f89e7-072f-4b97-a46f-23c0bda1742b.jpg)

- Application LoadBalancer

![ALB](https://user-images.githubusercontent.com/86839948/229345113-fd72b2b7-bbac-430c-8aee-decd7d0af837.jpg)

- Access Application on ALB URL :

![App](https://user-images.githubusercontent.com/86839948/229345117-16d3726b-38b4-4358-85c3-78d0b0a6557c.jpg)

variable "aws_region" {
  description = "region"
  type = string
  default = "us-east-1"
}
variable "my_alb_name" {
  default = "flaskapp-alb"
}
variable "my_tg_name" {
  default = "tg-with-terra"
}
variable "my-task-def-name" {
  default = "node-mysql-terra"
}

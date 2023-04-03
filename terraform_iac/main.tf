provider "aws" {
  region  = var.aws_region
#   profile = default
  
}
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.33.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "terraforms3states"
    key    = "gha/tf.state"
    region =  "us-east-1"
    encrypt = true
  }
}

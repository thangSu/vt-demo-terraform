provider "aws" {
  region = "ap-southeast-1"
}
terraform {
  backend "local" {
    path = "./data/terraform.tfstate"
  }
  required_providers {
    aws = {
      version = "4.63.0"
      source = "hashicorp/aws"
    }
  }
}
# terraform {
#   required_providers {
#     terraform = {
#       source = "hashicorp/terraform"
#       version = "~> <TERRAFORM VERSION>"
#     }
#   }
# }

provider "aws" {
  region = "us-east-2"
}
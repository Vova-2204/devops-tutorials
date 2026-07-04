remote_state {
  backend = "s3"
  config = {
    bucket         = "vladimir-terragrunt-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-central-1"
    encrypt        = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "skip"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "skip"
  contents  = <<-EOF
    provider "aws" {
      region = "eu-central-1"
    }
  EOF
}

generate "versions" {
  path      = "versions.tf"
  if_exists = "skip"
  contents  = <<-EOF
    terraform {
      required_version = ">= 1.0"

      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = ">= 5.30.0"
        }
      }
    }
  EOF
}

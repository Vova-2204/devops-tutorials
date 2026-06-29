locals {
  aws_region = "eu-central-1"
  azs        = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]

  tags = {
    Region    = "eu-central-1"
    Terraform = "true"
    Owner     = "vladimir.shubodyorov"
  }
}

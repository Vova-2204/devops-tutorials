locals {
  aws_region  = "eu-central-1"
  azs         = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  ssh_key_id  = "devops-tutorials"
  default_ami = "ami-0f92e2dae65c68e2f"

  tags = {
    Region    = "eu-central-1"
    Terraform = "true"
    Owner     = "vladimir.shubodyorov"
  }
}
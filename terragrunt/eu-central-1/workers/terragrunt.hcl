terraform {
  source = "${get_repo_root()}/terragrunt/modules/cluster"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  tags        = merge(local.region_vars.locals.tags, { role = "workers" })
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id         = "vpc-00000000000000000"
    public_subnets = ["subnet-00000000000000000"]
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
  name           = "worker"
  instance_count = 2
  vpc_id         = dependency.vpc.outputs.vpc_id
  subnet_id      = dependency.vpc.outputs.public_subnets[0]
  ami_id         = local.region_vars.locals.default_ami
  instance_type  = "t3.micro"
  key_name       = local.region_vars.locals.ssh_key_id

  tags = local.tags
}

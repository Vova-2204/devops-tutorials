terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws//modules/vpc-endpoints?version=5.8.1"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  tags        = local.region_vars.locals.tags
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id                  = "vpc-00000000000000000"
    public_route_table_ids  = ["rtb-00000000000000000"]
    private_route_table_ids = ["rtb-00000000000000000"]
  }
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id

  endpoints = {
    s3 = {
      service         = "s3"
      service_type    = "Gateway"
      route_table_ids = concat(
        dependency.vpc.outputs.public_route_table_ids,
        dependency.vpc.outputs.private_route_table_ids,
      )
    }
  }

  tags = local.tags
}

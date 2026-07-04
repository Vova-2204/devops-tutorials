terraform {
  source = "tfr:///terraform-aws-modules/vpc/aws?version=5.8.1"
}

include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  tags        = local.region_vars.locals.tags
}

inputs = {
  name = "devops-tutorials"
  cidr = "10.100.0.0/24"

  azs = local.region_vars.locals.azs

  # 10.100.0.0/24 split into four /26 blocks (64 IPs each):
  #   public:  10.100.0.0/26   (0–63)
  #   private: 10.100.0.64/26  (64–127)
  #            10.100.0.128/26 (128–191)
  #            10.100.0.192/26 (192–255)
  public_subnets  = ["10.100.0.0/26"]
  private_subnets = ["10.100.0.64/26", "10.100.0.128/26", "10.100.0.192/26"]

  enable_nat_gateway   = false
  single_nat_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true

  tags = local.tags
}

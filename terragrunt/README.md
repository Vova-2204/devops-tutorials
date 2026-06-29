# Terragrunt Infrastructure

AWS infrastructure managed with [Terragrunt](https://terragrunt.gruntwork.io/), using community modules from the [Terraform Registry](https://registry.terraform.io/).

## Structure

```
terragrunt/
├── root.hcl                        # Root config: remote state, provider, required providers
└── eu-central-1/
    ├── region.hcl                  # Region-level locals: region name, AZs, shared tags
    └── vpc/
        └── terragrunt.hcl          # VPC with public and private subnets
```

## Root Configuration (`root.hcl`)

Inherited by all child modules via `include "root"`. Provides:

- **Remote state** — S3 bucket `vladimir-terragrunt-state`, per-module key, encrypted, with DynamoDB lock table `terragrunt-state-lock`
- **AWS provider** — generated into each module, region resolved from `region.hcl`
- **Required providers** — AWS `~> 5.0`, Terraform `>= 1.0`

## Regions

### `eu-central-1` (Frankfurt)

| Local | Value |
|---|---|
| `aws_region` | `eu-central-1` |
| `azs` | `eu-central-1a`, `eu-central-1b`, `eu-central-1c` |
| `tags` | `Region`, `Terraform`, `Owner` |

Tags in `region.hcl` are applied to all resources deployed under this region folder.

#### VPC (`eu-central-1/vpc`)

Module: [`terraform-aws-modules/vpc/aws`](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest) `v5.8.1`

| Parameter | Value |
|---|---|
| CIDR | `10.100.0.0/24` |
| Public subnets | `10.100.0.0/26` (eu-central-1a) |
| Private subnets | `10.100.0.64/26`, `10.100.0.128/26`, `10.100.0.192/26` |
| NAT Gateway | disabled |
| DNS hostnames | enabled |

## Usage

```bash
# Plan a single module
cd eu-central-1/vpc
terragrunt plan

# Apply a single module
terragrunt apply

# Plan all modules in the region
cd eu-central-1
terragrunt run-all plan
```

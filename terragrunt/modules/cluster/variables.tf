variable "name" {
  type        = string
  description = "Base name for cluster instances"
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to launch instances in"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block allowed for SSH ingress"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch instances in"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the instances"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "EC2 key pair name for SSH access"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to all resources"
}

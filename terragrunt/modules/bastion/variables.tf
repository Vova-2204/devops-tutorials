variable "name" {
  type        = string
  description = "Name tag for the EC2 instance"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to launch the instance in"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to launch the instance in"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the instance"
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  default     = null
  description = "EC2 key pair name for SSH access"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply to all resources"
}

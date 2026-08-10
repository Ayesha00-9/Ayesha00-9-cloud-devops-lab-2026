variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "availability_zone" {
  description = "Availability Zone"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}
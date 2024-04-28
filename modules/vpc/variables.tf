variable "environment" {
  type = string
  description = "Name of the Environment"
}

variable "project_name" {
  type = string
  description = "Name of the Project"
}

variable "main_vpc_cidr_range" {
  type = string
  description = "CIDR range of Main VPC"
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type = string
  description = "Name of the VPC"
}

variable "public_subnets_cidr_ranges" {
  type = set(string)
  description = "List of CIDR ranges for Public Subnets"
  default = [ "10.0.0.0/20", "10.0.16.0/20" ]
}

variable "private_subnets_cidr_ranges" {
  type = set(string)
  description = "List of CIDR ranges for Private Subnets"
  default = [ "10.0.32.0/20", "10.0.128.0/20" ]
}

variable "azs" {
  type = set(string)
  description = "List of AZ for Subnets"
  default = [ "us-east-1a", "us-east-1b" ]
}

variable "public_internet_cidr" {
  type = string
  description = "Public internet route"
  default = "0.0.0.0/0"
}
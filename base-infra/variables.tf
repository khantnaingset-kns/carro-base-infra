variable "region" {
  type        = string
  description = "AWS region"
}

variable "environment" {
  type        = string
  description = "Name of the Environment"
}

variable "project_name" {
  type        = string
  description = "Name of the Project"
}


variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "eks_cluster_name" {
  type = string
  description = "EKS Cluster name"
}

variable "eks_cluster_version" {
  type = string
  description = "EKS Cluster version"
  default = "1.29"
}
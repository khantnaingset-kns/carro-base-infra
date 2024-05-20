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


variable "eks_cluster_name" {
  type        = string
  description = "EKS Cluster name"
}

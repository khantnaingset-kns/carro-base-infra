data "aws_eks_cluster_auth" "default_cluster_auth" {
  name = "${var.environment}-${var.project_name}-${var.eks_cluster_name}"
}


data "aws_eks_cluster" "default_cluster" {
  name = "${var.environment}-${var.project_name}-${var.eks_cluster_name}"
}
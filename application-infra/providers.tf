provider "kubernetes" {
  host                   = data.aws_eks_cluster.default_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.default_cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.default_cluster_auth.token
}

provider "helm" {
    kubernetes {
      host = module.eks.eks_cluster_endpoint
      cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca)
      token = data.aws_eks_cluster_auth.eks_cluster_data.token
    }
}
provider "helm" {
    kubernetes {
      host = module.eks.eks_cluster_endpoint
      cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca)
      token = module.eks.eks_cluster_token
    }
}
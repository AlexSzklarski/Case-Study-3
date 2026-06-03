## Elastic Kubernetes Service (EKS) Outputs 
output "eks_cluster_id" {
    value = module.eks.eks_cluster.cluster_id

    description = "Id of the EKS cluster"
}

output "eks_cluster_endpoint" {
    value = module.eks.eks_cluster.cluster_endpoint

    description = "Endpoint of the EKS cluster"
}

output "eks_cluster_ca" {
    value = module.eks.eks_cluster.cluster_certificate_authority_data

    description = "Cluster certificate authority"
}

data "aws_eks_cluster_auth" "eks_cluster_data" {
  name = "eks-cluster"
}

output "eks_cluster_token" {
  value       = data.aws_eks_cluster_auth.eks_cluster_data.token
  sensitive   = true
  description = "Cluster token"
}
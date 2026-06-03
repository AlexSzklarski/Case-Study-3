## Elastic Kubernetes Service (EKS) Outputs 
output "eks_id" {
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

output "eks_cluster_token" {
    value = module.eks.eks_cluster.token

    description = "Cluster token"
}
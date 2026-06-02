## Elastic Kubernetes Service (EKS) Outputs 
output "eks_name" {
    value = module.eks.eks_cluster.cluster_id
}
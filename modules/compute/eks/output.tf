## Elastic Kubernetes Service (EKS) Outputs 
output "eks_id" {
    value = module.eks.eks_cluster.cluster_id
}
## Elastic Kubernetes Service Resources
module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    for_each = { for inst in var.eks_vars : inst.name => inst }

    name = each.value.name
    kubernetes_version = each.value.kubernetes_version

    vpc_id = var.eks_vpc_id
    subnet_ids = var.eks_subnet_ids

    node_security_group_id = var.node_security_group_id
    enable_cluster_creator_admin_permissions = each.value.enable_cluster_creator_admin_permissions
    eks_managed_node_groups = var.eks_managed_node_groups

    compute_config = each.value.compute_config

    iam_role_name = each.value.iam_role_name
    iam_role_additional_policies = each.value.iam_role_additional_policies

    endpoint_public_access = each.value.endpoint_public_access

    access_entries = each.value.access_entries
    
    addons = each.value.addons

    tags = {
        name = each.value.name
        description = each.value.description
    }
}


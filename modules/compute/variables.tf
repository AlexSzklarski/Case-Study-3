## Elastic Kubernetes Service Variables
variable "eks_vars" {
    type = list(object({
        name = string
        kubernetes_version = string

        vpc_id = string
        subnet_ids = list(string)

        node_security_group_id = string
        enable_cluster_creator_admin_permissions = bool
        eks_managed_node_groups = map(any)

        compute_config = map(string)

        iam_role_name = string
        iam_role_additional_policies = map(string)

        endpoint_public_access = bool
        access_entries = map(any)

        addons = map(any)

        description = string        
    }))
}
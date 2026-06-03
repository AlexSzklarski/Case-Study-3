## Elastic Kubernetes Service Variables
variable "eks_vars" {
    type = list(object({
        name = string
        kubernetes_version = string

        enable_cluster_creator_admin_permissions = bool

        compute_config = map(string)

        iam_role_name = string
        iam_role_additional_policies = map(string)

        endpoint_public_access = bool
        access_entries = map(any)

        addons = map(any)

        description = string        
    }))
}

variable "vpc_id" {
    type = string
}

variable "subnet_ids" {
    type = list(string)
}

variable "node_security_group_id" {
    type = string
}

variable "eks_managed_node_groups" {
    type = map(object({
        name = string

        create = bool
        kubernetes_version = string
        instance_types = list(string)
        create_access_entry = bool

        subnet_ids = list(string)

        min_size = number
        max_size = number
        desired_size = number
    }))
}

## Helm Resources
variable "helm_vars" {
    type = list(object({
        name = string
        chart = string
        repository = string

        namespace = string
        create_namespace = bool

        dependency_update = bool
    }))
}
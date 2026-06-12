## Compute Module Variables
variable "eks_vars" {
    type = list(object({
        name = string
        kubernetes_version = string

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

variable "ec2_vars" {
    type = list(object({
        name = string
        instance_type = string
        associate_public_ip_address = bool        
        create_security_group = bool
        description = string
    }))
}

## Identity Access Management (IAM) Role Variables
variable "iam_role_vars" {
    type = list(object({
        name = string

        trust_policy_permissions = map(object({
            actions = list(string)
            principals = list(object({
                type = string
                identifiers = list(string)
            }))
        }))

        policies = map(string)

        description = string
    }))
}

## Database Module Variables
variable "parameter_vars" {
    type = list(object({
        name = string
        family = string

        description = string
    }))
}

variable "rds_vars" {
    type = list(object({
        identifier = string

        engine = string
        family = string
        engine_version = string
        major_engine_version = string

        instance_class = string
        allocated_storage = number
        skip_final_snapshot = bool

        db_name = string
        username = string
        
        create_db_subnet_group = bool

        parameter_group_name = string

        description = string
    }))
}

variable "s3_vars" {
    type = list(object({
        bucket = string
        versioning = map(any)
        
        name = string
        description = string
    }))
}

## Network Module Variables
variable "vpc_vars" {
    type = list(object({
        name = string
        type = string
        cidr = string
        azs = list(string)

        public_subnets = list(string)
        private_subnets = list(string)
        database_subnets = list(string)
        create_database_subnet_group = bool

        enable_vpn_gateway = bool

        enable_nat_gateway = bool
        single_nat_gateway = bool

        description = string
    }))
}

variable "hub_sg_vars" {
    type = list(object({
        name = string

        ingress_with_cidr_blocks = list(map(string))
        egress_with_cidr_blocks = list(map(string))

        description = string 
    }))
}

variable "spoke_sg_vars" {
    type = list(object({
        name = string

        ingress_with_cidr_blocks = list(map(string))
        egress_with_cidr_blocks = list(map(string))

        description = string 
    }))
}

variable "alb_vars" {
    type = list(object({
        name = string

        create_security_group = bool
        enable_deletion_protection = bool

        description = string
    }))
}

variable "tgw_vars" {
    type = list(object({
        name = string

        share_tgw = bool

        description = string
    }))
}
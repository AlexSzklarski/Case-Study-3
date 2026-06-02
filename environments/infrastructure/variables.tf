## Database Module Variables
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

        description = string
    }))
}

variable "sg_vars" {
    type = list(object({
        name = string

        ingress_with_cidr_blocks = list(map(string))
        egress_with_cidr_blocks = list(map(string))

        description = string 
    }))
}

## Application Load Balancer (ALB) Variables
variable "alb_vars" {
    type = list(object({
        name = string

        create_security_group = bool
        security_groups = list(string)
        enable_deletion_protection = bool

        description = string
    }))
}

variable "listener_vars" {
    type = list(object({
        name = string
        port = number
        protocol = string
        forward = map(string)
    }))
}

variable "target_group_vars" {
    type = list(object({
        name = string
        port = number
        protocol = string
        target_type = string
        target_id = string
        availability_zone = string
        health_check = map(string)
    }))
}

variable "tgw_vars" {
    type = list(object({
        name = string

        share_tgw = bool

        description = string
    }))
}
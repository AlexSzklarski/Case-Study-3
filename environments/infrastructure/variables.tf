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

variable "tgw_vars" {
    type = list(object({
        name = string
        
        share_tgw = bool

        description = string
    }))
}
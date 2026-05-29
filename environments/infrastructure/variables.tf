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
        vpc_security_group_ids = list(string)

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

variable "sg_vars" {
    type = list(object({
        name = string
        vpc_id = string

        ingress_with_cidr_blocks = list(map(string))
        egress_with_cidr_blocks = list(map(string))

        description = string 
    }))
}
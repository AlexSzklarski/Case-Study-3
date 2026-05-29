## Virtual Private Cloud (VPC) Variables
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

        description = string
    }))
}

## Security Group Variables
variable "sg_vars" {
    type = list(object({
        name = string
        vpc_id = string

        ingress_with_cidr_blocks = list(map(string))
        egress_with_cidr_blocks = list(map(string))

        description = string 
    }))
}
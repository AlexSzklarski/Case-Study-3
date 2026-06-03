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
## Virtual Private Cloud (VPC) Variables
variable "_vpc_vars" {
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

        ingress_with_cidr_blocks = list(map(string))
        egress_with_cidr_blocks = list(map(string))

        description = string 
    }))
}

variable "vpc_id" {
    type = string
}

## Application Load Balancer (ALB) Variables
variable "alb_vars" {
    type = list(object({
        name = string

        create_security_group = bool
        enable_deletion_protection = bool

        description = string
    }))
}

variable "listener_vars" {
    type = map(object({
        port = number
        protocol = string
        forward = map(string)
    }))
}

variable "target_group_vars" {
    type = map(object({
        name = string
        port = number
        protocol = string
        target_type = string
        target_id = string
        availability_zone = string
        health_check = map(string)
    }))
}

variable "alb_subnets" {
    type = list(string)
}

variable "alb_vpc_id" {
    type = string
}

variable "alb_security_group" {
    type = list(string)
}

## Transit GateWay (TGW) Variables
variable "tgw_vars" {
    type = list(object({
        name = string

        share_tgw = bool

        description = string
    }))
}

variable "tgw_attach" {
    type = map(object({
        vpc_id = string
        subnet_ids = list(string)
        destination_cidr_block = string
    }))
}
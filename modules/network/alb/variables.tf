## Application Load Balancer (ALB) Variables
variable "alb_vars" {
    type = list(object({
        name = string

        create_security_group = bool
        enable_deletion_protection = bool

        description = string
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
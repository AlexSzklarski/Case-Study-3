## Application Load Balancer (ALB) Variables
variable "alb_vars" {
    type = list(object({
        name = string

        create_security_group = bool
        enable_deletion_protection = bool

        description = string
    }))
}

# variable "listener_vars" {
#     type = map(object({
#         port = number
#         protocol = string
#         forward = map(string)
#     }))
# }

# variable "target_group_vars" {
#     type = map(object({
#         name = string
#         port = number
#         protocol = string
#         target_type = string
#         target_id = string
#         availability_zone = string
#         health_check = map(string)
#         create_attachment = bool
#     }))
# }

variable "alb_subnets" {
    type = list(string)
}

variable "alb_vpc_id" {
    type = string
}

variable "alb_security_group" {
    type = list(string)
}
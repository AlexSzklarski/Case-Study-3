# ## Security Group Variables
# variable "sg_hub_vars" {
#     type = list(object({
#         name = string

#         ingress_with_cidr_blocks = list(map(string))
#         egress_with_cidr_blocks = list(map(string))

#         description = string 
#     }))
# }

# variable "sg_hub_vpc_id" {
#     type = string
# }

variable "sg_spoke_vars" {
    type = list(object({
        name = string

        ingress_with_cidr_blocks = list(map(string))
        egress_with_cidr_blocks = list(map(string))

        description = string 
    }))
}

variable "sg_spoke_vpc_id" {
    type = string
}
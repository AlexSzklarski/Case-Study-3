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
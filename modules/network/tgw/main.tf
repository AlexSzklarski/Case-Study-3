## Transit GateWay (TGW) Resources
module "tgw" {
    for_each = { for inst in var.tgw_vars : inst.name => inst }
    source  = "terraform-aws-modules/transit-gateway/aws"

    name = each.value.name

    vpc_attachments = var.tgw_attach
    share_tgw = each.value.share_tgw

    tags = {
        name = each.value.name
        description = each.value.description
    }
}
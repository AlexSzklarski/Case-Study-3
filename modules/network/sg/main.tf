## Security Group Resources
module "hub_security_groups" {
    source = "terraform-aws-modules/security-group/aws"
    version = "5.3.1"
    for_each = { for inst in var.sg_hub_vars : inst.name => inst }

    name = each.value.name
    vpc_id = var.sg_hub_vpc_id

    ingress_with_cidr_blocks = each.value.ingress_with_cidr_blocks
    egress_with_cidr_blocks = each.value.egress_with_cidr_blocks

    tags = {
        name = each.value.name
        description = each.value.description
    }
}

module "spoke_security_groups" {
    source = "terraform-aws-modules/security-group/aws"
    version = "5.3.1"
    for_each = { for inst in var.sg_spoke_vars : inst.name => inst }

    name = each.value.name
    vpc_id = var.sg_spoke_vpc_id

    ingress_with_cidr_blocks = each.value.ingress_with_cidr_blocks
    egress_with_cidr_blocks = each.value.egress_with_cidr_blocks

    tags = {
        name = each.value.name
        description = each.value.description
    }
}


## Security Group Resources
module "security_groups" {
    source = "terraform-aws-modules/security-group/aws"
    for_each = { for inst in var.sg_vars : inst.name => inst }

    name = each.value.name
    vpc_id = var.vpc_id

    ingress_with_cidr_blocks = each.value.ingress_with_cidr_blocks
    egress_with_cidr_blocks = each.value.egress_with_cidr_blocks

    tags = {
        name = each.value.name
        description = each.value.description
    }
}

## Application Load Balancer (ALB) Resources
module "alb" {
    source = "terraform-aws-modules/alb/aws"
    for_each = { for inst in var.alb_vars : inst.name => inst }

    name = each.value.name

    vpc_id = var.alb_vpc_id
    subnets = var.alb_subnets

    create_security_group = each.value.create_security_group
    security_groups = var.alb_security_group
    enable_deletion_protection = each.value.enable_deletion_protection

    listeners = var.listener_vars
    target_groups = var.target_group_vars

    tags = {
        name = each.value.name
        description = each.value.description
    }
}

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

## Route53 Resourcesf
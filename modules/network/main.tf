## Virtual Private Cloud (VPC) Resources
module "vpc_module" {
    source = "terraform-aws-modules/vpc/aws"
    for_each = { for inst in var.vpc_vars : inst.name => inst }

    name = each.value.name
    cidr = each.value.cidr
    azs = each.value.azs

    public_subnets = each.value.public_subnets
    private_subnets = each.value.private_subnets
    database_subnets = each.value.database_subnets
    create_database_subnet_group = each.value.create_database_subnet_group
    
    enable_vpn_gateway = each.value.enable_vpn_gateway

    tags = {
        name = each.value.name
        description = each.value.description
    }
}

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

## Route53 Resources
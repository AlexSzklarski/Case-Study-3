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

    enable_nat_gateway = each.value.enable_nat_gateway
    single_nat_gateway = each.value.single_nat_gateway

    tags = {
        name = each.value.name
        description = each.value.description
    }
}
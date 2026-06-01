module "compute" {
    source = "../../modules/compute"

}

module "database" {
    source = "../../modules/database"

    rds_vars = var.rds_vars
    subnet_ids = data.aws_subnets.database_subnets.ids
    rds_sg_id = [data.aws_security_group.rds_sg.id]

    s3_vars = var.s3_vars
}

module "network" {
    source = "../../modules/network"

    vpc_vars = var.vpc_vars
    sg_vars = var.sg_vars
    vpc_id = data.aws_vpc.spoke_vpc.id

    tgw_vars = var.tgw_vars
    tgw_attach = {
        hub_attachement = {
            vpc_id = data.aws_vpc.hub_vpc.id
            subnet_ids = data.aws_subnets.public_subnets.ids
            destination_cidr_block = data.aws_vpc.spoke_vpc.cidr_block
        },
        spoke_attachement = {
            vpc_id = data.aws_vpc.spoke_vpc.id
            subnet_ids = data.aws_subnets.private_subnets.ids
            destination_cidr_block = data.aws_vpc.hub_vpc.cidr_block
        }
    }
}
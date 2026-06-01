module "compute" {
    source = "../../modules/compute"

}

module "database" {
    source = "../../modules/database"

    rds_vars = var.rds_vars
    subnet_ids = data.aws_subnets.database_subnets.ids
    rds_sg_id = [module.network.sg_output]

    s3_vars = var.s3_vars
}

module "network" {
    source = "../../modules/network"

    vpc_vars = var.vpc_vars
    sg_vars = var.sg_vars
    vpc_id = data.aws_vpc.spoke_vpc.id
}
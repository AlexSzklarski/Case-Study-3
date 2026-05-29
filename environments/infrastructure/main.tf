module "compute" {
    source = "../../modules/compute"

}

module "database" {
    source = "../../modules/database"

    rds_vars = var.rds_vars
    subnet_ids = data.aws_subnets.database_subnets.ids
}

module "network" {
    source = "../../modules/network"

    vpc_vars = var.vpc_vars
    sg_vars = var.sg_vars
}
## Virtual Private Cloud (VPC) Outputs
output "id_spoke_vpc" {
    value = module.vpc_module.spoke_vpc.vpc_id
    depends_on = [ module.vpc_module ]

    description = "Id of the spoke VPC."
}

output "id_hub_vpc" {
    value = module.vpc_module.hub_vpc.vpc_id
    depends_on = [ module.vpc_module ]

    description = "Id of the hub VPC."
}

output "id_db_spoke_subnet" {
    value = module.vpc_module.spoke_vpc.database_subnets
    depends_on = [ module.vpc_module ]

    description = "Id of the private subnets on the spoke VPC."
}
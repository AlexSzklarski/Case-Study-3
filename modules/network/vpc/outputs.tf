## Virtual Private Cloud (VPC) Outputs
output "id_hub_vpc" {
    value = module.vpc_module.hub_vpc.vpc_id
    depends_on = [ module.vpc_module ]

    description = "Id of the hub VPC."
}

output "id_pub_hub_subnet_0" {
    value = module.vpc_module.hub_vpc.public_subnets[0]

    description = "Id of the public subnet 0 on the hub VPC."
}

output "id_pub_hub_subnet_1" {
    value = module.vpc_module.hub_vpc.public_subnets[1]

    description = "Id of the public subnet 1 on the hub VPC."
}

output "id_spoke_vpc" {
    value = module.vpc_module.spoke_vpc.vpc_id
    depends_on = [ module.vpc_module ]

    description = "Id of the spoke VPC."
}

output "id_priv_spoke_subnet_0" {
    value = module.vpc_module.spoke_vpc.private_subnets[0]
    depends_on = [ module.vpc_module ]

    description = "Id of the private subnets on the spoke VPC."
}

output "id_db_spoke_subnet" {
    value = module.vpc_module.spoke_vpc.database_subnets
    depends_on = [ module.vpc_module ]

    description = "Id of the database subnets on the spoke VPC."
}
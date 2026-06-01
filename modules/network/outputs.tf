## Virtual Private Cloud (VPC) Outputs
output "id_spoke_vpc" {
    value = module.vpc_module.spoke_vpc.vpc_id
    depends_on = [ module.vpc_module ]

    description = "Id of the spoke VPC."
}

output "id_security_group" {
    value = module.security_groups.security_group_id
    depends_on = [ module.security_groups ]

    description = "Id of the spoke VPC."
}

## Security Group Output
output "sg_output" {
    value = module.security_groups.rds_sg.security_group_id
}
## Relational Database Service (RDS) Resources
resource "aws_db_parameter_group" "postgre_parameters" {
    for_each = { for inst in var.parameter_vars : inst.name => inst }

    name = each.value.name
    family = each.value.family

    parameter {
        name = "rds.logical_replication"
        value = "1"
    }

    description = each.value.description
}

module "rds_module" {
    source = "terraform-aws-modules/rds/aws"
    for_each = { for inst in var.rds_vars : inst.identifier => inst }

    identifier = each.value.identifier

    engine = each.value.engine
    family = each.value.family
    engine_version = each.value.engine_version
    major_engine_version = each.value.major_engine_version

    instance_class = each.value.instance_class
    allocated_storage = each.value.allocated_storage
    skip_final_snapshot = each.value.skip_final_snapshot

    db_name = each.value.db_name
    username = each.value.username
    
    create_db_subnet_group = each.value.create_db_subnet_group
    subnet_ids = var.rds_subnet_ids

    vpc_security_group_ids = var.rds_sg_id

    parameter_group_name = each.value.parameter_group_name

    tags = {
        name = each.value.identifier
        description = each.value.description
    }
}
output "rds_url" {
    value = module.rds_module.rds-database.db_instance_address
}
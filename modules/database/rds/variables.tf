## Relational Database Service (RDS) Variables
variable "parameter_vars" {
    type = list(object({
        name = string
        family = string

        parameters = list(object({
            name = string
            value = string
        }))

        description = string
    }))
}

variable "rds_vars" {
    type = list(object({
        identifier = string

        engine = string
        family = string
        engine_version = string
        major_engine_version = string

        instance_class = string
        allocated_storage = number
        skip_final_snapshot = bool

        db_name = string
        username = string
        
        create_db_subnet_group = bool

        parameter_group_name = string

        description = string
    }))
}

variable "rds_subnet_ids" {
    type = list(string)
}

variable "rds_sg_id" {
    type = list(string)
}
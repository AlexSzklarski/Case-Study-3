## Relational Database Service (RDS) Variables
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

        description = string
    }))
}

variable "subnet_ids" {
    type = list(string)
}

variable "rds_sg_id" {
    type = list(string)
}

## S3 Bucket Variables
variable "s3_vars" {
    type = list(object({
        bucket = string
        versioning = map(any)
        
        name = string
        description = string
    }))
}
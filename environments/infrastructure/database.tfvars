## Database Variable Values
rds_vars = [
    {
        identifier = "rds-database"

        engine = "postgres"
        family = "postgres18"
        engine_version = "18"
        major_engine_version = "18"

        instance_class = "db.t3.micro"
        allocated_storage = 5
        skip_final_snapshot = true

        db_name = "rdsdatabase"
        username = "admindatabase"
    
        create_db_subnet_group = true

        description = "Relational Database Service running PostgreSQL 18."
    }
]

s3_vars = [
    {
        bucket = "cicd-bucket-huby71"
        versioning = {
            enabled = true
        }

        name = "cicd-bucket"
        description = "S3 bucket holding Terraform state file."
    }
]
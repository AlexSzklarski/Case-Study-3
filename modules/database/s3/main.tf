## S3 Bucket Resources
module "s3_bucket" {
    source = "terraform-aws-modules/s3-bucket/aws"
    for_each = { for inst in var.s3_vars : inst.bucket => inst }

    bucket = each.value.bucket
    versioning = each.value.versioning

    tags = {
        name = each.value.name
        description = each.value.description
    }
}
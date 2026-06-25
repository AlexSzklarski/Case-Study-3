## Application Load Balancer (ALB) Resources
module "alb" {
    source = "terraform-aws-modules/alb/aws"
    for_each = { for inst in var.alb_vars : inst.name => inst }

    name = each.value.name

    vpc_id = var.alb_vpc_id
    subnets = var.alb_subnets

    create_security_group = each.value.create_security_group
    security_groups = var.alb_security_group
    enable_deletion_protection = each.value.enable_deletion_protection

    tags = {
        name = each.value.name
        description = each.value.description
    }
}
## EC2 module
module "ec2" {
    source  = "terraform-aws-modules/ec2-instance/aws"
    for_each = { for inst in var.ec2_vars : inst.name => inst }

    name = each.value.name

    instance_type = each.value.instance_type
    ami = var.ami_var

    subnet_id = var.subnet_id_var
    associate_public_ip_address = each.value.associate_public_ip_address
    
    create_security_group = each.value.create_security_group
    vpc_security_group_ids = var.security_group_var

    tags = {
        Name = each.value.name
        Description = each.value.description
    }
}
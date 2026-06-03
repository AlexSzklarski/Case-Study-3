## Security Group Outputs
output "alb_sg" {
    value = module.security_groups.alb_sg.security_group_id
    depends_on = [ module.security_groups ]

    description = "Id of the Application Load Balancer (ALB) security group."
}
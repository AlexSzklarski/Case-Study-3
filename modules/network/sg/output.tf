## Security Group Outputs
output "alb_sg_id" {
    value = module.security_groups.alb-sg.security_group_id
    depends_on = [ module.hub_sg ]

    description = "Id of the Application Load Balancer (ALB) security group."
}

output "eks_sg_id" {
    value = module.security_groups.eks_sg.security_group_id
    depends_on = [ module.spoke_sg ]

    description = "Id of the Elastic Kubernetes Service (EKS) security group."
}

output "rds_sg_id" {
    value = module.security_groups.rds_sg.security_group_id
    depends_on = [ module.spoke_sg ]

    description = "Id of the Relational Database Service (RDS) security group."
}
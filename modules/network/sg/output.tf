## Security Group Outputs
output "alb_sg_id" {
    value = module.hub_security_groups.alb-sg.security_group_id
    depends_on = [ module.hub_security_groups ]

    description = "Id of the Application Load Balancer (ALB) security group."
}

output "eks_sg_id" {
    value = module.spoke_security_groups.eks_sg.security_group_id
    depends_on = [ module.spoke_security_groups ]

    description = "Id of the Elastic Kubernetes Service (EKS) security group."
}

output "rds_sg_id" {
    value = module.spoke_security_groups.rds_sg.security_group_id
    depends_on = [ module.spoke_security_groups ]

    description = "Id of the Relational Database Service (RDS) security group."
}

output "ovpn_sg_id" {
    value = module.hub_security_groups.ovpn-sg.security_group_id
    depends_on = [ module.hub_security_groups ]

    description = "Id of the OpenVPN security group."
}
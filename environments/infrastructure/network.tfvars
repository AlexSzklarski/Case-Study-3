## Virtual Private Cloud (VPC) Variable Values
vpc_vars = [
    {
        name = "spoke_vpc"
        type = "spoke"
        cidr = "10.1.0.0/16"
        azs = ["eu-central-1a", "eu-central-1b"]

        public_subnets = ["10.1.1.0/24"]
        private_subnets = ["10.1.2.0/24", "10.1.3.0/24"]
        database_subnets = ["10.1.4.0/24", "10.1.5.0/24"]
        create_database_subnet_group = true
        
        enable_vpn_gateway = true

        enable_nat_gateway = true
        single_nat_gateway = true

        description = "Spoke VPC hosting a PostgreSQL database and a Kubernetes cluster."
    }
]

# ## Security Group Variable Values
# hub_sg_vars = [
#     {
#         name = "alb-sg"

#         ingress_with_cidr_blocks = [
#             {
#                 from_port = 80
#                 to_port = 80
#                 protocol = "tcp"
#                 cidr_blocks = "0.0.0.0/0"
#                 description = "Open port 80 for HTTP."
#             },
#             {
#                 from_port = 443
#                 to_port = 443
#                 protocol = "tcp"
#                 cidr_blocks = "0.0.0.0/0"
#                 description = "Open port 443 for HTTPS."
#             }
#         ]

#         egress_with_cidr_blocks = [
#             {
#                 from_port = 80
#                 to_port = 80
#                 protocol = "tcp"
#                 cidr_blocks = "0.0.0.0/0"
#                 description = "Open port 80 for HTTP."
#             },
#             {
#                 from_port = 443
#                 to_port = 443
#                 protocol = "tcp"
#                 cidr_blocks = "0.0.0.0/0"
#                 description = "Open port 443 for HTTPS."
#             }
#         ]

#         description = "Application Load Balancer ALB security group."
#     }
# ]

spoke_sg_vars = [
    {
        name = "eks_sg"

        ingress_with_cidr_blocks = [
            {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 22 for SSH."
            },
            {
                from_port = 53
                to_port = 53
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 53 for DNS."
            },
            {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 80 for HTTP."
            },
            {
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 443 for HTTPS."
            }
        ]

        egress_with_cidr_blocks = [
            {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 22 for SSH."
            },
            {
                from_port = 53
                to_port = 53
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 53 for DNS."
            },
            {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 80 for HTTP."
            },
            {
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 443 for HTTPS."
            },
            {
                from_port = 5432
                to_port = 5432
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 5432 for PostgreSQL."
            }
        ]

        description = "Elastic Kubernetes Service (EKS) security group."
    },
    {
        name = "rds_sg"

        ingress_with_cidr_blocks = [
            {
                from_port = 5432
                to_port = 5432
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 5432 for PostgreSQL."
            }
        ]

        egress_with_cidr_blocks = [
            {
                from_port = 5432
                to_port = 5432
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 5432 for PostgreSQL."
            }
        ]

        description = "Relational Database Service (RDS) security group."
    },
    {
        name = "ovpn-sg"

        ingress_with_cidr_blocks = [
            {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "SSH."
            },
            {
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "HTTPS."
            },
            {
                from_port = 943
                to_port = 943
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "OpenVPN web UI."
            },
            {
                from_port = 1194
                to_port = 1194
                protocol = "udp"
                cidr_blocks = "0.0.0.0/0"
                description = "OpenVPN default port."
            },
            {
                from_port = 5432
                to_port = 5432
                protocol = "tcp"
                cidr_blocks = "0.0.0.0/0"
                description = "Open port 5432 for PostgreSQL."
            }
        ]
        egress_with_cidr_blocks = [
            {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = "0.0.0.0/0"
                description = "Allows all egress."
            }
        ]

        description = "Security group attached to the Open VPN resource."
    }
]

# ## Application Load Balancer (ALB) Variable Values
# alb_vars = [
#     {
#         name = "hub-alb"

#         create_security_group = false
#         enable_deletion_protection = false

#         description = "Application Load Balancer ALB hosted on the hub VPC."
#     }
# ]

# ## Transit GateWay Variable Values
# tgw_vars = [
#     {
#         name = "hub_spoke_tgw"

#         share_tgw = false
        
#         description = "Transit GateWay connecting the hub and spoke VPCs together."
#     }
# ]
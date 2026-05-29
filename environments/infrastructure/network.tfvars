## Virtual Private Cloud (VPC) Variable Values
vpc_vars = [
    {
        name = "hub_vpc"
        cidr = "10.0.0.0/16"
        azs = ["eu-central-1a", "eu-central-1b"]
        
        public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
        private_subnets = []
        database_subnets = []
        create_database_subnet_group = false

        enable_vpn_gateway = true

        enable_nat_gateway = false
        single_nat_gateway = false

        description = "Hub VPC allowing inbound via ALB and TGW."
    },
    {
        name = "spoke_vpc"
        cidr = "10.1.0.0/16"
        azs = ["eu-central-1a", "eu-central-1b"]

        public_subnets = []
        private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
        database_subnets = ["10.1.3.0/24", "10.1.4.0/24"]
        create_database_subnet_group = true
        
        enable_vpn_gateway = true

        enable_nat_gateway = true
        single_nat_gateway = true

        description = "Spoke VPC hosting a PostgreSQL database and a Kubernetes cluster."
    }
]

## Security Group Variable Values
sg_vars = [
    # {
    #     name = "alb_sg"
    #     vpc_id = data.spoke_vpc.id

    #     ingress_with_cidr_blocks = 
    #     egress_with_cidr_blocks = 

    #     description = "Application Load Balancer (ALB) security group."
    # },
    # {
    #     name = "eks_sg"
    #     vpc_id = data.spoke_vpc.id

    #     ingress_with_cidr_blocks = 
    #     egress_with_cidr_blocks = 

    #     description = "Elastic Kubernetes Service (EKS) security group."
    # },
    # {
    #     name = "rds_sg"
    #     vpc_id = data.spoke_vpc.id

    #     ingress_with_cidr_blocks = 
    #     egress_with_cidr_blocks = 

    #     description = "Relational Database Service (RDS) security group."
    # }
]
module "compute" {
    source = "../../modules/compute"

    eks_vars = var.eks_vars
    vpc_id = data.aws_vpc.spoke_vpc.id
    subnet_ids = data.aws_subnets.private_subnets.ids
    node_security_group_id = data.aws_security_group.eks_sg.id
    eks_managed_node_groups = {
        node-0 = {
            name = "eks_node"

            create = true
            kubernetes_version = "1.35"
            instance_types = ["t3.medium"]
            create_access_entry = true

            subnet_ids = data.aws_subnets.private_subnets.ids

            min_size = 1
            max_size = 2
            desired_size = 1
        }
    }
}

module "database" {
    source = "../../modules/database"

    ## RDS Variables
    rds_vars = var.rds_vars
    subnet_ids = data.aws_subnets.database_subnets.ids
    rds_sg_id = [data.aws_security_group.rds_sg.id]

    ## S3 Variables
    s3_vars = var.s3_vars
}

module "network" {
    source = "../../modules/network"

    ## VPC Variables
    vpc_vars = var.vpc_vars

    ## Security Group Variables
    sg_vars = var.sg_vars
    vpc_id = data.aws_vpc.spoke_vpc.id

    ## ALB Variables
    alb_vars = var.alb_vars
    alb_subnets = module.network.id_pub_hub_subnet

    target_group_vars = {
        nginx_target = {
            name = "nginx_target"
            port = 80
            protocol = "HTTP"
            target_type = "ip"
            availability_zone = "eu-central-1a"

            health_check = {
                path = "/"
                port = 80
                protocol = "HTTP"
                matcher = 200
            }
        }
    }

    listener_vars = {
        nginx_listener = {
            port = 80
            protocol = "HTTP"
            forward = {
                target_group_key = "nginx_target"
            }
        }
    }
    
    ## TGW Variables
    tgw_vars = var.tgw_vars

    tgw_attach = {
        hub_attachement = {
            vpc_id = data.aws_vpc.hub_vpc.id
            subnet_ids = data.aws_subnets.public_subnets.ids
            destination_cidr_block = data.aws_vpc.spoke_vpc.cidr_block
        },
        spoke_attachement = {
            vpc_id = data.aws_vpc.spoke_vpc.id
            subnet_ids = data.aws_subnets.private_subnets.ids
            destination_cidr_block = data.aws_vpc.hub_vpc.cidr_block
        }
    }
}
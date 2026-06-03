provider "helm" {
    kubernetes {
      host = module.eks.eks_cluster_endpoint
      cluster_ca_certificate = base64decode(module.eks.eks_cluster_ca)
      token = module.eks.eks_cluster_token
    }
}

module "eks" {
    source = "../../modules/compute/eks" 

    eks_vars = var.eks_vars
    
    eks_vpc_id = data.aws_vpc.spoke_vpc.id
    eks_subnet_ids = [module.vpc.id_priv_spoke_subnet_0, module.vpc.id_priv_spoke_subnet_1]

    node_security_group_id = module.sg.eks_sg_id
    eks_managed_node_groups = {
        node-0 = {
            name = "eks_node"

            create = true
            kubernetes_version = "1.35"
            instance_types = ["t3.micro"]
            create_access_entry = true

            subnet_ids = [module.vpc.id_priv_spoke_subnet_0]

            min_size = 1
            max_size = 2
            desired_size = 1
        }
    }
}

module "helm" {
    source = "../../modules/compute/helm"

    ## Helm Variables
    helm_vars = var.helm_vars
}

module "database" {
    source = "../../modules/database"

    ## RDS Variables
    rds_vars = var.rds_vars
    rds_subnet_ids = module.vpc.id_db_spoke_subnet
    rds_sg_id = [module.sg.rds_sg_id]
}

module "vpc" {
    source = "../../modules/network/vpc"

    ## VPC Variables
    vpc_vars = var.vpc_vars
}

module "sg" {
    source = "../../modules/network/sg"

    ## Hub Security Group Variables
    sg_hub_vars = var.hub_sg_vars
    sg_hub_vpc_id = data.aws_vpc.hub_vpc.id

    ## Spoke Security Group Variables
    sg_spoke_vars = var.spoke_sg_vars
    sg_spoke_vpc_id = data.aws_vpc.spoke_vpc.id
}

module "alb" {
    source = "../../modules/network/alb"

    ## ALB Variables
    alb_vars = var.alb_vars
    alb_subnets = [module.vpc.id_pub_hub_subnet_0, module.vpc.id_pub_hub_subnet_1]
    alb_vpc_id = data.aws_vpc.hub_vpc.id
    alb_security_group = [module.sg.alb_sg_id]

    target_group_vars = {   
        nginx-target = {
            name = "nginx-target"
            port = 80
            protocol = "HTTP"
            target_type = "ip"
            availability_zone = "eu-central-1a"
            create_attachment = false

            health_check = {
                path = "/"
                port = "80"
                protocol = "HTTP"
                matcher = "200"
            }
        }
    }

    listener_vars = {
        nginx-listener = {
            port = 80
            protocol = "HTTP"
            forward = {
                target_group_key = "nginx-target"
            }
        }
    }
}

module "tgw" {
    source = "../../modules/network/tgw"
    
    ## TGW Variables
    tgw_vars = var.tgw_vars

    tgw_attach = {
        hub_attachement = {
            vpc_id = data.aws_vpc.hub_vpc.id
            subnet_ids = [module.vpc.id_pub_hub_subnet_0, module.vpc.id_pub_hub_subnet_1]
            destination_cidr_block = data.aws_vpc.spoke_vpc.cidr_block
        },
        spoke_attachement = {
            vpc_id = data.aws_vpc.spoke_vpc.id
            subnet_ids = [module.vpc.id_priv_spoke_subnet_0]
            destination_cidr_block = data.aws_vpc.hub_vpc.cidr_block
        }
    }
}
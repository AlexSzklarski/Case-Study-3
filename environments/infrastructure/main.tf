module "compute" {
    source = "../../modules/compute"

    eks_vars = [
        {
            name = "eks_cluster"
            kubernetes_version = "1.35"

            vpc_id = module.network.spoke_vpc_id
            subnet_ids = [module.network.private_subnet_id_0, module.network.private_subnet_id_1]

            node_security_group_id = module.network.eks_security_group_id
            enable_cluster_creator_admin_permissions = true
            eks_managed_node_groups = {
                node-0 = {
                    name = "eks_node"

                    create = true
                    kubernetes_version = "1.35"
                    instance_types = ["t3.medium"]
                    create_access_entry = true

                    subnet_ids = [module.network.private_subnet_id_0]

                    min_size = 1
                    max_size = 2
                    desired_size = 1
                }
            }

            compute_config = {
                enabled = false
            }

            iam_role_name = "eks-iam"
            iam_role_additional_policies = {
                AmazonEKSWorkerNodePolicy           = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
                AmazonEC2ContainerRegistryReadOnly  = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
                AmazonEKS_CNI_Policy                = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
            }

            endpoint_public_access = true
            access_entries = {
                root = {
                    principal_arn = "arn:aws:iam::476320587253:root"

                    policy_associations = {
                        root_assc = {
                            policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
                            access_scope = {
                                type = "cluster"
                            }
                        }
                    }
                }
            }

            addons = {
                vpc-cni = {
                    before_compute = true
                }

                kube-proxy = {}
            }

            description = "EKS cluster deployed on the spoke VPC."
        }
    ]
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
    alb_subnets = data.aws_subnets.public_subnets.ids

    target_group_vars = [
        {
            name = "nginx_target"
            port = 80
            protocol = "HTTP"
            target_type = "ip"
            target_id = data.aws_eks_cluster.eks_cluster.id
            availability_zone = "eu-central-1a"

            health_check = {
                path = forward
                port = 80
                protocol = "HTTP"
                matcher = 200
            }
        }
    ]

    listener_vars = [
        {
            name = "nginx_listener"
            port = 80
            protocol = "HTTP"
            forward = {
                target_group_key = module.network.nginx_tg
            }
        }
    ]
    
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
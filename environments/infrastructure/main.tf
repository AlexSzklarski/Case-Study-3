# module "eks" {
#     source = "../../modules/compute/eks" 

#     eks_vars = var.eks_vars
    
#     eks_vpc_id = data.aws_vpc.spoke_vpc.id
#     eks_subnet_ids = [module.vpc.id_priv_spoke_subnet_0, module.vpc.id_priv_spoke_subnet_1]

#     node_security_group_id = module.sg.eks_sg_id
#     eks_managed_node_groups = {
#         node-0 = {
#             name = "eks_node"

#             create = true
#             kubernetes_version = "1.36"
#             instance_types = ["t3.micro"]
#             create_access_entry = true

#             subnet_ids = [module.vpc.id_priv_spoke_subnet_0]

#             min_size = 1
#             max_size = 2
#             desired_size = 1
#         }
#     }
# }

# module "helm" {
#     source = "../../modules/compute/helm"

#     ## Helm Variables
#     helm_vars = var.helm_vars

#     depends_on = [ module.eks ]
# }

# module "iam" {
#     source = "../../modules/compute/iam"

#     iam_role_vars = var.iam_role_vars
# }

module "vpn" {
  source = "../../modules/compute/vpn"

  ec2_vars = var.ec2_vars
  ami_var = data.aws_ami.ovpn_ami.id
  subnet_id_var = module.vpc.pub_spoke_subnet
  security_group_var = [module.sg.ovpn_sg_id]
}

module "rds" {
    source = "../../modules/database/rds"

    ## RDS Variables
    parameter_vars = var.parameter_vars
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

# module "alb" {
#     source = "../../modules/network/alb"

#     ## ALB Variables
#     alb_vars = var.alb_vars
#     alb_subnets = [module.vpc.id_pub_hub_subnet_0, module.vpc.id_pub_hub_subnet_1]
#     alb_vpc_id = data.aws_vpc.hub_vpc.id
#     alb_security_group = [module.sg.alb_sg_id]

#     # target_group_vars = {   
#     #     nginx-target = {
#     #         name = "nginx-target"
#     #         port = 80
#     #         protocol = "HTTP"
#     #         target_type = "ip"
#     #         target_id = ""
#     #         availability_zone = "eu-central-1a"
#     #         create_attachment = false

#     #         health_check = {
#     #             path = "/"
#     #             port = "80"
#     #             protocol = "HTTP"
#     #             matcher = "200"
#     #         }
#     #     }
#     # }

#     # listener_vars = {
#     #     nginx-listener = {
#     #         port = 80
#     #         protocol = "HTTP"
#     #         forward = {
#     #             target_group_key = "nginx-target"
#     #         }
#     #     }
#     # }
# }

# module "tgw" {
#     source = "../../modules/network/tgw"
    
#     ## TGW Variables
#     tgw_vars = var.tgw_vars

#     tgw_attach = {
#         hub_attachement = {
#             vpc_id = data.aws_vpc.hub_vpc.id
#             subnet_ids = [module.vpc.id_pub_hub_subnet_0, module.vpc.id_pub_hub_subnet_1]
#             destination_cidr_block = data.aws_vpc.spoke_vpc.cidr_block
#         },
#         spoke_attachement = {
#             vpc_id = data.aws_vpc.spoke_vpc.id
#             subnet_ids = [module.vpc.id_priv_spoke_subnet_0]
#             destination_cidr_block = data.aws_vpc.hub_vpc.cidr_block
#         }
#     }
# }

# ## Cognito user pool which saves users.
# resource "aws_cognito_user_pool" "website_user_pool" {
#   name = "website_user_pool"
# }

# ## Cognito users.
# resource "aws_cognito_user" "admin_user" {
#   username = "admin"
#   user_pool_id = aws_cognito_user_pool.website_user_pool.id
#   password = "Password1!" ## CHANGE TO VAR
# }

# resource "aws_cognito_user" "guest_user" {
#   username = "guest"
#   user_pool_id = aws_cognito_user_pool.website_user_pool.id
#   password = "Password1!" ## CHANGE TO VAR
# }

# ## Cognito user groups.
# resource "aws_cognito_user_group" "admin_group" {
#   name = "admin_group"  
#   user_pool_id = aws_cognito_user_pool.website_user_pool.id
# }

# resource "aws_cognito_user_group" "guest_group" {
#   name = "guest_group" 
#   user_pool_id = aws_cognito_user_pool.website_user_pool.id
# }

# resource "aws_cognito_user_in_group" "user_in_admin_group" {
#   username = aws_cognito_user.admin_user.username
#   user_pool_id = aws_cognito_user_pool.website_user_pool.id
#   group_name = aws_cognito_user_group.admin_group.name
# }

# resource "aws_cognito_user_in_group" "user_in_guest_group" {
#   username = aws_cognito_user.guest_user.username
#   user_pool_id = aws_cognito_user_pool.website_user_pool.id
#   group_name = aws_cognito_user_group.guest_group.name
# }

# ## Hosted Cognito login UI.
# resource "aws_cognito_user_pool_domain" "cognito_domain" {
#   domain = "hybrid-cloud-login"
#   user_pool_id = aws_cognito_user_pool.website_user_pool.id
# }

# resource "aws_cognito_user_pool_client" "cognito_client" {
#   name = "cognito_client"
#   user_pool_id = aws_cognito_user_pool.website_user_pool.id

#   allowed_oauth_flows_user_pool_client = true
#   callback_urls = ["http://127.0.0.1:5500/website_frontend/index.html"] ## CHANGE 
#   logout_urls = ["http://127.0.0.1:5500/website_frontend/index.html"] ## CHANGE 

#   allowed_oauth_flows = ["code"]
#   allowed_oauth_scopes = ["profile", "openid"]
#   supported_identity_providers = ["COGNITO"]
# }
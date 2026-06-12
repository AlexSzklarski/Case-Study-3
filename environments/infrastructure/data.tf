# ## Compute Module Datablocks
# data "aws_eks_cluster_auth" "eks_cluster_data" {
#   name = "eks_cluster"
# }

## Network Module Datablocks
data "aws_vpc" "hub_vpc" {
    filter {
      name = "vpc-id"
      values = [ module.vpc.id_hub_vpc ]
    }
}

data "aws_subnets" "public_subnets" {
    filter {
      name = "vpc-id"
      values = [ module.vpc.id_hub_vpc ]
    }

    filter {
        name = "tag:Type"
        values = ["public"]
    }
}

data "aws_vpc" "spoke_vpc" {
    filter {
      name = "vpc-id"
      values = [ module.vpc.id_spoke_vpc ]
    }
}

data "aws_subnets" "private_subnets" {
    filter {
      name = "vpc-id"
      values = [ module.vpc.id_spoke_vpc ]
    }

    filter {
        name = "tag:Type"
        values = ["private"]
    }

    depends_on = [ module.vpc ]
}

data "aws_subnets" "database_subnets" {
    filter {
      name = "vpc-id"
      values = [ module.vpc.id_spoke_vpc ]
    }

    filter {
        name = "tag:Type"
        values = ["database"]
    }

    depends_on = [ module.vpc ]
}

data "aws_alb" "alb_url" {
  name = "hub-alb"

  depends_on = [ module.alb ]
}
## Compute Module Datablocks
data "aws_eks_cluster" "eks_cluster" {
    name = module.compute.eks_name
}

## Database Module Datablocks

## Network Module Datablocks
data "aws_vpc" "hub_vpc" {
    id = module.network.id_hub_vpc
}

data "aws_subnets" "public_subnets" {
    filter {
      name = "vpc-id"
      values = [ module.network.id_hub_vpc ]
    }

    filter {
        name = "tag:Type"
        values = ["public"]
    }

    depends_on = [ module.network ]
}

data "aws_vpc" "spoke_vpc" {
    id = module.network.id_spoke_vpc
}

data "aws_subnets" "private_subnets" {
    filter {
      name = "vpc-id"
      values = [ module.network.id_spoke_vpc ]
    }

    filter {
        name = "tag:Type"
        values = ["private"]
    }

    depends_on = [ module.network ]
}

data "aws_subnets" "database_subnets" {
    filter {
      name = "vpc-id"
      values = [ module.network.id_spoke_vpc ]
    }

    filter {
        name = "tag:Type"
        values = ["database"]
    }
}

data "aws_security_group" "rds_sg" {
    filter {
        name = "tag:Type"
        values = ["rds_sg"]
    }
    
    depends_on = [ module.network ]
}


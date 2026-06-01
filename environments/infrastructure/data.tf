## Compute Module Datablocks

## Database Module Datablocks

## Network Module Datablocks
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

    depends_on = [ module.network ]
}

data "aws_security_group" "rds_sg" {
    filter {
        name = "tag:Type"
        values = ["rds_sg"]
    }
}
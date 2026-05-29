## Compute Module Datablocks

## Database Module Datablocks

## Network Module Datablocks
data "aws_vpc" "spoke_vpc" {
    id = module.network.id_spoke_vpc
    depends_on = [ module.network ]
}

data "aws_subnets" "private_subnets" {
    filter {
      name = "vpc-id"
      values = [ module.network.id_spoke_vpc ]
    }

    filter {
        name   = "tag:Type"
        values = ["private"]
    }
}

data "aws_subnets" "database_subnets" {
    filter {
      name = "vpc-id"
      values = [ module.network.id_spoke_vpc ]
    }

    filter {
        name   = "tag:Type"
        values = ["database"]
    }
}
## Database Module Datablocks

## Network Module Datablocks
data "aws_vpc" "hub_vpc" {
    filter {
      name = "vpc-id"
      values = [ module.network.id_hub_vpc ]
    }
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
}

data "aws_vpc" "spoke_vpc" {
    filter {
      name = "vpc-id"
      values = [ module.network.id_spoke_vpc ]
    }
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
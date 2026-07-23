#########################################
# VPC
#########################################

resource "aws_vpc" "this" {

  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

#########################################
# Internet Gateway
#########################################

resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-igw"
    }
  )
}

#########################################
# Elastic IPs
#########################################

resource "aws_eip" "nat" {

  count = length(var.public_subnets)

  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-eip-${count.index + 1}"
    }
  )
}

#########################################
# Public Subnets
#########################################

resource "aws_subnet" "public" {

  count = length(var.public_subnets)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-public-${count.index + 1}"
      Tier = "Public"
    }
  )
}

#########################################
# Private Application Subnets
#########################################

resource "aws_subnet" "private_app" {

  count = length(var.private_app_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_app_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-app-${count.index + 1}"
      Tier = "Application"
    }
  )
}

#########################################
# Private Database Subnets
#########################################

resource "aws_subnet" "private_db" {

  count = length(var.private_db_subnets)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_db_subnets[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-db-${count.index + 1}"
      Tier = "Database"
    }
  )
}

#########################################
# NAT Gateways
#########################################

resource "aws_nat_gateway" "this" {

  count = length(var.public_subnets)

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  depends_on = [
    aws_internet_gateway.this
  ]

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-nat-${count.index + 1}"
    }
  )
}

#########################################
# Public Route Table
#########################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.this.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-public-rt"
    }
  )
}

#########################################
# Private Route Tables
#########################################

resource "aws_route_table" "private" {

  count = length(var.public_subnets)

  vpc_id = aws_vpc.this.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-private-rt-${count.index + 1}"
    }
  )
}

#########################################
# Public Route Associations
#########################################

resource "aws_route_table_association" "public" {

  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

#########################################
# Private Application Route Associations
#########################################

resource "aws_route_table_association" "private_app" {

  count = length(var.private_app_subnets)

  subnet_id = aws_subnet.private_app[count.index].id

  route_table_id = aws_route_table.private[count.index].id
}

#########################################
# Private Database Route Associations
#########################################

resource "aws_route_table_association" "private_db" {

  count = length(var.private_db_subnets)

  subnet_id = aws_subnet.private_db[count.index].id

  route_table_id = aws_route_table.private[count.index].id
}

#########################################
# Database Subnet Group
#########################################

resource "aws_db_subnet_group" "this" {

  name = "${var.name}-db-subnet-group"

  subnet_ids = aws_subnet.private_db[*].id

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-db-subnet-group"
    }
  )
}

#########################################
# VPC Flow Logs
#########################################

resource "aws_cloudwatch_log_group" "flow_logs" {

  name              = "/aws/vpc/${var.name}/flowlogs"
  retention_in_days = 30

  tags = var.tags
}

resource "aws_iam_role" "flow_logs" {

  name = "${var.name}-flowlogs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "flow_logs" {

  name = "${var.name}-flowlogs-policy"

  role = aws_iam_role.flow_logs.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_flow_log" "this" {

  iam_role_arn = aws_iam_role.flow_logs.arn

  log_destination = aws_cloudwatch_log_group.flow_logs.arn

  traffic_type = "ALL"

  vpc_id = aws_vpc.this.id
}

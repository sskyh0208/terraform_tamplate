# ---------------------------
# VPC
# ---------------------------
resource "aws_vpc" "this" {
  cidr_block            = var.cidr
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  
  tags = {
    Name = "${var.prefix}-vpc"
    Env     = var.env
    Product = var.product_name
  }
}

# ---------------------------
# Subnet
# ---------------------------
resource "aws_subnet" "public" {
  count = var.create_public_subnets && length(var.azs) > 0 ? length(var.azs) : 0

  vpc_id              = aws_vpc.this.id
  cidr_block          = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone   = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null

  tags = {
    Name = format("${var.prefix}-subnet-public-%s", element(var.azs, count.index))
    Env     = var.env
    Product = var.product_name
  }
}

resource "aws_subnet" "private" {
  count = var.create_private_subnets && length(var.azs) > 0 ? length(var.azs) : 0

  vpc_id              = aws_vpc.this.id
  cidr_block          = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + length(aws_subnet.public))
  availability_zone   = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null

  tags = {
    Name = format("${var.prefix}-subnet-private-%s", element(var.azs, count.index))
    Env     = var.env
    Product = var.product_name
  }
}

resource "aws_subnet" "database" {
  count = var.create_database_subnets && length(var.azs) > 0 ? length(var.azs) : 0

  vpc_id              = aws_vpc.this.id
  cidr_block          = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + length(aws_subnet.public) + length(aws_subnet.private))
  availability_zone   = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null

  tags = {
    Name = format("${var.prefix}-subnet-database-%s", element(var.azs, count.index))
    Env     = var.env
    Product = var.product_name
  }
}

resource "aws_db_subnet_group" "database" {
  count = var.create_database_subnets && length(var.azs) > 0 ? 1 : 0

  name        = "${var.prefix}-db-subnet-group"
  subnet_ids  = aws_subnet.database[*].id
  description = "Database subnet group for ${var.env} ${var.product_name}"

  tags = {
    Name = "${var.prefix}-db-subnet-group"
    Env     = var.env
    Product = var.product_name
  }
}

# ---------------------------
# Internet Gateway
# ---------------------------
resource "aws_internet_gateway" "this" {
  count  = var.create_public_subnets ? 1 : 0
  
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "${var.prefix}-igw"
    Env     = var.env
    Product = var.product_name
  }
}

# ---------------------------
# Route Table
# ---------------------------
resource "aws_route_table" "public" {
  count = var.create_public_subnets ? 1 : 0

  vpc_id          = aws_vpc.this.id
  route {
      cidr_block  = "0.0.0.0/0"
      gateway_id  = aws_internet_gateway.this[0].id
  }

  tags = {
    Name = "${var.prefix}-public-route-table"
    Env     = var.env
    Product = var.product_name
  }
}

resource "aws_route_table_association" "public" {
  count = var.create_public_subnets ? length(var.azs) : 0

  subnet_id       = element(aws_subnet.public[*].id, count.index)
  route_table_id  = aws_route_table.public[0].id
}
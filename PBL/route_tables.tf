# Create aws_route_table for Public Subnets
resource "aws_route_table" "public" {
  count  = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  vpc_id = aws_vpc.main.id
  tags = {
    Name        = format("Public-RT-%s", var.environment)
    Environment = var.environment
  }
}

# Create aws_route for Public Subnets
resource "aws_route" "public" {
  count  = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets
  route_table_id         = aws_route_table.public[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

# Create aws_route_table_association for Public Subnets
resource "aws_route_table_association" "public" {
  count  = var.preferred_number_of_public_subnets == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_public_subnets   
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}

# Create aws_route_table for Private Subnet A
resource "aws_route_table" "private_A" {
  count = var.preferred_number_of_private_subnets_A == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_A
  vpc_id = aws_vpc.main.id
    tags = {
    Name        =  format("PrivateA-RT, %s!",var.environment)
    Environment = var.environment
  }
}

# Create aws_route for Private Subnet A
resource "aws_route" "private_A" {
  count = var.preferred_number_of_private_subnets_A == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_A
  route_table_id         = aws_route_table.private_A[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}

# Create aws_route_table_association for Private Subnet A
resource "aws_route_table_association" "private_A" {
  count = var.preferred_number_of_private_subnets_A == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_A
  subnet_id      = aws_subnet.private_A[count.index].id
  route_table_id = aws_route_table.private_A[count.index].id
}

# Create aws_route_table for Private Subnet B
resource "aws_route_table" "private_B" {
  count = var.preferred_number_of_private_subnets_B == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_B
  vpc_id = aws_vpc.main.id
    tags = {
    Name        =  format("privateB-RT, %s!",var.environment)
    Environment = var.environment
  }
}

# Create aws_route for Private Subnet B
resource "aws_route" "private_B" {
  count = var.preferred_number_of_private_subnets_B == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_B
  route_table_id         = aws_route_table.private_B[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}

# Create aws_route_table_association for Private Subnet B
resource "aws_route_table_association" "private_B" {
  count = var.preferred_number_of_private_subnets_B == null ? length(data.aws_availability_zones.available.names) : var.preferred_number_of_private_subnets_B
  subnet_id      = aws_subnet.private_B[count.index].id
  route_table_id = aws_route_table.private_B[count.index].id
}
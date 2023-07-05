output "vpc_id" {
    value = aws_vpc.this.id
}

output "vpc_arn" {
    value = aws_vpc.this.arn
}

output "vpc_cidr_block" {
    value = aws_vpc.this.cidr_block
}

output "igw_id" {
    value = try(aws_internet_gateway.this[0].id, null)
}

output "igw_arn" {
    value = try(aws_internet_gateway.this[0].arn, null)
}

output "public_subnet_ids" {
    value = aws_subnet.public[*].id
}

output "public_subnet_arns" {
    value = aws_subnet.public[*].arn
}

output "private_subnet_ids" {
    value = aws_subnet.private[*].id
}

output "private_subnet_arns" {
    value = aws_subnet.private[*].arn
}

output "database_subnet_ids" {
    value = aws_subnet.database[*].id
}

output "database_subnet_arns" {
    value = aws_subnet.database[*].arn
}

output "database_subnet_group_id" {
    value = try(aws_db_subnet_group.database[0].id, null)
}

output "database_subnet_group_name" {
    value = try(aws_db_subnet_group.database[0].name, null)
}
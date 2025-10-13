output "vpc_id" {
  description = "VPC'nin ID'si"
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "Public subnetlerin ID'leri"
  value = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  
}


output "private_subnet_ids" {
  description = "Private subnetlerin ID'leri"
  value = [aws_subnet.private_a.id, aws_subnet.private_b.id]
  
}

output "nat_gateway_id" {
  description = "NAT Gateway'in ID'si"
  value = aws_nat_gateway.main.id
}
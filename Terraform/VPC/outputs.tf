output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnetA_id" {
  value = aws_subnet.publicA.id
}

output "public_subnetB_id" {
  value = aws_subnet.publicB.id
}

output "public_subnetC_id" {
  value = aws_subnet.publicC.id
}
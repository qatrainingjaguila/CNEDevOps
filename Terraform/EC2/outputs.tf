output "ec2-ip" {
  value = aws_instance.Instances.public_ip
}
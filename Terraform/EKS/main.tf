resource "aws_eks_cluster" "example" {
  name     = "projectCluster"
  role_arn = var.role_arn
  vpc_config {
    subnet_ids = var.subnet_ids
  }


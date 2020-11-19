provider "aws" {
  region = "eu-west-1"
  shared_credentials_file = "/home/qa/.aws/credentials"
}

module "aws_vpc" {
  source = "./VPC"
}

module "aws_webserver_sg" {
  source        = "./SecurityGroups"
  name          = "WebServerSG"
  vpc_id        = module.aws_vpc.vpc_id
}

module "Jenkins_node" {
  ami = var.ubuntu-ami
  source                 = "./EC2"
  subnet_id              = module.aws_vpc.public_subnetA_id
  vpc_security_group_ids = module.aws_webserver_sg.aws_wsg_id
  tags = {
    Name = "Jenkins_Node"
  }
  associate_public_ip_address = true
}

module "Test_VM" {
  ami = var.ubuntu-ami
  source                 = "./EC2"
  subnet_id              = module.aws_vpc.public_subnetA_id
  vpc_security_group_ids = module.aws_webserver_sg.aws_wsg_id
  tags = {
    Name = "Test_VM"
  }
  associate_public_ip_address = true
}

module "TestRDS" {
    source = "./RDS"
    dbname = "testdb"
    dbsubnet_groupname = "testrds-subnet-group"
    subnet_ids = [module.aws_vpc.public_subnetA_id,module.aws_vpc.public_subnetB_id]
    vpc_security_group_ids = [module.aws_webserver_sg.aws_wsg_id]

}

module "ProdRDS" {
    source = "./RDS"
    dbname = "users"
    dbsubnet_groupname = "prodrds-subnet-group"
    subnet_ids = [module.aws_vpc.public_subnetC_id,module.aws_vpc.public_subnetB_id]
    vpc_security_group_ids = [module.aws_webserver_sg.aws_wsg_id]

}
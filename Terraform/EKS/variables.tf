variable "subnet_ids"{

}

variable "role_arn"{
    default = "arn:aws:iam::939621893623:role/ClusterRole"
}

variable "EKS_security_group_ids"{

}

variable "node_role_arn"{
    default = "arn:aws:iam::939621893623:role/NodeInstanceRole"
}

variable "nodegroup_subnet_ids" {

}

variable "ami_type" {
    default = "AL2_x86_64"
}

variable "instance_types" {
    default = ["t3.micro"]
}

variable "remote_SG_ids" {
    
}
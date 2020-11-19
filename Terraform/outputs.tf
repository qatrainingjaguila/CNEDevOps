output "jenkins-ec2-ip"{
  value = module.Jenkins_node.ec2-ip
}

output "testvm-ec2-ip"{
  value = module.Test_VM.ec2-ip
}

output "testdb-endpoint"{
  value = module.TestRDS.rds-endpoint
}

output "proddb-endpoint"{
  value = module.ProdRDS.rds-endpoint
}

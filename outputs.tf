output "resource_group_name" {
  value = module.resource_group.resource_group_name
}

output "virtual_network_name" {
  value = module.virtual_network.virtual_network_name
}

output "subnet_name" {
  value = module.subnet.subnet_name
}

output "virtual_machine_id" {
  value = module.virtual_machine.vm_id
}

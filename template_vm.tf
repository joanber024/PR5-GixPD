resource "opennebula_virtual_machine" "virtual-machine" {
  count =2
  
  name = "virtual-machine-${count.index}"
  description = "Maquina virtual creada amb Terraform"
  cpu = 0.5
  vcpu = 2
  memory = 1024
  template_id = data.opennebula_template.virtual-machine.id  
  permissions = "600"
  
  disk {
    image_id = data.opennebula_image.virtual-machine.id
    size     = 20000
    target   = "vda"
    driver   = "qcow2"
  }

  graphics {
    type   = "VNC"
    listen = "0.0.0.0"
    keymap = "es"
  }

  os {
    arch = "x86_64"
    boot = "disk0"
  }

  nic {
    model           = "virtio"
    network_id      = data.opennebula_virtual_network.virtual-machine.id
    security_groups = [data.opennebula_security_group.virtual-machine.id]
  }
}

#resource "local_file" "hosts" {
 # content = <<EOT 
#[all:vars] 
#ansible_connection=ssh
#ansible_user=adminp
#ansible_ssh_pass=NebulaCaos
#ansible_sudo_pass=NebulaCaos
#[all]
#%{ for ip in opennebula_virtual_machine.virtual-machine[*].private_ip }
#${ip}
#%{ endfor }
#EOT
 #filename = "hosts"
#}

data "opennebula_image" "virtual-machine" {
  name = "Ubuntu22.04+openssh-server"
}

data "opennebula_virtual_network" "virtual-machine" {
  name = "Internet"
}

data "opennebula_security_group" "virtual-machine" {
  name = "default"
}

data "opennebula_template" "virtual-machine" {
  name = "Ubu22.04v1.4-GIxPD"
}

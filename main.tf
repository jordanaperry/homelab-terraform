resource "proxmox_virtual_environment_container" "prometheus" {
  node_name    = "leviathan"
  vm_id        = 105
  description  = "Prometheus + Grafana monitoring"

  initialization {
    hostname = "monitor"

    ip_config {
      ipv4 {
        address = "192.168.40.40/24"
        gateway = "192.168.40.1"
      }
    }

    dns {
      servers = ["192.168.40.1"]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    vlan_id  = 40
    firewall = false
  }

  disk {
    datastore_id = "wreck-lvm"
    size         = 20
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 1024
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
    type             = "debian"
  }
  
  features {
  nesting = true
}

  start_on_boot = true
}
resource "proxmox_virtual_environment_container" "gitea" {
  node_name    = "leviathan"
  vm_id        = 103
  description  = "Gitea self-hosted Git server"
  unprivileged = true
  start_on_boot = true

  initialization {
    hostname = "gitea"

    ip_config {
      ipv4 {
        address = "192.168.40.33/24"
        gateway = "192.168.40.1"
      }
    }

    dns {
      servers = ["192.168.40.1"]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    vlan_id  = 40
    firewall = false
  }

  disk {
    datastore_id = "wreck-lvm"
    size         = 25
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 512
    swap      = 512
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
    type             = "debian"
  }

  features {
    nesting = true
  }

  lifecycle {
    ignore_changes = [
      initialization,
      operating_system[0].template_file_id,
      network_interface[0].mac_address,
    ]
  }
}
resource "proxmox_virtual_environment_container" "bastion" {
  node_name    = "leviathan"
  vm_id        = 102
  description  = "SSH jumpbox"

  initialization {
    hostname = "bastion"

    ip_config {
      ipv4 {
        address = "192.168.40.50/24"
        gateway = "192.168.40.1"
      }
    }

    dns {
      servers = ["192.168.40.1"]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    vlan_id  = 40
    firewall = false
  }

  disk {
    datastore_id = "wreck-lvm"
    size         = 8
  }

  cpu {
    cores = 1
  }

  memory {
    dedicated = 512
    swap      = 512
  }

operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
    type             = "debian"
  }

  lifecycle {
    ignore_changes = [
      initialization,
      operating_system[0].template_file_id,
      network_interface[0].mac_address,
    ]
  }

  features {
    nesting = true
  }

  start_on_boot = true
  unprivileged = true
}
resource "proxmox_virtual_environment_container" "helm" {
  node_name     = "leviathan"
  vm_id         = 100
  description   = "Unifi Network Controller"
  unprivileged  = true
  start_on_boot = true

  initialization {
    hostname = "helm"

    ip_config {
      ipv4 {
        address = "192.168.40.20/24"
        gateway = "192.168.40.1"
      }
    }

    dns {
      servers = ["192.168.40.1"]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    vlan_id  = 40
    firewall = false
  }

  disk {
    datastore_id = "wreck-lvm"
    size         = 16
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 1024
    swap      = 512
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
    type             = "debian"
  }

  features {
    nesting = true
  }

  lifecycle {
    ignore_changes = [
      initialization,
      operating_system[0].template_file_id,
      network_interface[0].mac_address,
    ]
  }
}
resource "proxmox_virtual_environment_container" "blog" {
  node_name     = "leviathan"
  vm_id         = 101
  description   = "Hugo blog server"
  unprivileged  = true
  start_on_boot = true

  initialization {
    hostname = "blog"

    ip_config {
      ipv4 {
        address = "192.168.30.10/24"
        gateway = "192.168.30.1"
      }
    }

    dns {
      servers = ["192.168.30.1"]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    vlan_id  = 30
    firewall = false
  }

  disk {
    datastore_id = "wreck-lvm"
    size         = 20
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 2048
    swap      = 2048
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
    type             = "debian"
  }

  features {
    nesting = true
  }

  lifecycle {
    ignore_changes = [
      initialization,
      operating_system[0].template_file_id,
      network_interface[0].mac_address,
    ]
  }
}
resource "proxmox_virtual_environment_container" "keycloak" {
  node_name    = "leviathan"
  vm_id        = 104
  description  = "Keycloak IAM"

  initialization {
    hostname = "keycloak"

    ip_config {
      ipv4 {
        address = "192.168.40.30/24"
        gateway = "192.168.40.1"
      }
    }

    dns {
      servers = ["192.168.40.1"]
    }
  }

  network_interface {
    name     = "eth0"
    bridge   = "vmbr0"
    vlan_id  = 40
    firewall = false
  }

  disk {
    datastore_id = "wreck-lvm"
    size         = 20
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 1024
  }

  operating_system {
    template_file_id = "local:vztmpl/debian-12-standard_12.12-1_amd64.tar.zst"
    type             = "debian"
  }
  
  features {
  nesting = true
}

  start_on_boot = true
}
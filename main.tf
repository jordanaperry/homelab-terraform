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

  start_on_boot = true
}
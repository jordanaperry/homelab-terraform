terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.78"
    }
  }
}

provider "proxmox" {
  endpoint = "https://leviathan.jordanaperry.com:8006"
  username = "root@pam"
  password = var.proxmox_password
  insecure = false
}

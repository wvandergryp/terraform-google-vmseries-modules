# General
project     = "<PROJECT_ID>"
region      = "us-central1"
name_prefix = ""

# VPC

networks = {
  "panorama-vpc" = {
    vpc_name                        = "firewall-vpc"
    create_network                  = true
    delete_default_routes_on_create = "false"
    mtu                             = "1460"
    routing_mode                    = "REGIONAL"
    subnetworks = {
      "panorama-sub" = {
        name              = "panorama-subnet"
        create_subnetwork = true
        ip_cidr_range     = "172.21.21.0/24"
        region            = "us-central1"
      }
    }
    firewall_rules = {
      "allow-panorama-ingress" = {
        name             = "panorama-mgmt"
        source_ranges    = ["1.1.1.1/32", "2.2.2.2/32"]
        priority         = "1000"
        allowed_protocol = "all"
        allowed_ports    = []
      },
      "allow-ingress-ssh-https" = {
        name             = "allow-ssh-https"
        source_ranges    = ["<YOUR IP ADDRESS AT HOME>"]
        priority         = "1000"
        allowed_protocol = "TCP"
        allowed_ports    = ["22","443"]
      } 
    }
  }
}

# Panorama

panoramas = {
  "panorama-01" = {
    zone              = "us-central1-a"
    panorama_name     = "panorama-01"
    vpc_network_key   = "panorama-vpc"
    subnetwork_key    = "panorama-sub"
    panorama_version  = "panorama-byol-1000"
    ssh_keys          = "admin:<ssh-rsa AAAA...>"
    attach_public_ip  = true
    private_static_ip = "172.21.21.2"
  }
}

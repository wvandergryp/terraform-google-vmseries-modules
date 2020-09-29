variable instances {
  description = "Definition of firewalls that will be deployed"
  type        = map(any)
  # Why `any` here: don't use object() because every element must then have exactly the same nested structure; it thus becomes unwieldy.
  # For example you couldn't have one instance with three network interfaces and another instance with four.
  # Another example, you couldn't add an optional attribute to one instance's network interface.
}

variable machine_type {
  default = "n1-standard-4"
  type    = string
}

variable min_cpu_platform {
  default = "Intel Broadwell"
  type    = string
}

variable disk_type {
  description = "Default is pd-ssd, alternative is pd-balanced."
  default     = "pd-ssd"
}

variable bootstrap_bucket {
  default = ""
  type    = string
}

variable ssh_key {
  default = ""
  type    = string
}

variable scopes {
  default = [
    "https://www.googleapis.com/auth/compute.readonly",
    "https://www.googleapis.com/auth/cloud.useraccounts.readonly",
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
  ]
  type = list(string)
}

variable image {
}

variable tags {
  default = []
  type    = list(string)
}

variable create_instance_group {
  default = false
  type    = bool
}

variable service_account {
  description = "IAM Service Account for running firewall instance (just the email)"
  default     = null
  type        = string
}

variable dependencies {
  default = []
  type    = list(string)
}

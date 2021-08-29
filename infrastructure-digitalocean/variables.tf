variable "do_token" {}
variable "domain_name" {}
variable "private_key" {}
variable "digitalocean_image" {
  description = "DigitalOcean image"
  type        = string
  default     = "ubuntu-20-04-x64"
}
variable "digitalocean_region" {
  description = "DigitalOcean region"
  type        = string
  default     = "fra1"
}

variable "digitalocean_droplet_size" {
  description = "DigitalOcean droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}
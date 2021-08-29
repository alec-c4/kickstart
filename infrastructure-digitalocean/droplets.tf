data "digitalocean_ssh_key" "ssh_key" {
  name = "your_ssh_key_name"
}

resource "digitalocean_droplet" "web" {
  image  = var.digitalocean_image
  name   = data.external.droplet_name.result.name
  region = var.digitalocean_region
  size   = var.digitalocean_droplet_size
  ssh_keys = [
    data.digitalocean_ssh_key.ssh_key.id
  ]

  connection {
    host        = self.ipv4_address
    user        = "root"
    type        = "ssh"
    private_key = file(var.private_key)
    timeout     = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      "apt update",
      "apt -y upgrade"
    ]
  }
}
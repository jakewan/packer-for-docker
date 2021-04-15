source "docker" "main" {
  image  = "debian:${local.base_image}"
  commit = true
}

build {
  sources = ["source.docker.main"]
  provisioner "file" {
    source      = "install-deps.sh"
    destination = "/tmp/"
  }
  provisioner "shell" {
    inline = [
      "ls -l /tmp",
      "DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates gnupg lsb-release",
      "bash /tmp/install-deps.sh",
    ]
  }
  post-processors {
    post-processor "docker-tag" {
      repository = "frostedcarbon/packer-for-docker"
      tag        = ["${local.tag_version}-${local.base_image}"]
    }
    post-processor "docker-push" {}
  }
}

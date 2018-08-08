provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

variable "scylla_repo_url" {
  description = "should look like http://repositories.scylladb.com/scylla/repo/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/ubuntu/scylladb-2.1-xenial.list"
}

variable "project" {}

variable "region" {
  description = "instance internal IP address"
}

variable "zone" {
  description = "a|b|c|d etc"
}

variable "hostnumber" {
  description = "hostnumber 0, 1, 2 etc"
}

data "google_compute_subnetwork" "net" {
  name   = "default"
  region = "${var.region}"
}

locals = {
  ip = "${cidrhost(data.google_compute_subnetwork.net.ip_cidr_range, var.hostnumber)}"
  // ip = "10.154.0.2"
}

data "template_file" "scylla_startup_plain" {
  template = "${file("${path.module}/plain.sh")}"

  vars {
    IP = "${local.ip}"
    SCYLLA_REPO_URL = "${var.scylla_repo_url}"
  }
}

resource "google_compute_instance" "scylla_th_nvme" {
  name             = "scylla-${var.region}-${var.hostnumber}"
  machine_type     = "custom-50-209920"
  zone             = "${var.region}-${var.zone}"
  min_cpu_platform = "Intel Skylake"

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  scratch_disk {
    interface = "NVME"
  }

  scratch_disk {
    interface = "NVME"
  }

  scratch_disk {
    interface = "NVME"
  }

  scratch_disk {
    interface = "NVME"
  }

  scratch_disk {
    interface = "NVME"
  }

  scratch_disk {
    interface = "NVME"
  }

  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    address = "${local.ip}"

    subnetwork = "default"

    access_config {}
  }

  metadata_startup_script = "${data.template_file.scylla_startup_plain.rendered}"

  service_account {
    scopes = [
      "userinfo-email",
      "compute-ro",
      "storage-ro",
    ]
  }
}

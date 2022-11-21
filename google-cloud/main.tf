terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("dev.json")

  project = var.project_name
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc_network" {
  name = var.network_name
}

resource "google_compute_firewall" "vpc_network" {
  name = "allow-firewall"
  network= google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
}

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_name
  machine_type = var.flavor
  tags	= ["dev","bastion"]

  boot_disk {
    initialize_params {
      image = var.osimage
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
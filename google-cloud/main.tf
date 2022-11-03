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

  project = "development-367406"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
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
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags	= ["web","dev"]

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}



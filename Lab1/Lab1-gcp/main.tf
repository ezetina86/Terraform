#------------------------------------------------------------
# Preparation for Terraform certification
# Deploy a GCE instance in GCP
# @author: Enrique Zetina
#------------------------------------------------------------


provider "google" {
  project = "data-support-ez"
  region  = "us-central1"
  zone    = "us-central1-c"
}

#Adding a  GCE instance in GCP

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["owner", "enrique-zetina"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
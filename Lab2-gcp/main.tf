#------------------------------------------------------------
# Preparation for Terraform certification
# Build a Webserver with Bootstrap GCP
# @author: Enrique Zetina
# @status; NOT WORKING, the stratup scrips is not working
#------------------------------------------------------------


provider "google" {
  project = "terraform-certification-ez"
  region  = "us-central1"
  zone    = "us-central1-c"
}

#Adding a  GCE instance in GCP

resource "google_compute_instance" "webserver2" {
  name         = "webserver"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["enrique-zetina", "http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata_startup_script = <<EOF
  #! /bin/bash
  apt update
  apt -y install apache2
  cat <<EOF > /var/www/html/index.html
  <html><body><p>Webserver deployed in GCP by Terrafrom!</p></body></html>
  EOF
  network_interface {
    network = "default"

    #Required to get an Ephemeral external IP
    access_config {
      // Ephemeral IP
    }

  }
}

#Adding Firewall rules to  allow TCP 80,433
resource "google_compute_firewall" "webserver" {
  name    = "webserver-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443"]
  }

  source_tags = ["web", "http-server", "https-server"]
}

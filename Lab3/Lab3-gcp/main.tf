#------------------------------------------------------------
# Preparation for Terraform certification
# Build a Webserver with Bootstrap GCP and external file
# @author: Enrique Zetina
#------------------------------------------------------------


provider "google" {
  project = "terraform-certification-ez"
  region  = "us-central1"
  zone    = "us-central1-c"
}

#Adding a  GCE instance in GCP

resource "google_compute_instance" "webserver2" {
  name         = "webserver2"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["enrique-zetina", "http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata_startup_script = file("user_data.sh")
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

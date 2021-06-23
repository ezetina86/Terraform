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

resource "google_compute_instance" "webserver" {
  name         = "webserver"
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["enrique-zetina", "http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  metadata = {
    # This is not working at this point
    #startup-script-url = "gs://startup-script-ez/startup.sh"

    #Trying with the script directly
    metadata_startup_script = <<SCRIPT
#!/bin/bash
touch test.txt
echo "The script should work!" > test.txt
sudo yum -y update
sudo yum -y install httpd
sudo chown -R $USER:$USER /var/www
sudo echo "<h2>Web server GCP</h2><br>Built by Terrform" > /var/www/html/index.html
sudo service httpd start
sudo chkconfig httpd on
SCRIPT
  }

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

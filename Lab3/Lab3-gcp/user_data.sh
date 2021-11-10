  #! /bin/bash
  apt update
  apt -y install apache2
  cat <<EOF > /var/www/html/index.html
  <html><body><p>Webserver deployed in GCP with Terrafrom using an external file!</p></body></html>
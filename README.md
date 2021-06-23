<p align="center">
<img src="https://www.datocms-assets.com/2885/1586800192-terraformassociateweb.png?fit=max&fm=webp&q=80&w=2500" width="200" height="200">
</p>

# Terraform #
## Preparation for Terraform Associate Certification ##
### Enrique Zetina ###
#### 2021 ####

---
##### Laboratory #1 #####

Use a AWS provider to deploy simle EC2 instance.

```javascript
provider "aws" {
#Overwritting  my default region
  region = "us-east-1"
}

resource "aws_instance" "Ubuntu" {
  ami           = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"
  key_name = "terraform-key"

  tags = {
    Name = "Ubuntu-Server"
    Owner = "Enrique Zetina"
    ## Ading additional tags
    Project = "Terraform Certification"
  }
}
```
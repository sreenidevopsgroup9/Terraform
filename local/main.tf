terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
    google = {

    }
    azurerm = {
      version = "3.0.0"
    }
  }
}




resource "local_file" "resource-one" {
  filename = "a.txt"
  content  = "foo!"
}



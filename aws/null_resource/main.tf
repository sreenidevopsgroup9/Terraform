provider "aws" {
  access_key = "AKIA4EUA345PELF4OHHK"
  secret_key = "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"
  region     = "us-east-1"

}


resource "null_resource" "cluster" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
  }
}

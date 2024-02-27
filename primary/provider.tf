variable "signalfx_key" {
  type = string
}

terraform {
  required_providers {
    signalfx = {
      source = "splunk-terraform/signalfx"
      version = "9.1.1"
    }
  }
}

provider "signalfx" {
  auth_token = var.signalfx_key
  api_url = "https://api.us1.signalfx.com"
}
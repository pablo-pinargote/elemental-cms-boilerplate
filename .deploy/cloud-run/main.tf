terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.1.0"
    }
  }

  backend "gcs" {
    bucket  = "tfstates-repo"
    prefix  = "<app-id>.cloud-run"
  }

  required_version = ">= 0.14"
}

provider "google" {
  project = var.project_id
  region = var.region
}

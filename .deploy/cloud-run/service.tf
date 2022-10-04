resource "google_cloud_run_service" "default" {
  name     = "<cloud-run-service-name>"
  location = var.region

  metadata {
    labels = {
      "label-1" = ""
      "label-n": ""
    }
  }

  template {
    metadata {
      annotations = {
        "run.googleapis.com/vpc-access-connector" = var.vpc_connector_name
      }
    }
    spec {
      volumes {
        name = "settings"
        secret {
          secret_name = google_secret_manager_secret.default_settings.secret_id
          items {
            key = "latest"
            path = "default.settings.json"
          }
        }
      }
      containers {
        image = "gcr.io/paranoid-cloud-studio/<docker-image-name>:${var.image_version}"
        volume_mounts {
          mount_path = "/usr/app/src/settings"
          name = "settings"
        }
        ports {
          container_port = 8000
        }
        env {
          name = "CONFIG_FILEPATH"
          value = "settings/default.settings.json"
        }
      }
    }
  }

  traffic {
    percent = 100
    latest_revision = true
  }

}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers"
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.default.location
  project = google_cloud_run_service.default.project
  service = google_cloud_run_service.default.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_secret_manager_secret" "default_settings" {
  secret_id = "<app-id>-settings"

  labels = {
    "label-1" = ""
    "label-n" = ""
  }

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "default_settings_version" {
  secret = google_secret_manager_secret.default_settings.id
  secret_data = file("default.settings.json")
}
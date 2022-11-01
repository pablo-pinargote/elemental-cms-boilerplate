resource "google_storage_bucket" "static" {
  cors {
    max_age_seconds = 3600
    method = ["GET"]
    origin = ["*"]
    response_header = ["Content-Type"]
  }

  force_destroy = false
  location = var.buckets_location
  name = "elemental-<app-id>-static"
  project = var.project_id
  storage_class = "STANDARD"
  labels = {
    "label-1": "",
    "label-n": ""
  }
}

resource "google_storage_bucket" "media" {
  cors {
    max_age_seconds = 3600
    method = ["GET"]
    origin = ["*"]
    response_header = ["Content-Type"]
  }

  force_destroy = false
  location = var.buckets_location
  name = "elemental-<app-id>-media"
  project = var.project_id
  storage_class = "STANDARD"
  labels = {
    "label-1": "",
    "label-n": ""
  }
}

resource "google_storage_bucket_iam_member" "static_public_rule" {
  bucket = google_storage_bucket.static.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "static_admin_rule" {
  bucket = google_storage_bucket.static.name
  role = "roles/storage.admin"
  member = "serviceAccount:${var.buckets_admin_service_account}"
}

resource "google_storage_bucket_iam_member" "media_public_rule" {
  bucket = google_storage_bucket.media.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}

resource "google_storage_bucket_iam_member" "media_admin_rule" {
  bucket = google_storage_bucket.media.name
  role = "roles/storage.admin"
  member = "serviceAccount:${var.buckets_admin_service_account}"
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = "nth-weft-472916-q9" # Correct Project ID
}

# Also, correct the bucket name to avoid a mismatch
resource "google_storage_bucket" "static_site" {
  name     = "nth-weft-472916-static-website"  # Use the correct prefix
  location = "US-EAST1"

  website {
    main_page_suffix = "index.html"
  }
}

# Make the bucket's content publicly readable
resource "google_storage_bucket_iam_member" "public_read_access" {
  bucket = google_storage_bucket.static_site.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
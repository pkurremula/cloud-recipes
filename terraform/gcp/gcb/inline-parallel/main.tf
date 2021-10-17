terraform {
  required_version = "~> 1.0.9"
}

provider google {
  project = var.project
  region  = var.region
}

provider "google-beta" {
  project = var.project
  region  = var.region
}

resource "google_cloudbuild_trigger" "authx-build-test" {
  provider    = google-beta
  name        = "${var.github.owner}-${var.github.repo}-${var.github.branch}"
  description = "Trigger for push to the ${var.github.branch} branch on github.com/${var.github.owner}/${var.github.repo}"

  github {
    owner = var.github.owner
    name  = var.github.repo
    push {
      // The branch value represents a regex expression. Enclose with ^$ for an exact match.
      branch = "^${var.github.branch}$"
    }
  }

  build {
    step {
      id = "step 1"
      name = "alpine"
      args = ["echo", "step 1"]
    }
    step {
      id = "step 2a"
      name = "alpine"
      args = ["sh", "-c", "sleep 5 && echo 'step 2a'"]
    }
    step {
      id = "step 2b"
      name = "alpine"
      args = ["sh", "-c", "sleep 8 && echo 'step 2b'"]
      wait_for = ["step 1", "-"]  # Run immediately so that we are running steps 2a and 2b concurrently.
    }
    step {
      id = "step 3"
      name = "alpine"
      args = ["echo", "step 3"]
      wait_for = ["step 2a", "step 2b"]  # Wait for steps 2a and 2b to complete
    }
  }
}

# Static Website Hosting with DevSecOps on Google Cloud

This project is a practical demonstration of core DevSecOps principles, showcasing a fully automated pipeline for deploying a static website to Google Cloud Platform (GCP). It illustrates the integration of development, security, and operations practices to build a robust and efficient workflow.

## The Theory Behind the Implementation 

### 1. Infrastructure as Code (IaC)

This project uses **Terraform** as a primary example of IaC. Rather than manually configuring cloud resources through a user interface, we define our infrastructure (a Cloud Storage bucket with specific permissions) in a declarative configuration file (`main.tf`).

* **Principle**: Treat infrastructure like software. It is versioned, auditable, and repeatable.
* **Benefit**: This eliminates configuration drift, ensures consistent environments across deployments, and allows the entire infrastructure to be stood up or torn down with simple commands.

### 2. Continuous Integration / Continuous Deployment (CI/CD)

The project leverages **Cloud Build** to create a CI/CD pipeline that automates the deployment process.

* **Continuous Integration (CI)**: When a developer pushes a code change (e.g., an update to `index.html`), it triggers an automated build. This ensures that every code change is integrated and tested immediately.
* **Continuous Deployment (CD)**: The pipeline automatically deploys the latest version of the website to the live environment. This is driven by the `cloudbuild.yaml` file, which contains the steps to sync the website files to the Cloud Storage bucket.

### 3. DevSecOps & Security

Security is built into this pipeline, not added as an afterthought.

* **Principle of Least Privilege**: The Cloud Build trigger does not use a powerful default service account. Instead, a dedicated service account (`cloud-build-deployer`) is created with only the **`Storage Object Admin`** role. This ensures the account can only perform the necessary action—uploading files to the bucket—and nothing else.
* **Auditability & Transparency**: Every build, successful or failed, generates detailed logs in Cloud Build History. This provides a clear audit trail of who, what, and when changes were made, which is crucial for incident response and compliance.

## Technical Implementation 

### Repository Contents

* `main.tf`: The Terraform configuration file to create the Cloud Storage bucket and set public access permissions.
* `cloudbuild.yaml`: The Cloud Build configuration file that defines the CI/CD pipeline steps. It uses the `gcloud storage rsync` command to deploy the website.
* `index.html`: The static website's main page.

### Pipeline Workflow

1.  A developer modifies `index.html` and pushes the changes to the `main` branch of this GitHub repository.
2.  The Cloud Build trigger detects the push event.
3.  Cloud Build creates a temporary build environment and uses the dedicated `cloud-build-deployer` service account to execute the `cloudbuild.yaml` file.
4.  The `gcloud storage rsync` command runs, efficiently synchronizing the repository files with the Cloud Storage bucket.
5.  The new website version is live.

## Learnings & Key Takeaways

This project served as a hands-on learning experience for common DevSecOps challenges, including:

* Correctly setting up service account permissions (IAM roles).
* Troubleshooting build failures using detailed logs.
* Understanding the importance of `.gitignore` and `.gcloudignore` files to manage project size and deployments.
* Implementing and verifying a fully automated CI/CD pipeline.

---

Feel free to open an issue or submit a pull request if you have any suggestions or improvements.

# GitOps Kubernetes Demo 🚀

This project demonstrates a local GitOps workflow using **Minikube**, **Terraform**, **Helm**, and **Argo CD**, with environment separation and promotion/rollback support for a simple Nginx app.

---

## 🧪 Features

- ✅ Local Kubernetes cluster with **Minikube**
- ✅ **Terraform** provisioning:
  - Minikube cluster setup
  - Namespaces:
    - `dev-internal`, `dev-external`
    - `stag-internal`, `stag-external`
    - `prod-internal`, `prod-external`
- ✅ **Argo CD** installed via Helm and bootstrapped with manifests
- ✅ GitOps flow with declarative YAML for:
  - environment segregation:
    - `dev`, `stag` and `prod`
- ✅ Deployment of a simple Nginx app
- ✅ Defined monitoring metrics and thresholds

---

## 📦 Repository Structure

```sh
gitops-k8s-demo/
├── envs/ # Argo CD GitOps manifests per environment
│   ├── dev/
│   │   └── nginx-hello-app/ # Argo CD App YAMLs for dev
│   ├── stag/
│   │   └── nginx-hello-app/ # Argo CD App YAMLs for staging
│   ├── prod/
│       └── nginx-hello-app/ # Argo CD App YAMLs for production
│
├── terraform-main/ # Root caller module for provisioning local and kubernetes resources
│
├── terraform-modules/ # Reusable Terraform modules
```

## 🚀 Deployment & Release Process
This repository follows a GitOps-based release strategy using Argo CD. Each environment (dev, stag, prod) has its own Argo CD Application manifest located in the envs/ directory.

The application deployed is Bitnami's Nginx chart, and the version/content is controlled by modifying the valuesObject (specifically, image or content) in each environment's Application manifest.

## 📦 Environments
| Environment | Namespace      | App Path                          | Helm Chart Version |
|-------------|----------------|------------------------------------|---------------------|
| `dev`       | `dev-internal`   | `envs/dev/nginx-hello-app/`       | `16.0.7`            |
| `stag`      | `stag-internal`  | `envs/stag/nginx-hello-app/`      | `16.0.3`            |
| `prod`      | `prod-internal`  | `envs/prod/nginx-hello-app/`      | `16.0.0`            |


Each environment runs the **Bitnami Nginx** Helm chart but with **different chart versions** and **custom configuration**. This allows for environment-specific validation and gradual rollout of new features or chart upgrades.

### 🔼 How to Upgrade, Promote, Rollback an Application Version

Upgrading the app in any environment (dev, stag, or prod) follows a **GitOps pull request workflow**. All deployments are driven by Git and automatically applied by Argo CD.

#### ✅ Steps to Upgrade

1. **Edit the environment manifest**
   
   Navigate to the appropriate environment under `envs/<env>/nginx-hello-app/` and update the chart version or app config.

   Example – update the Helm chart version:

   ```yaml
   spec:
     source:
       repoURL: https://charts.bitnami.com/bitnami
       chart: nginx
       targetRevision: 16.0.8  # ← new version
   ```
### 📊 Monitoring & Thresholds

Below are example monitoring metrics and thresholds that should be tracked to ensure the health and performance of the web application and GitOps pipeline.

| **What to Monitor**                     | **Threshold**                         | **Why It’s Important**                                                   |
|----------------------------------------|---------------------------------------|---------------------------------------------------------------------------|
| **Nginx HTTP 5xx Error Rate**          | > 1% of requests return 5xx           | Indicates backend failures or app crashes affecting users                |
| **Nginx HTTP 4xx Error Rate**          | > 5% of requests return 4xx           | Can indicate broken clients, bad configs, or missing endpoints           |
| **Nginx Average Response Time**        | > 500 ms average (over 5 min)         | Detects slow page loads or backend latency                               |
| **Nginx Request Rate (RPS)**           | Sudden spikes/drop (> 50% change)     | Helps spot traffic anomalies or possible outages                         |
| **Nginx Uptime / Liveness**            | Any unexpected downtime               | Detects outages or restart loops in the Nginx container                  |
| **Nginx Connection Errors**            | > 0 for backend/upstream connections  | Indicates unreachable services or readiness probe issues                 |
| **Nginx Open Connections**             | > 80% of configured limit             | Helps avoid DoS-like overload or misconfigured limits                    |
| **App Content Check (Smoke Test)**     | Home page must contain `"Hello It's Me"` | Validates app is running expected version and content                |
| **Ingress Availability (if used)**     | Response code ≠ 200 from ingress URL  | Ensures that ingress routing to Nginx is functioning                     |
| **TLS Certificate Expiry (if used)**   | < 7 days remaining                    | Avoid broken HTTPS access due to expired certs                           |
| **Pod Resource Usage (CPU/Memory)**    | CPU > 80%, Memory > 75% of limits     | Prevents resource starvation and eviction                                |
| **Pod Restarts**                       | > 1 restart in 10 minutes             | Flags unstable app containers                                            |
| **Argo CD Sync Status**                | `OutOfSync` or `Degraded` state       | Git and cluster drift; signals deployment issues                         |
| **Argo CD Sync Failures**              | > 3 sync errors/hour                  | Often caused by chart issues, Helm errors, or misconfiguration  |   

### 🛠️ Future Work / To-Do

Planned enhancements to further improve automation, flexibility, and safety of the GitOps workflow:

#### 🔄 Image Update Automation

| Environment | Auto Image Update | Scope       | Reasoning                                  |
|-------------|-------------------|-------------|--------------------------------------------|
| `dev`       | ✅ Enabled         | All changes | Rapid feedback during development          |
| `stag`      | ⚠️ Partial         | Patches only | Stability with limited automation          |
| `prod`      | ❌ Manual only     | N/A         | Full control and manual promotion required |

- **Dev**: Configure [Argo CD Image Updater](https://argocd-image-updater.readthedocs.io/) to automatically track and deploy the latest available image tag (e.g. semantic versions).
- **Stag**: Allow auto-updates **only for patch releases** (e.g., `1.2.3 → 1.2.4`) using semantic version constraints.
- **Prod**: All upgrades should remain manual and require a pull request to update the tag explicitly in Git.
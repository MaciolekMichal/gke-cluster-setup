# GKE Autopilot Cluster Setup

This repository contains a shell script to set up a Google Kubernetes Engine (GKE) Autopilot cluster.

## Prerequisites

- GCP project with billing enabled.
- gcloud CLI installed and initialized.

    Make sure you have the latest version of the gcloud CLI. To update, run:
    
    ```
    gcloud components update
    ```

## Usage

1. Clone the repository:
    ```bash
    git clone https://github.com/MaciolekMichal/gke-cluster-setup.git
    cd gke-cluster-setup
    ```

2. Modify the `setup_gke_cluster.sh` script with your project-specific variables:
    ```bash
    PROJECT_ID="your-project-id"
    REGION="your-region"
    ZONE="your-zone"

    CLUSTER_NAME="your-cluster-name"
    CLUSTER_SA_NAME="your-cluster-sa-name"
    CLUSTER_SA_DISPLAY_NAME="your-cluster-sa-display-name"
    CLUSTER_SA_DESCRIPTION="your-cluster-sa-description"
    ```

3. Run the script:
    ```bash
    sh ./setup_gke_cluster.sh
    ```

## Example Variables

```bash
PROJECT_ID="drone-navigation-0123456"
REGION="europe-central2"
ZONE="europe-central2-a"

CLUSTER_NAME="drone-navigation-cluster"
CLUSTER_SA_NAME="drone-navigation-cluster-sa"
CLUSTER_SA_DISPLAY_NAME="GKE Autopilot Cluster Service Account For Drone Navigation"
CLUSTER_SA_DESCRIPTION="Service account for managing GKE Autopilot cluster, providing necessary permissions for cluster operations regarding drone navigation."

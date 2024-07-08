# GKE Autopilot Cluster Setup with Workload Identity Federation

This repository contains a shell script to set up a Google Kubernetes Engine (GKE) Autopilot cluster with Workload Identity Federation for authentication.

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
    PROJECT_NUMBER="your-project-number"
    REGION="your-region"
    ZONE="your-zone"

    CLUSTER_NAME="your-cluster-name"
    CLUSTER_SA_NAME="your-cluster-sa-name"
    CLUSTER_SA_DISPLAY_NAME="your-cluster-sa-display-name"
    CLUSTER_SA_DESCRIPTION="your-cluster-sa-description"

    NAMESPACE_NAME="your-kubernetes-namespace-name"
    KUBERNETES_SA_NAME="your-kubernetes-service-account-name"
    ```

3. Modify the IAM role bindings from the `setup_gke_cluster.sh` script based on your project needs:
    ```bash
    gcloud projects add-iam-policy-binding "$PROJECT_ID" \
        --role=roles/bigquery.dataEditor \
        --member="$WIF_SA" \
        --condition=None

    gcloud projects add-iam-policy-binding "$PROJECT_ID" \
        --role=roles/pubsub.subscriber\
        --member="$WIF_SA" \
        --condition=None
    ```

4. Run the script:
    ```bash
    sh ./setup_gke_cluster.sh
    ```


## Example Variables

```bash
PROJECT_ID="drone-navigation-0123456"
PROJECT_NUMBER="333222111000"
REGION="europe-central2"
ZONE="europe-central2-a"

CLUSTER_NAME="drone-cluster"
CLUSTER_SA_NAME="drone-cluster-sa"
CLUSTER_SA_DISPLAY_NAME="GKE Autopilot Cluster Service Account For Drone Navigation"
CLUSTER_SA_DESCRIPTION="Service account for managing GKE Autopilot cluster, providing necessary permissions for cluster operations regarding drone navigation."

NAMESPACE_NAME="drone-ns"
KUBERNETES_SA_NAME="drone-ksa"
```

## Documentation

For more detailed information, refer to the official Google Cloud documentation:
- [Creating an Autopilot cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/creating-an-autopilot-cluster)
- [Authenticate to Google Cloud APIs from GKE workloads](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity)


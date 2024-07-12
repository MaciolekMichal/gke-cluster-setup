#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

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


echo "Enable necessary service APIs:"
gcloud services enable container.googleapis.com

echo "Set compute region and zone properties:"
gcloud config set compute/region "$REGION"
gcloud config set compute/zone "$ZONE"

echo "Create service account for cluster nodes:"
gcloud iam service-accounts create "$CLUSTER_SA_NAME" \
  --display-name="$CLUSTER_SA_DISPLAY_NAME" \
  --description="$CLUSTER_SA_DESCRIPTION"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --role=roles/artifactregistry.reader \
    --member="serviceAccount:$CLUSTER_SA_NAME@$PROJECT_ID.iam.gserviceaccount.com"

echo "Create an Autopilot cluster:"
gcloud container clusters create-auto "$CLUSTER_NAME" \
    --location="$REGION" \
    --service-account="$CLUSTER_SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
    --project="$PROJECT_ID"

echo "Connect to the cluster:"
gcloud container clusters get-credentials "$CLUSTER_NAME" \
  --location="$REGION" \
  --project="$PROJECT_ID"

echo "Create a new namespace in the cluster:"
kubectl create namespace "$NAMESPACE_NAME"

echo "Create a kubernetes service account:"
kubectl create serviceaccount "$KUBERNETES_SA_NAME" \
    --namespace "$NAMESPACE_NAME"

echo "Bind IAM roles to the kubernetes service account:"
WIF_SA="principal://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/$PROJECT_ID.svc.id.goog/subject/ns/$NAMESPACE_NAME/sa/$KUBERNETES_SA_NAME"
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --role=roles/bigquery.dataEditor \
    --member="$WIF_SA" \
    --condition=None

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --role=roles/pubsub.subscriber \
    --member="$WIF_SA" \
    --condition=None

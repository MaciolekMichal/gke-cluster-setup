#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

PROJECT_ID="your-project-id"
REGION="your-region"
ZONE="your-zone"

CLUSTER_NAME="your-cluster-name"
CLUSTER_SA_NAME="your-cluster-sa-name"
CLUSTER_SA_DISPLAY_NAME="your-cluster-sa-display-name"
CLUSTER_SA_DESCRIPTION="your-cluster-sa-description"


echo "Enable necessary service APIs:"
gcloud services enable container.googleapis.com

echo "Set compute region and zone properties:"
gcloud config set compute/region "$REGION"
gcloud config set compute/zone "$ZONE"

echo "Create service account for cluster nodes:"
gcloud iam service-accounts create "$CLUSTER_SA_NAME" \
  --display-name="$CLUSTER_SA_DISPLAY_NAME" \
  --description="$CLUSTER_SA_DESCRIPTION"

echo "Create an Autopilot cluster:"
gcloud container clusters create-auto "$CLUSTER_NAME" \
    --location="$REGION" \
    --service-account="$CLUSTER_SA_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
    --project="$PROJECT_ID"

echo "Connect to the cluster:"
gcloud container clusters get-credentials "$CLUSTER_NAME" \
  --location="$REGION" \
  --project="$PROJECT_ID"
#! /usr/bin/env bash
set -o nounset -o pipefail -o errexit;

TIME_START=$(date +%s)
# Source the .env file
INFRA_DIR=terraform
cd "$INFRA_DIR"

# Source common configuration
. .env

# Validate arguments: $1 environment, $2 action
if [ -z "$1" ]; then
  echo "Error: Environment argument is missing. Use ./deploy-infra.sh dev plan"
  exit 1
elif [ -z "$2" ]; then
  echo "Error: Terraform Action argument is missing. Use ./deploy-infra.sh dev plan"
  exit 1
elif ! [[ "$1" =~ ^($VALID_ENVIRONNMENTS)$ ]]; then
  echo "Error: Invalid environment \"$1\" . Must be $VALID_ENVIRONNMENTS."
  exit 1
elif ! [[ "$2" =~ ^($VALID_ACTIONS)$ ]]; then
  echo "Error: Invalid Terraform action \"$1\" . Must be $VALID_ACTIONS."
  exit 1
fi

# Define Dynamic environment variables
ENV=$1
TFACTION=$2
VAR_FILE="config/${ENV}.tfvars"

export AWS_REGION=$TF_VAR_aws_region

# Validate Terraform variables file
if [ ! -f "$VAR_FILE" ]; then
  echo "Error: $VAR_FILE file doesn't exists!"
  exit 1
fi

# ----------------------------------------------------------------
# Install Terraform using tfenv
# ----------------------------------------------------------------
# Check if current Terraform version matches required version
CURRENT_TF_VERSION=$(terraform version | head -n 1 | awk '{print $2}' | sed 's/v//')
echo "Current Terraform version: $CURRENT_TF_VERSION"
if [ "$CURRENT_TF_VERSION" != "$TF_VERSION" ]; then
  # Install Terraform using tfenv
  echo "Installing Terraform $TF_VERSION..."
  tfenv use "$TF_VERSION"
fi

# ----------------------------------------------------------------
# Terraform commands
# ----------------------------------------------------------------

# Format
echo "Terraform format..."
terraform fmt "$VAR_FILE"
terraform fmt

# Initialize
echo "Initializing Terraform..."
terraform init

# Workspace
echo "Terraform workspace..."
terraform workspace select "$ENV" || terraform workspace new "$ENV"

# Validate
echo "Terraform validate..."
terraform validate

# Imports goes here
# -----------------------------------------------------------------------
# terraform state rm [tfstat elemental]
# terraform import -var-file="$VAR_FILE" [tfstat elemental] [aws arn/id]


# Plan
if [[ "_${TFACTION}" =~ ^_(plan|apply)$ ]]; then
  echo "Running Terraform plan..."
  terraform plan \
    -input=false \
    -var-file="$VAR_FILE" \
    -out="$ENV.tfplan"
fi

# Apply
if [ "_${TFACTION}" == "_apply" ]; then
  echo "Running Terraform apply..."
  terraform apply \
    -auto-approve=true \
    "$ENV.tfplan"
elif [ "_${TFACTION}" == "_destroy" ]; then
# Destroy
  echo "Running Terraform destroy..."
  terraform destroy \
    -input=false \
    -var-file="$VAR_FILE"
elif [ "_${TFACTION}" == "_out" ]; then
# Destroy
  echo "Running Terraform Output..."
  terraform output
fi

# clear TF state local, to avoid fail when change the environment
# rm -rf .terraform/terraform.tfstate

# Print execution time
TIME_END=$(date +%s)
echo "Execution time: $((TIME_END - TIME_START)) seconds"

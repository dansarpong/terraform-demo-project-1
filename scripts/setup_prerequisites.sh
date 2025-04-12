#!/bin/bash
set -e  # Exit on error

# Configuration
AWS_REGION="eu-west-1"
S3_BUCKET="terraform-demo-state-bucket"
DYNAMODB_TABLE="terraform-demo-state-lock"

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Starting prerequisite setup...${NC}"

# 1. Create S3 bucket for Terraform state
echo -e "${YELLOW}Creating S3 bucket...${NC}"
if aws s3api head-bucket --bucket $S3_BUCKET --region $AWS_REGION 2>/dev/null; then
  echo "S3 bucket $S3_BUCKET already exists"
else
  aws s3api create-bucket \
    --bucket $S3_BUCKET \
    --region $AWS_REGION \
    --create-bucket-configuration LocationConstraint=$AWS_REGION
  aws s3api put-bucket-versioning \
    --bucket $S3_BUCKET \
    --versioning-configuration Status=Enabled
  echo "S3 bucket created with versioning enabled"
fi

# 2. Create DynamoDB table for state locking
echo -e "${YELLOW}Creating DynamoDB table...${NC}"
if aws dynamodb describe-table --table-name $DYNAMODB_TABLE --region $AWS_REGION &>/dev/null; then
  echo "DynamoDB table $DYNAMODB_TABLE already exists"
else
  aws dynamodb create-table \
    --table-name $DYNAMODB_TABLE \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region $AWS_REGION
  echo "DynamoDB table created"
fi

echo -e "${GREEN}Prerequisite setup completed successfully!${NC}"
echo "Verify your resources in the AWS Management Console"

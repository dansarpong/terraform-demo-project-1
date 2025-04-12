#!/bin/bash
set -e  # Exit on error

# Configuration
AWS_REGION="eu-west-1"
S3_BUCKET="terraform-demo-state-bucket"
DYNAMODB_TABLE="terraform-demo-state-lock"

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${RED}WARNING: This will delete all infrastructure resources!${NC}"
read -p "Are you sure you want to continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  exit 1
fi

# 1. Delete S3 bucket
echo -e "${YELLOW}Deleting S3 bucket...${NC}"
if aws s3api head-bucket --bucket $S3_BUCKET --region $AWS_REGION 2>/dev/null; then
  echo "Emptying bucket..."
  aws s3 rm s3://$S3_BUCKET --recursive --force --region $AWS_REGION
  echo "Deleting bucket..."
  aws s3api delete-bucket --bucket $S3_BUCKET --region $AWS_REGION
else
  echo "S3 bucket $S3_BUCKET does not exist"
fi

# 2. Delete DynamoDB table
echo -e "${YELLOW}Deleting DynamoDB table...${NC}"
if aws dynamodb describe-table --table-name $DYNAMODB_TABLE --region $AWS_REGION &>/dev/null; then
  aws dynamodb delete-table --table-name $DYNAMODB_TABLE --region $AWS_REGION
else
  echo "DynamoDB table $DYNAMODB_TABLE does not exist"
fi

echo -e "${GREEN}Prerequisite cleanup completed!${NC}"
echo "Verify resources have been removed in AWS Management Console"

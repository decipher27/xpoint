#!/bin/bash

help() {
    echo "Usage: $0 -n <BaseName> -s <DesiredCapacity> [-h]"
    echo "  -n  Base name for resources (e.g., 'awesome' for 'awesome-ASG')"
    echo "  -s  Number of instances in the Auto Scaling Group"
    echo "  -h  Display this help message"
    exit 1
}

# Default values
BASE_NAME=""
DESIRED_CAPACITY=1

while getopts ":n:s:h" opt; do
  case $opt in
    n) BASE_NAME="$OPTARG" ;;
    s) DESIRED_CAPACITY="$OPTARG" ;;
    h) help ;;
    \?) echo "Invalid option -$OPTARG" >&2; help ;;
  esac
done

if [[ -z "$BASE_NAME" || -z "$DESIRED_CAPACITY" ]]; then
    echo "Error: Both -n and -s are required."
    help
fi

# Deploy LaunchTemplate Stack
aws cloudformation deploy --template-file LaunchTemplate.yaml --stack-name "$BASE_NAME-LaunchTemplate"

# Capture LaunchTemplate ID
LAUNCH_TEMPLATE_ID=$(aws cloudformation describe-stacks --stack-name "$BASE_NAME-LaunchTemplate" --query "Stacks[0].Outputs[?OutputKey=='LaunchTemplateID'].OutputValue" --output text)

# Deploy AutoScalingGroup Stack with parameters
aws cloudformation deploy \
  --template-file AutoScalingGroup.yaml \
  --stack-name "$BASE_NAME-ASG" \
  --parameter-overrides BaseName="$BASE_NAME" DesiredCapacity="$DESIRED_CAPACITY" LaunchTemplateID="$LAUNCH_TEMPLATE_ID"

echo "Deployment complete for $BASE_NAME with $DESIRED_CAPACITY instances in the ASG."

#!/bin/bash

# Function to display help message
display_help() {
    echo "Usage: $0 -n <BaseName> -s <DesiredCapacity> [-h]"
    echo ""
    echo "Options:"
    echo "  -n    Base name for resources (e.g., 'awesome' for 'awesome-ASG')"
    echo "  -s    Desired number of instances in the Auto Scaling Group"
    echo "  -h    Display this help message"
    exit 1
}

# Default values for parameters
BASE_NAME=""
DESIRED_CAPACITY=1

# Parse command-line options
while getopts ":n:s:h" option; do
  case "$option" in
    n) 
      BASE_NAME="$OPTARG"  # Set base name for resources
      ;;
    s) 
      DESIRED_CAPACITY="$OPTARG"  # Set desired capacity for ASG
      ;;
    h) 
      display_help  # Show help message
      ;;
    \?) 
      echo "Error: Invalid option -$OPTARG" >&2
      display_help
      ;;
  esac
done

# Ensure required parameters are provided
if [[ -z "$BASE_NAME" || -z "$DESIRED_CAPACITY" ]]; then
    echo "Error: Both -n and -s options are required."
    display_help
fi

# Output values for confirmation
echo "Base Name: $BASE_NAME"
echo "Desired Capacity: $DESIRED_CAPACITY"

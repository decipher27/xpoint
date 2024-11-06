


# Instructions to Run the Script

Make sure both CloudFormation templates (LaunchTemplate.yaml and AutoScalingGroup.yaml) and the script (deploy.sh) are in same directory.

Grant execute permission to the script:

chmod +x deploy.sh

Run the script with the desired parameters. 

For example:
./deploy.sh -n awesome -s 3

The -h parameter will display the help message:
./deploy.sh -h

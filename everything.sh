AWS_DEFAULT_PROFILE=arista
# Create LOB VPC
aws cloudformation create-stack --template-body file:///$HOME/aws/cloudformation/lobvpc.json --stack-name lobvpc
# Create Transit VPC
aws cloudformation create-stack --template-body file:///$HOME/aws/cloudformation/transitvpc.json --stack-name transit

# Wait for LOB VPC
aws cloudformation wait stack-create-complete --stack-name lobvpc
# Create lob1
aws cloudformation create-stack --template-body file:///$HOME/aws/cloudformation/lob1vpc.json --stack-name lob1
# Create lob2
aws cloudformation create-stack --template-body file:///$HOME/aws/cloudformation/lob2.json --stack-name lob2
# Wait for transit VPC
aws cloudformation wait stack-create-complete --stack-name transit
# Create VPC Peer
aws cloudformation create-stack --template-body file:///$HOME/aws/cloudformation/vpcpeer.json --stack-name peer


# Create LOB VPC
aws cloudformation create-stack --template-body file:///$HOME/code/aws/cloudformation/lobvpc.json --stack-name lobvpc
# Create Transit VPC
# Wait for LOB VPC
aws cloudformation wait stack-create-complete --stack-name lobvpc
# Create lob1
aws cloudformation create-stack --template-body file:///$HOME/code/aws/cloudformation/lob1vpc.json --stack-name lob1
# Create lob2
aws cloudformation create-stack --template-body file:///$HOME/code/aws/cloudformation/lob2.json --stack-name lob2

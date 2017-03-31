
# Delete VPC Peer
# Delete lob1
aws cloudformation delete-stack --stack-name lob1
# Delete lob2
aws cloudformation delete-stack --stack-name lob2
# Delete LOB VPC
aws cloudformation delete-stack --stack-name lobvpc
# Delete Transit VPC
aws cloudformation delete-stack --stack-name transit

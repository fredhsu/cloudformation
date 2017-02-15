# ec2-basic
* When I created with these basic settings, it automatically added a network interface, put it in my VPC on a subnet, and assigned it to the default security group.
* Without specifying the InstanceType I kept getting error:

    Non-Windows instances with a virtualization type of 'hvm' are currently not supported for this instance type.

When I got this error it would rollback and remove everything it created

    aws cloudformation create-stack --stack-name test6 --template-body file:///$HOME/code/aws/cloudformation/ec2-basic.json

    {
    "StackId": "arn:aws:cloudformation:us-west-1:177340232285:stack/test6/abbb3e60-f305-11e6-acc6-50faf037148d"
    }

* Deleting the stack cleans it all up

    aws cloudformation delete-stack --stack-name test6

# ec2-sg
* This template adds to the first with a security group parameter definition
* Added `InstanceSecurityGroup` as another resource, then we refer to it as a property with a `ref` to it.  The resource name is a key to the value of the resource

# ec2-nic
* Adding a network interface using NetworkInterfaces
* If I add more than one in that array, then it will only give private.  To have one public and multiple private then I have to add one using this and then do addInterface for the privates.
* Requires subnetId
* Setting SourceDestCheck to false
* Network interfaces and an instance-level security groups may not be specified on the same request
    * Will resolve next time with a VPC level security group
* Automatically assigned both public and private IP addresses

# vpc.json
* Create a simple VPC with default settings and CIDR of 10.0.0.0/16

# vpc-sg-igw.json
* Create VPC
* Add security group to vpc
* create internet gateway
* Attach igw to the VPC

# vpc-ec2-sg-nic
* Create a VPC with a new EC2 instance and an associated security group
* Create with a VPC security group since I can't create it with an instance one

# vpc-ec2-3nic-sg

# cross-stack reference
http://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/walkthrough-crossstackref.html
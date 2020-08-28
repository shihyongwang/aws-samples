## AWS CloudFormation
AWS CloudFormation provides a common language for you to model and provision AWS infrastructure resources. Check [the official site](https://aws.amazon.com/cloudformation/) for more information.

### Sample architecture on AWS
#### Network Layer
- Enable 2 AZs at the destination VPC.
- Create 3 subnets at each AZ.
  - public subnet for bastion box, NAT gateway.
  - private subnet for Web, App, ElastiCache, AES, etc.
  - private subnet for database.
- Could create the 4th subnet for transit purpose (optional)

#### Bastion Layer
- Instance type "t" should be enough. But Spot is not preferred.
- A jump box could without EBS.
- Protect the bastion with ASG to make sure there is always one box online.
- The case of CIDR at SG, allow to corp NAT is preferred.
- At this moment, this bastion would with permission to access such as S3, CodeDeploy, SNS, etc.

#### Application Layer
- Create ALB at public subnets.
- Create ASG at private subnets,
- Create SG by allowing traffic from 0.0.0.0/0 via port 80 and 443.
- There are always at least 2 instances online.
- EC2 instances are created with EBS friendly.

### Reference
- Per [https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-validate-template.html](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-validate-template.html) , you could validate your YAML via CLI:
```bash
aws cloudformation validate-template --template-body files:///home/YOUR_ID/YOUR_PATH/cfn_YOUR_STACK.yaml
```
- [AWS CloudFormation Best Practices](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/best-practices.html
- [AWS CloudFormation Template Reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/template-reference.html)
- [CFN lint for VSCode](https://github.com/awslabs/aws-cfn-lint-visual-studio-code)
- [Use AWS CloudFormer to create CloudFormation Template](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-using-cloudformer.html)
- [Import Existing Resources into a CloudFormation Stack](https://aws.amazon.com/blogs/aws/new-import-existing-resources-into-a-cloudformation-stack/)

### Free CFN Templates
- [https://github.com/awslabs/aws-cloudformation-templates](https://github.com/awslabs/aws-cloudformation-templates)
- [https://templates.cloudonaut.io/en/stable/](https://templates.cloudonaut.io/en/stable/)



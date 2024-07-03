## course docs
https://courses.datacumulus.com/downloads/certified-cloud-practitioner-zb2/


## aws-cli completion
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html

## Refs
- AWS Blogs: https://aws.amazon.com/blogs/aws/ 
- AWS Forums (community): https://forums.aws.amazon.com/index.jspa
- AWS Whitepapers & Guides: https://aws.amazon.com/whitepapers 
- AWS Partner Solutions (formerly Quick Starts): https://aws.amazon.com/quickstart/ 
  - Automated, gold-standard deployments in the AWS Cloud
  - Build your production environment quickly with templates
  - Example: WordPress on AWS https://fwd.aws/P3yyv?did=qs_card&trk=qs_card 
  - Leverages CloudFormation 
- AWS Solutions: https://aws.amazon.com/solutions/ 
  - Vetted Technology Solutions for the AWS Cloud
  - Example - AWS Landing Zone: secure, multi-account AWS environment
    - https://aws.amazon.com/solutions/implementations/aws-landing-zone/ 
    - “Replaced” by AWS Control Tower
- AWS re:Post Knowledge Center: https://repost.aws/knowledge-center/


## useful

### Budget
- Billing and Cost Management -> Budgets -> Create Budget
- Use defaults (Zero spending budget) 


# EC2 (Elastic Compute Cloud)

## Security Groups
aka Firewall. Can have multiple security groups assigned to a

## SSH
- ssh
~~~bash
ssh -i <pem-file> ec2-user@<public-ip>
~~~

- EC2 Instance Connect
(Console) > goto <instance> -> Connect

OR

aws ec2-instance-connect ssh --instance-id <instance-id>
aws ec2-instance-connect ssh --instance-ip <instance-ip>

## EC2 IAM Role
To run `aws` command in a ssh shell, it is not recommended to configure the account id on the instance.
Instead, can attach a IAM Role to allow the commands to access the account (IAMReadOnlyAccess).
- can create a role with read only permissions for IAM
- Security -> Update IAM Role


# EBS (Elastic Block Storage)
Storage blocks can be created in a zone of a region, and can only be assigned to the EC2 instances of the same zone.

## EBS Snapshots
Backup (recommended to do when detached).
Can be:
- opied to another region
- used to created another volume (even another zone)

### Recycle Bin
There is a recycle bin for snapshots. 
Using a retention rule, can configure the time to retain deleted snapshots.


## AMI (Amazon Machine Image)
Customization of EC2 instance.
Can use public, custom mantained or marketplace images.

### Example custom
- Create EC2 Instance, use User Data script to install updates and packages
- Start EC2 instance
- Create AMI from the instance
- Use the saved AMI in another instance

### EC2 Instance Builder
- automate the creation, mantain, validate and test of EC2 AMIs
- can be distributed to other regions
- can be ran on a schedule


## EC2 Instant Store
aka Disk storage
- better IO performance
- good for buffer, cache, temporary content
- risk of data loss if hardware fails

## EFS (Elastic File System)
- Managed NFS (network file system), can be mounted on 100s of EC2
- Highly available, scalable, expensive

## FSx
- fully managed high performance scalable file storage for HPC (high performance computing)


# Scalability & High Availability

## Scalability
- Vertical (more hardware, increase size of instance. example: database)
- Horizontal (more instances, distributed systems)
  - Auto Scaling Group
  - Load Balancer

## High Availability
Running system in at least 2 availability zones.

## Elastic Load Balancer
Load Balancer provided by AWS (instead of custom managed by customer).
Types:
- Application LB
- Network LB
- Gateway LB: route traffic to firewalls, intrusion detection
- Classic LB (retired in 2023)


# Tools
- CIDR range visualizer: https://cidr.xyz/

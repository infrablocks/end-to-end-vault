# End to End Example - Vault

This example deploys a fully working Vault instance into an ECS Cluster
using KMS to auto unseal and PostgreSQL as the storage backend.

Only a single instance of Vault is deployed in this example.

As this is only an example your deployment strategy might differ, this is merely
meant as a start-off point.

# How To Deploy

This project uses `Rake` as a build tool and nearly all necessary commands
are run through rake. 
Please note that the order in which to run the commands are reflected by the 
order of the blocks in `Rakefile`

## Requirements

* Domain
* AWS Account & Access Credentials

## Instructions
The following steps often require a deployment identifier and the domain you own.
We use `tungsten` (random element) and `replace.me.uk` in the instruction.
Other identifiers that need to be replaced 

Identifiers that need to be replaced are indicated with `{}`.
`deployment-identifier` can be any random word; we like to use elements e.g. 'tungsten'.
`domain` has to be the base name of the domain you own e.g. 'example.com'

### Bootstrap
This deploys an S3 bucket in which all terraformstate files of the following steps
are stored.

`go "bootstrap:provision[{deployment-identifier}]"`

### Deploy Domain
Deploys a Route53 Domain.

`go "domain:provision[{deployment-identifier},{domain}]"`

### Update Nameserver on Domain to Point At Hosted Zone (Manual)

This is a manual step where you have to update the nameservers on your domain
to point to the public hosted zone created by the previous step.

### Deploy Certificate
`go "certificate:provision[{deployment-identifier},{domain}]"`

### Deploy Network
`go "network:provision[{deployment-identifier}]"`

### Generate SSH Key for Bastion (Manual)

`ssh-keygen -t rsa -b 4096 -C bastion@{domain} -N '' -f config/secrets/bastion`

Rename the generated files to `ssh.private` and `ssh.public`

### Deploy Bastion
`go "bastion:provision[{deployment-identifier}]"`

### Set Outbound Rules (Manual)

Currently infrablocks/bastion only allows outbound traffic on port 22. 
To be able to connect to the database add an outbound rule
for port 5432.

### Test Bastion Is Working
The following command should give you access to the bastion.
The public ip can be found in the info page of the EC2 instance in the AWS Console.

`ssh -i config/secrets/bastion/ssh.private ec2-user@{bastion-public-ip}`

### Deploy Database 
`go "database:provision[{deployment-identifier}]"`

This may take a few minutes.

### Test Connecting to Database Via Bastion
The following command will create a tunnel on your machine's port `5432` to the 
database in RDS.

The host name can be found in the info page of the RDS instance in the AWS Console.

`ssh -i config/secrets/bastion/ssh.private -N -L 5432:{rds-host-name}:5432 ec2-user@{bastion-public-ip}`

There will be no output from this command and the terminal will keep the connection
open until the command is terminated.

While the tunnel is open it should be possible to connect to the database 
on `localhost:5432`.

### Deploy Database Migrations
`go "database_migrations:provision[{deployment-identifier}]"`

### Deploy Cluster 
`go "cluster:provision[{deployment-identifier}]"`

### Deploy Service
`go "service:provision[{deployment-identifier},{domain}]"`

### Test Vault Is Running

Access your Vault instance by accessing `https://vault-{deployment-identifier}.{domain}`
in your browser.

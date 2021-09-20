---
title: Assuming a Role from the Instance Profile (AWS PowerShell)
date: '2018-06-22'
author: Adam

layout: post

permalink: /2018/06/22/aws-powershell-assume-role-from-instance-profile/

excerpt: |
  IAM Roles are a powerful way to delegate permissions in AWS. But, there is a
  trick to assuming a role from the EC2 Instance Profile. Here's how to do it!

categories:
  - Cloud
---
I wanted to share a workaround I came up with for a specific challenge in the
AWS PowerShell tools. In a sense, this is an addendum to my Pluralsight course,
since it was published before I came across this scenario. I’ll try to keep it
brief since you’re probably only here to get the workaround so you can get back
to work.

## The problem

You need to assume a role. The AWS PowerShell tools have the ability to create a
credential profile that assumes a role. It will even take care of renewing the
temporary credentials when necessary. Great!

What’s potentially not as great is the fact that “assume role” type credential
profiles require you to designate a source profile. In many cases that’s not an
issue. But, if you are relying on an EC2 instance profile to authenticate your
PowerShell commands, you may not have a profile.

That’s the exact scenario I came across.

## The workaround

This is what you’re here for: the code!

``` powershell
# This is the URI for the folder one level above the credentials we need.
$MetadataUri = `
    "http://169.254.169.254/latest/meta-data/iam/security-credentials"

# We need to get the contents of the folder to know the name of the subfolder.
# Technically there could be multiple but I haven't seen that happen. We will
# just use the first one.
$CredentialsList = ( `
    Invoke-WebRequest -uri $MetadataUri `
).Content.Split()

# Get the credentials and turn the JSON text into an object.
$CredentialsObject = (Invoke-WebRequest `
    -uri "$MetadataUri/$($CredentialsList[0])" `
).Content | ConvertFrom-Json

# Create/update a profile using the temporary access key and secret key
# we retrieved from the metadata.
Set-AWSCredential `
    -StoreAs InstanceProfile `
    -AccessKey $CredentialsObject.AccessKeyId `
    -SecretKey $CredentialsObject.SecretAccessKey `
    -SessionToken $CredentialsObject.Token

# Create/update the assume role profile.
Set-AWSCredential `
    -StoreAs default `
    -RoleArn $YourRoleArnHere `
    -SourceProfile InstanceProfile
```

That’s all there is to it, but there are a few things to note about this code.

The temporary credentials found in the metadata do expire, so you’ll need to
re-run this periodically to get the latest access key and secret key.

In the code listed here, the assume role profile is named default. That means
the assume role profile is the one that will be used unless you specify another
one. You don’t have to do it this way, you can give it an arbitrary name and set
it as the session profile using Set-AWSCredential or on a cmdlet-by-cmdlet basis
using the -ProfileName parameter. You will need to specify your own value for
the variable $YourRoleArnHere.

This scenario is a non-issue if you’re using the AWS CLI. I found a feature
request on GitHub from 2015. This eventually lead to a change in the botocore
module, on top of which both the CLI and the Python SDK are built. The change
allows users to create a profile with the type “EC2InstanceMetadata” which can
then simply be used as the source profile for the assume role credential
profile. This ability is not present in the AWS PowerShell tools.

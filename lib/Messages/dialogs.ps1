$script:devOpsDownloadPipelineDialog = @"
Pipeline is saved in C:\Scripts\Testing\connector\publicpipeline.json.
    
Open file with preferred editor.

!!!Important!!!:
- Save as UTF-8
- Save with CRLF
- Remove <metadata> element from pipeline definition body

Otherwise pipeline update will fail due json incompatibility!

See:
https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-quoting-strings.html
"@;

$script:sshConnectDialog = @"
Please choose an EC2 instance to proceed
"@;

$script:devOpsUploadPipelineDialog = @"
Please choose an AWS codepipeline to proceed
"@;

$script:devOpsStartPipelineDialog = @"
Pipeline started successfully
"@;

$script:devOpsMissingDialog = @"
Please choose an AWS Account and Service to proceed
"@;

$script:instancesMissingDialog = @"
No EC2 instances found in this Account
"@;

$script:pipelinesMissingDialog = @"
No Pipelines found in this Account
"@;

$script:codebuildMissingDialog = @"
No codebuild projects found in this Account
"@;

$script:lgMissingDialog = @"
Please choose at least one LG and provide a valid date
"@;

$script:lgSuccessDialog = @"
LG succeeded
"@;

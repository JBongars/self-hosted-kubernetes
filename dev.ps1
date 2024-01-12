# Run me to start a new dev container
# For more info see: https://github.com/JBongars/docker-tools
# source: https://github.com/JBongars/docker-tools/tree/main/images/aws

$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$homeDir = $env:HOME

# Docker run command
docker run -it `
    -v "${projectDir}:/work" `
    --hostname dtools-aws `
    -v "${homeDir}/.gitconfig:/root/.gitconfig" `
    -v "${homeDir}/.netrc:/root/.netrc" `
    -v "${homeDir}/.ssh:/root/.ssh" `
    -v "${homeDir}/.git-credentials:/root/.git-credentials" `
    -v "${homeDir}/.terraform.d:/root/.terraform.d" `
    -v "${homeDir}/.aws:/root/.aws" `
    --rm dtools_aws:latest fish

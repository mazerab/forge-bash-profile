# forge-bash-profile

## Description 

Bash scripts that can set Forge environments using AWS CLI.

### Thumbnail

<img src="/assets/images/bash-script-demo.gif" width="600" height="400">

## Setup

### Pre-requisites

1. You have access to an AWS account
2. You have installed [AWS CLI](https://aws.amazon.com/cli/)
3. You have created secret stores in [AWS Secrets Manager](https://aws.amazon.com/secrets-manager/) for the forge apps you want to set the environment for 

### Running locally

Open a new terminal window and run the command **listForgeApps** to see the list of Forge Apps you have configured in your environment. If you want to set the Forge environment for a specific Forge app, run the command **setForgeDemoAppEnv** and input the app number you wish to use. After pressing ENTER, the Forge environment variables will be set for you. 

### Deployment

## Further Reading

[About bash_profile and bashrc on MacOS](https://scriptingosx.com/2017/04/about-bash_profile-and-bashrc-on-macos/)

### Tips & Tricks

### Troubleshooting

If you make changes to the .bashrc file, you can apply the changes in your current terminal by running the command **source ~/.bash_profile**.

### License

This sample is licensed under the terms of the [MIT License](http://opensource.org/licenses/MIT). Please see the [LICENSE](LICENSE) file for full details.

### Written By

Bastien Mazeran [@BastienMazeran](https://twitter.com/BastienMazeran), Autodesk Inc.

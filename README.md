# advt

Welcome to the repository for Autonomous Delivery at Virginia Tech!

## Dev Container Setup

1. Install [git](https://git-scm.com/install/)
2. Clone the repository over ssh (recommended) or https
    * `git clone git@github.com:advt-vt/advt.git`
    * `git clone https://github.com/advt-vt/advt.git`
3. Install Docker
    * Windows
      * I don't use windows. Someone please check / fix this (taken from [this](https://code.visualstudio.com/docs/devcontainers/containers#_installation))
      1. Install Ubuntu [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
         1. Open Powershell as an administrator
         2. Type `wsl --install`
         3. Enter your user information
      2. Ensure the [WSL 2 back-end](https://aka.ms/vscode-remote/containers/docker-wsl2) is enabled
      3. Check **Use the WSL 2 based engine** and verify Ubuntu is enabled under **Resources > WSL Integration**
      4. Install [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)
      5. Add yourself to the docker user group in WSL

         ``` bash
         sudo groupadd docker
         sudo usermod -aG docker $USER
         newgrp docker
         ```

    * Linux
      1. Install [Docker Engine](https://docs.docker.com/engine/install/) for your distribution
         * You can instead install [Docker Desktop](https://docs.docker.com/desktop/setup/install/linux/) if you want
      2. Add yourself to the docker user group

         ``` bash
         sudo groupadd docker
         sudo usermod -aG docker $USER
         newgrp docker
         ```

      3. Restart your computer
4. Install [VS Code](https://code.visualstudio.com/Download)
5. Install [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension in VS Code
   1. Press `Ctrl+P`/`⌘P`
   2. Type `ext install Dev Containers`
   3. Press `Install`, then `Enable`
6. Open the container
   1. Press `Ctrl+P`/`⌘P`
   2. Type `>Dev Containers: Open Folder in Container`

### [Known Limitations]((https://code.visualstudio.com/docs/devcontainers/containers#_known-limitations)) of Dev Containers

* The unofficial Ubuntu Docker snap package for Linux is not supported.
* Docker Toolbox on Windows is not supported.
* If you clone a Git repository using SSH and your SSH key has a passphrase, VS Code's pull and sync features may hang when running remotely. Either use an SSH key without a passphrase, clone using HTTPS, or run `git push` from the command line to work around the issue.
* Local proxy settings are not reused inside the container, which can prevent extensions from working unless the appropriate proxy information is configured (for example global `HTTP_PROXY` or `HTTPS_PROXY` environment variables with the appropriate proxy information).
* There is an incompatibility between OpenSSH versions on Windows when the ssh-agent runs with version <= 8.8 and the SSH client (on any platform) runs version >= 8.9. The workaround is to upgrade OpenSSH on Windows to 8.9 or later, either using winget or an installer from [Win32-OpenSSH/releases](https://github.com/PowerShell/Win32-OpenSSH/releases). (Note that `ssh-add -l` will work correctly, but `ssh <ssh-server>` will fail with `<ssh-server>: Permission denied (publickey)`. This also affects Git when using SSH to connect to the repository.)

## THINGS TO DO

* Talk to Media Lead about either keeping the standalone front-facing website or making a version here that is deployed on Virginia Tech's web services
* Create subrepositories/files for Autonomy, PCB designs, Solidwork files, Ground Systems, Telemetry, Documentation, etc.

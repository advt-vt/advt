# advt

Welcome to the repository for Autonomous Delivery at Virginia Tech!

## Dev Container Setup

1. Install [git](https://git-scm.com/install/)
2. Clone the repository over ssh or https
3. Install Docker
    * Windows - [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)
        * I don't use windows. Someone please check / fix this (taken from [this](https://code.visualstudio.com/docs/devcontainers/containers#_installation))
        * If we are using WSL
          * Ensure the [WSL 2 back-end](https://aka.ms/vscode-remote/containers/docker-wsl2) is enabled
          * Check **Use the WSL 2 based engine** and verify Ubuntu is enabled under **Resources > WSL Integration**
        * If we are not using WSL
          * Right-click on the Docker task bar item, select **Settings** and update **Resources > File Sharing** with the repository path
    * Linux - [Docker Engine](https://docs.docker.com/engine/install/)
        * You can also install Docker Desktop if you want
        * Install Docker Desktop or Docker Engine for your distribution
        * Add yourself to the docker user group `sudo usermod -aG docker $USER`
        * Restart
4. Install [VS Code](https://code.visualstudio.com/Download)
5. Install [Dev Container](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension in VS Code
6. In VS Code run `>Dev Containers: Open Folder in Container`

---

THINGS TO DO:

* Talk to Media Lead about either keeping the standalone front-facing website or making a version here that is deployed on Virginia Tech's web services
* Create subrepositories/files for Autonomy, PCB designs, Solidwork files, Ground Systems, Telemetry, Documentation, etc.

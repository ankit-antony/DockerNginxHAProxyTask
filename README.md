# DockerNginxHAProxyTask

Task:
Create web cluster with two docker containers with a bash script

Environment:
Docker CE, CentOS 7, HAProxy 1.6, Nginx any version

Description:
Write a script, which will:
1. create and run 2 Docker containers
2. installs HAProxy and Nginx in both containers
3. configured HAProxy to send traffic to working Nginx servers

Acceptance criteria:
Solution should be prepared as only one script, which creates two Docker images, run containers from them, configures Nginx and HAProxy, checks Nginxs availability on both containers after start using HAProxy healthchecks.


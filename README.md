# DemoLab
Jenkins, Ansible, Artifactory, Docker, Git workflow

This code will run latest Jenkins instance on Ubuntu 16.04 LTS using vagrant on public IP address:
http://192.168.100.10:8080/
And 3 environments with JDK and Docker:
Dev - 192.168.100.11
Stage - 192.168.100.12
QA - 192.168.100.13

## Prerequisites
* [VirtualBox](https://www.virtualbox.org/)
* [Vagrant](https://www.vagrantup.com/)

Usage
-----

```bash
$ git clone https://github.com/KuzmaTolyanuch/DemoLab
$ cd DemoLab
$ vagrant up --provision
```

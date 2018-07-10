#!/bin/bash
# This script will install Jenkins, Java, Maven, Docker, Git, and Asible.

#################################
# Jenkins & Java setup
#################################
echo "Installing Jenkins and Java"
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update > /dev/null 2>&1
sudo apt-get -y install default-jdk jenkins > /dev/null 2>&1

sudo add-apt-repository ppa:webupd8team/java
sudo apt-get -y install oracle-java8-installer

#################################
# Docker
#################################
echo "Installing Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get -y install docker-ce
sudo systemctl enable docker
sudo usermod -aG docker ${USER}
sudo usermod -aG docker jenkins
sudo usermod -aG docker ubuntu

#################################
# nginx
#################################
echo "Installing nginx"
sudo apt-get -y install nginx > /dev/null 2>&1
sudo service nginx start

#################################
# Configuring nginx for Jenkins
#################################
echo "Configuring nginx"
cd /etc/nginx/sites-available
sudo rm default ../sites-enabled/default
sudo cp /vagrant/VirtualHost/jenkins /etc/nginx/sites-available/
sudo ln -s /etc/nginx/sites-available/jenkins /etc/nginx/sites-enabled/
sudo service nginx restart
sudo service jenkins restart

#################################
# Saving Jenkins Initial Pass
#################################
sudo cp /var/lib/jenkins/secrets/initialAdminPassword /vagrant/JenkinsPass.txt

echo "Jenkins install complete, Initial Password is in a local project directory"
echo ""
echo ""
echo ""

# Usage Example:
# ./install_ansible.sh 'v1.1' path/to/local/ansible/hosts/file
# Look up https://github.com/ansible/ansible for version tags to use

versionTag=$1
ansibleHosts=$2

#################################
# Install Git
#################################

echo "[Install Ansible] Install Git"
sudo apt-get install -y git-core

#################################
# Install Ansible Dependencies
#################################

echo '[Install Ansible] Install dependencies'
sudo apt-get install -y python-setuptools
sudo easy_install jinja2 
sudo easy_install pyyaml
sudo easy_install paramiko
sudo apt-get install make

#################################
# Install Ansible
#################################

echo "[Install Ansible] Go to Home folder"
cd ~
echo '[Install Ansible] Git Clone Ansible'
git clone https://github.com/ansible/ansible.git ansible
cd ansible

echo '[Install Ansible] Checkout to desired tag'
git checkout $versionTag

echo '[Install Ansible] Make and Install'
sudo make install

echo '[Install Ansible] Clean up!'
cd ..
sudo rm -rf ansible

echo '[Install Ansible] Copy Ansible HOSTS'
sudo mkdir -p /etc/ansible && sudo cp -fr $ansibleHosts /etc/ansible/hosts

echo '[Install Ansible] Update Permissions on hosts file'

# Giving exec permission causes issues when running ansible

sudo chmod 644 /etc/ansible/hosts

echo '[Install Ansible] Export ANSIBLE_HOST path'
export ANSIBLE_HOSTS=/etc/ansible/hosts

echo '[Install Ansible] Done!'

#################################
# Maven install
#################################
set -e

# script to install maven

# todo: add method for checking if latest or automatically grabbing latest
mvn_version=${mvn_version:-3.5.2}
url="http://www.mirrorservice.org/sites/ftp.apache.org/maven/maven-3/${mvn_version}/binaries/apache-maven-${mvn_version}-bin.tar.gz"
install_dir="/opt/maven"

if [ -d ${install_dir} ]; then
    mv ${install_dir} ${install_dir}.$(date +"%Y%m%d")
fi

mkdir ${install_dir}
curl -fsSL ${url} | tar zx --strip-components=1 -C ${install_dir}

cat << EOF > /etc/profile.d/maven.sh
#!/bin/sh
export MAVEN_HOME=${install_dir}
export M2_HOME=${install_dir}
export M2=${install_dir}/bin
export PATH=${install_dir}/bin:$PATH
EOF

source /etc/profile.d/maven.sh

echo maven installed to ${install_dir}
mvn --version

printf "\n\nTo get mvn in your path, open a new shell or execute: source /etc/profile.d/maven.sh\n"

echo "Success"

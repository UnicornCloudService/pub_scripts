#!/bin/bash
# Script to install Maven
wget https://downloads.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz
tar -xvf apache-maven-3.9.4-bin.tar.gz
sudo mkdir -p /usr/share/maven
sudo mv apache-maven-3.9.4/* /usr/share/maven
sudo ln -s /usr/share/maven/bin/mvn /usr/bin/mvn
sudo echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/profile.d/maven.sh
sudo echo "export JAVA_HOME_17_X64=/usr/lib/jvm/java-17-openjdk-amd64" >> /etc/profile.d/maven.sh
sudo echo "export MAVEN_HOME=/usr/share/maven" >> /etc/profile.d/maven.sh
sudo echo "export M2_HOME=~/.m2" >> /etc/profile.d/maven.sh
sduo echo "export MAVEN_CONFIG=$~/.m2" >> /etc/profile.d/maven.sh
sudo chmod +x /etc/profile.d/maven.sh
rm apache-maven-3.9.4-bin.tar.gz
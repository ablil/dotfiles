# Table of content
 * IDEs
 * Python development
 * Java development
 * Nodejs Development

## Python3
Install Python3 on **Fedora**
```
sudo dnf install -y python3 python3-devel python3-pip
```

Install Python3 on **Debian**
```
sudo apt-get install -y python3 python3-dev python3-pip
```

Install some useful packages
```
pip3 install howdoi black
```

Set python3 as default python
```
update-alternatives --install /usr/bin/python python $(which python3) 1
update-alternative --install /usr/bin/pip pip $(which pip3) 1
```

## Java
Install java8 & java11 on **Debian**
```
sudo apt-get install -y openjdk-11-jdk
```

Install java8 & java11 on **Fedora**
```
sudo dnf install -y java-11-openjdk-devel
sudo dnf install -y java-1.8.0-openjdk-devel
```

Set java11 as default java version
```
sudo update-alternatives --config java
```

Get JAVA_HOME (remove bin directory)
```
export JAVA_HOME=$(readlink -f $(which java) | sed 's/\/bin\/java//')
```

## Maven

Install on **Debian**
```
sudo apt-get -y install maven
```

Install on **Fedora**
```
sudo dnf -y install maven
```

Set ANT_HOME
```
export M2_HOME=$(readlink -f $(which mvn) | sed 's/\/bin\/mvn//')
```

## Docker

Install using a script from the official [website](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script) for **Debian**

Install using a script from the official [website]()https://docs.docker.com/engine/install/fedora/#install-using-the-convenience-script for **Fedora**

Add current user to docker group
```
sudo usermod -aG docker $(whoami)
```

## Database clients

### Mysql client

Install client on **Fedora**
```
sudo dnf install -y community-mysql
```

### PostgreSql client

Install client on **Fedora**
```
sudo dnf install -y postgresql
```

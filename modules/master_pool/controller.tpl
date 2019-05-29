#!/bin/bash

function prep_bird_repo {
  yum install curl -y ; \
  cat << EOF > /etc/yum.repos.d/bird.repo
[bird]
name=Network.CZ Repository
baseurl=ftp://repo.network.cz/pub/bird/centos/7/x86_64/
enabled=1
gpgcheck=0
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-network.cz
EOF
}

function bird_config {
  if [ ! -d /etc/pki/rpm-gpg/ ]; then
    mkdir -p /etc/pki/rpm-gpg/
  fi
  curl ftp://bird.network.cz/pub/bird/redhat/RPM-GPG-KEY-network.cz -o /etc/pki/rpm-gpg/RPM-GPG-KEY-network.cz && \
  yum install -y bird
}

function start_anycast {
	apt update; apt install -y bird ; \
	while true; do \
		if [ ! -f /root/create_bird_conf.sh ]; then \
			echo "Bird not ready...waiting..."
		else
			bash /root/create_bird_conf.sh "${anycast_ip}"
			break
		fi
	done
}

prep_bird_repo && \
bird_config && \
start_anycast

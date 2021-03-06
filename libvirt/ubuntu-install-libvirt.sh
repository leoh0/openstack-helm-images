#!/bin/bash
set -ex
export DEBIAN_FRONTEND=noninteractive ;\
apt-key add /etc/apt/ceph-${CEPH_RELEASE}.key ;\
rm -f /etc/apt/ceph-${CEPH_RELEASE}.key ;\
echo "deb ${CEPH_REPO} ${UBUNTU_RELEASE} main" | tee /etc/apt/sources.list.d/ceph.list ;\
apt-get update ;\
apt-get upgrade -y ;\
apt-get install --no-install-recommends -y \
  ceph-common \
  cgroup-tools \
  dmidecode \
  ebtables \
  iproute2 \
  libvirt-bin \
  pm-utils \
  qemu \
  qemu-block-extra \
  qemu-efi \
  openvswitch-switch ;\
groupadd -g ${GID} ${PROJECT} ;\
useradd -u ${UID} -g ${PROJECT} -M -d /var/lib/${PROJECT} -s /usr/sbin/nologin -c "${PROJECT} user" ${PROJECT} ;\
mkdir -p /etc/${PROJECT} /var/log/${PROJECT} /var/lib/${PROJECT} /var/cache/${PROJECT} ;\
chown ${PROJECT}:${PROJECT} /etc/${PROJECT} /var/log/${PROJECT} /var/lib/${PROJECT} /var/cache/${PROJECT} ;\
usermod -a -G kvm ${PROJECT} ;\
apt-get clean -y ;\
rm -rf \
   /var/cache/debconf/* \
   /var/lib/apt/lists/* \
   /var/log/* \
   /tmp/* \
   /var/tmp/*

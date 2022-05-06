#!/bin/env bash

# Add elrepo repository
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
yum -y install https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm

# install long term support version of kernel
yum -y --disablerepo="*" --enablerepo=elrepo-kernel install kernel-lt
yum -y remove kernel-tools kernel-tools-libs
yum -y --disablerepo="*" --enablerepo=elrepo-kernel install kernel-lt-tools kernel-lt-tools-libs

# configure grub2
awk -F \' '/^menuentry/ {print i++ " : " $2}' /boot/grub2/grub.cfg
read -p "configure grub2, input index number: " entry
grub2-set-default $entry

# reboot system
read -p "The upgrade effect after reboot system, reboot now ?[y]: " awk
if [[ $awk = "y" ]]; then
    reboot
fi

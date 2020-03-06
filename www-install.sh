#!/bin/bash

###################################################
# DISCLAIMER: Read this script before you run it
#    so you aren't surprised by anything it does
###################################################

###################################################
# PREREQUISITES
#    YUM installed on an IBM i (shorturl.at/duz02)
#    BASH terminal (don't use PASE)
###################################################

###################################################
# Yum Repo/Package Installations
###################################################

# make yum-config-manager command available
yum -y install yum-utils

# add PHP-FPM repo
yum-config-manager --add-repo http://repos.zend.com/ibmiphp/

# update current repos & packages
yum clean all
yum -y update

# install all other requisite packages for PHP-FPM + Nginx
yum -y install php* nginx unixODBC unixODBC-devel sed-gnu rsync

# move errant php.ini location (remove after IBM releases fix)
PHPINIFROM=/QOpenSys/etc/php.ini
PHPINITO=/QOpenSys/etc/php/
if [ -f "$PHPINIFROM" ]; then
  mv $PHPINIFROM $PHPINITO
fi

wget --no-check-certificate https://worksofbarry.com/files/ibm-iaccess-1.1.0.11-0.ibmi7.2.ppc64.rpm
yum -y install ./ibm-iaccess-1.1.0.11-0.ibmi7.2.ppc64.rpm

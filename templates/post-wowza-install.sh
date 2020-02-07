#!/bin/bash
WOWZA_ROOT=/usr/local/WowzaStreamingEngine

# Backup all original files
cp -rp $WOWZA_ROOT/manager/conf/tomcat.properties $WOWZA_ROOT/manager/conf/tomcat.properties.orig
cp -rp $WOWZA_ROOT/conf/VHost.xml $WOWZA_ROOT/conf/VHost.xml.orig
cp -rp $WOWZA_ROOT/conf/Server.xml $WOWZA_ROOT/conf/Server.xml.orig

# Copy Ansible deployed tomcat.properties to configure HTTPS on StreamingEngineManager
cp -rp /opt/wowza/src/tomcat.properties $WOWZA_ROOT/manager/conf/tomcat.properties

# Copy Ansible deployed JKS to Wowza directory
cp -rp /opt/wowza/src/ssl/{{ ansible_hostname }}.jks $WOWZA_ROOT/conf

# Turn on HTTPS for REST API
sed -i '14s/false/true/' $WOWZA_ROOT/conf/Server.xml
sed -i '15s/<KeyStorePath><\/KeyStorePath>/<KeyStorePath>\/usr\/local\/WowzaStreamingEngine\/conf\/{{ ansible_hostname }}.jks<\/KeyStorePath>/' $WOWZA_ROOT/conf/Server.xml
sed -i '16s/<KeyStorePassword><\/KeyStorePassword>/<KeyStorePassword>{{ jks_password }}<\/KeyStorePassword>/' $WOWZA_ROOT/conf/Server.xml

# Remove VHost 443 comments to enable HTTPS
sed -i '60s/<\!--//' $WOWZA_ROOT/conf/VHost.xml
sed -i '111s/-->//' $WOWZA_ROOT/conf/VHost.xml
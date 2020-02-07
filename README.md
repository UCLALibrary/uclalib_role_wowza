UCLA Library Wowza Role [![Build Status](https://travis-ci.com/UCLALibrary/uclalib_role_wowza.svg?branch=master)](https://travis-ci.com/UCLALibrary/uclalib_role_wowza)
=========

Ansible role to install Wowza. Due to licensing restrictions of Wowza, this role does not currently support a full installation of Wowza. You'll need to request a [silent key license](https://www.wowza.com/docs/how-to-install-and-configure-wowza-streaming-engine) if you want to install Wowza unattended.

Requirements
------------

In addition to pre-requisite packages installed by the Ansible role, you'll need a Wowza License Key to install Wowza. This role will also set up HTTPS on the Engine and the Manager.

Role Variables
--------------

Required Adjustment
###
* jks_crt_src_path
  * Path on your ansible controller to X.509 certificate that'll be used to create a JKS for Wowza
* jks_key_src_path
  * Path on your ansible controller to associated SSL key with generated certificate that'll be used to create a JKS for Wowza
* jks_password
  * Specify a password to secure the created JKS

Optional
###
* jks_root_path
  * Store JKS and certificates in Wowza install directory on remote host
* jks_crt_dest_path
  * Default currently stores X.509 certificate on remote host
* jks_key_dest_path
  * Default currently stores associated SSL key on remote host
* jks_dest_path
  * Default currently stores associated SSL key on remote host
* jks_root_path
  * Store JKS and certificates in Wowza install directory
* java_version
  * Default to install OpenJDK 11
* wowza_version
  * Set to 4.7.8
* wowza_linux_download_url
  * Dynamic link that downloads Wowza from the source
* wowza_download_path
  * Path on remote host to download Wowza installation script

Dependencies
------------

No external dependencies, you will likely want to configure a firewall from an external role.

Default ports opened are:
* 443
  * Default streaming port
* 1935
  * Default RTSP streaming port
* 8086
  * Admin port
* 8087
  * HTTP/HTTPS REST API
* 8088
  * HTTP EngineManager
* 8090
  * HTTPS EngineManager

Example Playbook
----------------

This role can be ran with the defaults, but should be customized according to your requirements.

    - hosts: servers
      roles:
         - { role: uclalib_role_wowza }

After the playbook, you'll install Wowza using their provided wizard. Follow the instructions prompted in their installation guide.
    /opt/wowza/src/WowzaStreamingEngine-4.7.8-linux-x64-installer.run

After installing Wowza, run the post installation script to configure HTTPS on Wowza and the Manager service.
    /opt/wowza/src/post-wowza-install.sh

License
-------
Please see [LICENSE](LICENSE)

Author Information
------------------

GitHub [issues](https://github.com/UCLALibrary/uclalib_role_elasticsearch/issues) is open in case you'd like to file a ticket or make a suggestion. You can also contact Anthony Vuong at <a href="mailto:avuong@cachemeoutside.io">avuong@cachemeoutside.io</a> if you have a question about the project.
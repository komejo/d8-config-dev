#!/bin/sh

# Prepare the settings file for installation
if [ ! -f web/sites/default/settings.php ]
  then
    cp web/sites/default/default.settings.php web/sites/default/settings.php
    chmod 777 web/sites/default/settings.php
fi

# Prepare the services file for installation
if [ ! -f web/sites/default/services.yml ]
  then
    cp web/sites/default/default.services.yml web/sites/default/services.yml
    chmod 777 web/sites/default/services.yml
fi

# Prepare the files directory for installation
if [ ! -d web/sites/default/files ]
  then
    mkdir -m777 web/sites/default/files
fi

cd web;drush si --site-name="d8-config-dev" --db-url=mysql://root:root@localhost/d8-config-dev -y;cd ../
chmod 777 web/sites/default/s*
mkdir configs;chmod 777 configs
echo "\$config_directories['sync'] = '../configs';" >> web/sites/default/settings.php
echo "\$settings['trusted_host_patterns'] = array('d8-config-dev\.dev$',);" >> web/sites/default/settings.php
chmod 444 web/sites/default/s*
chmod -R 777 web/sites/default/files

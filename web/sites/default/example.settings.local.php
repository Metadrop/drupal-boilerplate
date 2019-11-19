<?php

$databases['default']['default'] = array (
  'database' => 'drupal',
  'username' => 'drupal',
  'password' => 'drupal',
  'prefix' => '',
  'host' => 'mariadb',
  'port' => '3306',
  'namespace' => 'Drupal\\Core\\Database\\Driver\\mysql',
  'driver' => 'mysql',
);

$config['config_split.config_split.local']['status'] = TRUE;
$config['stage_file_proxy.settings']['origin'] = 'https://metadrop.net';

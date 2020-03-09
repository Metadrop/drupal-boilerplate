<?php

$databases['default']['default'] = [
  'database' => getenv('DB_HOST'),
  'username' => getenv('DB_USER'),
  'password' => getenv('DB_PASSWORD'),
  'prefix' => '',
  'host' => getenv('DB_HOST'),
  'port' => getenv('DB_PORT'),
  'namespace' => 'Drupal\\Core\\Database\\Driver\\' . getenv('DB_DRIVER'),
  'driver' => getenv('DB_DRIVER'),
];

$config['config_split.config_split.local']['status'] = TRUE;
$config['stage_file_proxy.settings']['origin'] = 'https://example.net';

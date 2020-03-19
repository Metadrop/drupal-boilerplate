<?php

// Only setup database when env vars are available.
if (getenv('DB_NAME') != NULL) {
  $databases['default']['default'] = [
    'database' => getenv('DB_NAME'),
    'username' => getenv('DB_USER'),
    'password' => getenv('DB_PASSWORD'),
    'prefix' => '',
    'host' => getenv('DB_HOST'),
    'port' => getenv('DB_PORT'),
    'namespace' => 'Drupal\\Core\\Database\\Driver\\' . getenv('DB_DRIVER'),
    'driver' => getenv('DB_DRIVER'),
  ];
}

$config['config_split.config_split.ci']['status'] = TRUE;

<?php

/**
 * @file
 * Default configuration for local environments.
 */

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

// Config splits.
$config['config_split.config_split.local']['status'] = TRUE;
//$config['config_split.config_split.dev']['status'] = TRUE;
//$config['config_split.config_split.stg']['status'] = TRUE;
//$config['config_split.config_split.pro']['status'] = TRUE;

/** Trusted host configuration. */
$settings['trusted_host_patterns'] = [
  '^.+\.localhost$', # localhost access
  'apache$',
  'nginx$',
];



/** Skip file system permissions hardening. Not a security issue when developing locally. */
$settings['skip_permissions_hardening'] = TRUE;


/** === NO CACHE DEVELOPMENT === */
//  /** Assertions. */
//  assert_options(ASSERT_ACTIVE, TRUE);
//  \Drupal\Component\Assertion\Handle::register();
//  /** Enable local development services. */
//  $settings['container_yamls'][] = DRUPAL_ROOT . '/sites/development.services.yml';
//
//  /** Show all error messages, with backtrace information. */
//  $config['system.logging']['error_level'] = 'verbose';
//
//  /** Disable CSS and JS aggregation. */
//  $config['system.performance']['css']['preprocess'] = FALSE;
//  $config['system.performance']['js']['preprocess'] = FALSE;
//
//  /** Disable the render cache. */
//  $settings['cache']['bins']['render'] = 'cache.backend.null';
//
//  /** Disable caching for migrations. */
//  $settings['cache']['bins']['discovery_migration'] = 'cache.backend.memory';
//
//  /** Disable Internal Page Cache. */
//  $settings['cache']['bins']['page'] = 'cache.backend.null';
//
//  /** Disable Dynamic Page Cache. */
//  $settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';
//

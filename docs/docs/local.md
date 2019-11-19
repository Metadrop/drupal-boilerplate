# Steps to build the site in local

 1. Up docker services  
  `docker-compose up -d --build`

 2. Install composer dependencies  
 `docker-compose exec php composer install`

 3. Copy setting.local.ci.php to setting.local.php  
  `cp web/sites/default/example.settings.local.php web/sites/default/settings.local.php`

 4. Download database    
  `./vendor/bin/drush @alias sql-dump > tmp/db.sql`

 5. Sync database to local  
   `docker-compose exec -T php drush sql-cli < tmp/db.sql`

 6. Sanitize database  
`docker-compose exec -T php drush sql-sanitize`

 7. Clear caches  
 `docker-compose exec -T php drush cr`

 8. Import local configuration  
 `docker-compose exec -T php drush cim -y`

# Utils docker commands

## Get a bash shell in the PHP container
    docker-compose exec php bash

## Access database
 - Connect to mariadb service  
 `docker-compose exec mariadb bash`

 - Access database  
  `mysql -u root -ppassword -b drupal`

## Get uli

    ./vendor/bin/drush @metadrop.docker uli --no-browser

# Documentation

 - [MDKW - Drupal for Docker](https://docs.google.com/document/d/1oc7XKxkMrLdUS_a7rkgimKEJbWhS6LQFUPfARGwSMZQ/edit)
 - [MDKW - Docker](https://docs.google.com/document/d/1VuXXjrqfZoRogeoDE5cd8HDN12_eOiPn-bj_r_IqbSM/edit)

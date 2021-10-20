# Docker containers

Based on [wodby/docker4drupal](https://github.com/wodby/docker4drupal), with some tweaks to speed-up your development.

The stack is configured as follows:

| Container       | Versions               | Service name    | Image                              | Enabled by default |
| --------------  | ---------------------- | --------------- | ---------------------------------- | ------------------ |
| Nginx           | 1.19, 1.18             | `nginx`         | [wodby/nginx]                      | ✓                  |
| Apache          | 2.4                    | `apache`        | [wodby/apache]                     |                    |
| PHP             | 8.0, 7.4, 7.3, 7.2     | `php`           | [wodby/drupal-php]                 | ✓                  |
| MariaDB         | 10.5, 10.4, 10.3, 10.2 |` mariadb`       | [wodby/mariadb]                    | ✓                  |
| PostgreSQL      | 13, 12, 11, 10, 9.x    |` postgres`      | [wodby/postgres]                   |                    |
| Redis           | 6, 5                   |` redis`         | [wodby/redis]                      |                    |
| Memcached       | 1                      |` memcached`     | [wodby/memcached]                  |                    |
| Varnish         | 6.0, 4.1               |` varnish`       | [wodby/varnish]                    |                    |
| Node.js         | 14, 12, 10             |` node`          | [wodby/node]                       | ✓                  |
| Drupal node     | 1.0                    | `drupal-node`   | [wodby/drupal-node]                |                    |
| Solr            | 8, 7, 6, 5             | `solr`          | [wodby/solr]                       |                    |
| Elasticsearch   | 7, 6                   | `elasticsearch` | [wodby/elasticsearch]              |                    |
| Kibana          | 7, 6                   |` kibana`        | [wodby/kibana]                     |                    |
| OpenSMTPD       | 6.0                    | `opensmtpd`     | [wodby/opensmtpd]                  |                    |
| Mailhog         | latest                 | `mailhog`       | [mailhog/mailhog]                  | ✓                  |
| AthenaPDF       | 2.16.0                 | `athenapdf`     | [arachnysdocker/athenapdf-service] |                    |
| Rsyslog         | latest                 | `rsyslog`       | [wodby/rsyslog]                    |                    |
| Blackfire       | latest                 | `blackfire`     | [blackfire/blackfire]              |                    |
| Webgrind        | 1.8                    | `webgrind`      | [wodby/webgrind]                   |                    |
| Xhprof viewer   | latest                 | `xhprof`        | [wodby/xhprof]                     |                    |
| Adminer         | 4                      | `adminer`       | [wodby/adminer]                    | ✓                  |
| phpMyAdmin      | latest                 | `pma`           | [phpmyadmin/phpmyadmin]            |                    |
| Selenium chrome | 3.141                  | `chrome`        | [selenium/node-chrome]             | ✓                  |
| Selenium hub    | 3.141                  | `hub   `        | [selenium/hub]                     | ✓                  |
| Traefik         | v2.0                   | `traefik`       | [_/traefik]                        | ✓                  |
| Mkdocs          | latest                 | `mkdocs`        | [metadrop/docker-mkdocs]           | ✓                  |
| Portainer       | latest                 | `portainer`     | [portainer/portainer]              | ✓                  |
| BackstopJS      | 4.4                    | `backstopjs`    | [backstopjs/backstopjs]            | ✓                  |

There is a `docker-compose.override.yml.dist` file including some container definitions like Adminer and MkDocs.
This is done with the purpose of differencing the local environment stack from the stack of other environments.
The `docker-compose.override.yml` is git-ignored.



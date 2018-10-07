install_php:
  pkg.latest:
    - name: php

install_php_mysql:
  pkg.latest:
    - name: php-mysql

configure_php_timezone:
  file.managed:
    - source: salt://piwigo/files/date.ini
    - name: /etc/php.d/date.ini
    - user: root
    - group: root
    - mode: 644
    - watch_in:
      - service: enable_apache
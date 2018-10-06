{% from "piwigo/map.jinja" import piwigo with context %}

{% set mysql_root_user = salt['pillar.get']('piwigo:mysql:root_user', 'root') %}
{% set mysql_root_pass = salt['pillar.get']('piwigo:mysql:root_password', salt['grains.get']('server_id')) %}
{% set mysql_host = salt['pillar.get']('piwigo:mysql:host', 'localhost') %}

create_piwigo_db:
  mysql_database.present:
    - name: piwigo
    - name: {{ database }}
    - connection_host: '{{ mysql_host }}'
    - connection_user: '{{ mysql_root_user }}'
    - connection_pass: '{{ mysql_root_pass }}'

create_piwigo_dir:
  file.directory:
    - name: /var/www/html/piwigo

extract_piwigo:
  archive.extracted:
    - name: /var/www/html/piwigo
    - source: http://piwigo.org/download/dlcounter.php?code=latest
    - source_hash: sha512=b558700f041402f1fa399d1599ceaca4bb381ba818f189b5dca68a5b09d65416b5cbf2c4f48c8390381cffe98c840d4279c0b57c698ca5a81c0304ecc4a9a80c
    - archive_format: zip
    - if_missing: /var/www/html/piwigo/README.md
    - watch_in:
      - service: enable_apache
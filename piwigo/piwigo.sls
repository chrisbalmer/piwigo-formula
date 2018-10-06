create_piwigo_db:
  mysql_database.present:
    - name: piwigo

create_piwigo_dir:
  file.directory:
    - name: /var/www/html/piwigo

extract_piwigo:
  archive.extracted:
    - name: /var/www/html/piwigo
    - source: http://piwigo.org/download/dlcounter.php?code=latest
    - source_hash: sha512=b558700f041402f1fa399d1599ceaca4bb381ba818f189b5dca68a5b09d65416b5cbf2c4f48c8390381cffe98c840d4279c0b57c698ca5a81c0304ecc4a9a80c
    - if_missing: /var/www/html/piwigo/README.md
    - watch_in:
      - pkg: install_apache
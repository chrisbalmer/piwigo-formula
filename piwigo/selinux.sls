install_selinux_support:
  pkg.latest:
    - name: policycoreutils-python

configure_fcontext_data:
  cmd.run:
    - name: 'semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html/piwigo/_data(/.*)?"'
    - onchanges:
      - archive: extract_piwigo
    - require:
      - pkg: install_selinux_support

configure_fcontext_upload:
  cmd.run:
    - name: 'semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html/piwigo/upload(/.*)?"'
    - onchanges:
      - archive: extract_piwigo
    - require:
      - pkg: install_selinux_support

restorecon:
  cmd.run:
    - name: 'restorecon -R -v /var/www/html/piwigo'
    - onchanges:
      - cmd: configure_fcontext_data
      - cmd: configure_fcontext_upload
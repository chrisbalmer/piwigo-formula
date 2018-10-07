install_selinux_support:
  pkg.latest:
    - name: policycoreutils-python

configure_fcontext:
  cmd.run:
    - name: 'semanage fcontext -a -t httpd_sys_rw_content_t "/var/www/html/piwigo(/.*)?"'
    - watch:
      - archive: extract_piwigo
    - require:
      - pkg: install_selinux_support

restorecon:
  module.run:
    - file.restorecon:
      - path: /var/www/html/piwigo/_data
      - recursive: true
    - watch:
      - cmd: configure_fcontext
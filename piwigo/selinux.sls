install_selinux_support:
  pkg.latest:
    - name: policycoreutils-python

configure_fcontext:
  module.run:
    - file.set_selinux_context:
      - path: /var/www/html/piwigo/_data(/.*)?
      - type: httpd_sys_rw_content_t
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
      - module: configure_fcontext
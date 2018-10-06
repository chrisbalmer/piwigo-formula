install_apache:
  pkg.latest:
    - name: httpd

enable_apache:
  service.running:
    - name: httpd
    - enable: True
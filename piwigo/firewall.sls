open_firewall:
  firewalld.present:
    - name: public
    - ports:
      - 22/tcp
      - 80/tcp
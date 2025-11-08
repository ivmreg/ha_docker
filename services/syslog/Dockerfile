FROM grafana/promtail:3.0.0

USER root

COPY promtail.yaml /etc/promtail/promtail.yaml

EXPOSE 514/tcp 514/udp

ENTRYPOINT ["/usr/bin/promtail"]
CMD ["-config.file=/etc/promtail/promtail.yaml", "-config.expand-env=true"]

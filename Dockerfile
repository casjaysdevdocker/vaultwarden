FROM vaultwarden/server:latest as base

RUN apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/* \
  mv -f "/start.sh" "/usr/local/bin/entrypoint-vaultwarden.sh" \
  mv -f "/healthcheck" "/usr/local/bin/healthcheck.sh"

FROM base
ARG BUILD_DATE="$(date +'%Y-%m-%d %H:%M')" 

LABEL \
  org.label-schema.name="vaultwarden" \
  org.label-schema.description="vaultwarden container based on Alpine Linux" \
  org.label-schema.url="https://hub.docker.com/r/casjaysdevdocker/vaultwarden" \
  org.label-schema.vcs-url="https://github.com/casjaysdevdocker/vaultwarden" \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.version=$BUILD_DATE \
  org.label-schema.vcs-ref=$BUILD_DATE \
  org.label-schema.license="WTFPL" \
  org.label-schema.vcs-type="Git" \
  org.label-schema.schema-version="latest" \
  org.label-schema.vendor="CasjaysDev" \
  maintainer="CasjaysDev <docker-admin@casjaysdev.com>" 

VOLUME /data
EXPOSE 80
EXPOSE 3012

HEALTHCHECK CMD ["/usr/local/bin/healthcheck.sh"]

# Configures the startup!
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/local/bin/docker-entrypoint.sh"]

# The upstream image already contains atvloadly, PlumeImpactor and usbmuxd2.
FROM bitxeno/atvloadly:v0.8.1@sha256:1d0a795f01eacb9c13b8063e193567567bd909ce42b10605a5f871ba09be367e

# Home Assistant OS has no Avahi for add-ons, so this add-on brings its own D-Bus system bus and Avahi daemon;
# atvloadly talks to Avahi over D-Bus to find the Apple TV.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends dbus avahi-daemon avahi-utils iproute2 jq \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY avahi-daemon.conf /etc/avahi/avahi-daemon.conf
COPY run.sh /run.sh
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]

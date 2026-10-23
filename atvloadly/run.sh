#!/bin/sh
# Starts D-Bus and Avahi inside the add-on, then hands over to atvloadly's own start script.
set -e

PORT=5533
if [ -f /data/options.json ]; then
    PORT="$(jq -r '.port // 5533' /data/options.json)"
fi
export SERVICE_PORT="$PORT"

mkdir -p /run/dbus /var/run/avahi-daemon
rm -f /run/dbus/pid /var/run/avahi-daemon/pid
dbus-uuidgen --ensure
dbus-daemon --system --fork
echo "[atvloadly add-on] D-Bus started"

# Avahi refuses to run as root without its user; the package creates "avahi".
avahi-daemon --daemonize --no-chroot
sleep 1
if avahi-daemon --check; then echo "[atvloadly add-on] Avahi started"; else echo "[atvloadly add-on] Avahi failed to start"; fi

echo "[atvloadly add-on] web interface on port $PORT"
exec /entrypoint.sh

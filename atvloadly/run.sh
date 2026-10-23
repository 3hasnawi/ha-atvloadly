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

echo "[atvloadly add-on] network interfaces:"
ip -br addr | sed 's/^/[atvloadly add-on]   /'

# Avahi in the foreground of a background job, so its interface lines reach the add-on log.
avahi-daemon --no-chroot --no-rlimits 2>&1 | sed 's/^/[avahi] /' &
sleep 2
if avahi-daemon --check; then echo "[atvloadly add-on] Avahi started"; else echo "[atvloadly add-on] Avahi failed to start"; fi

# Diagnostics: what Apple devices Avahi sees, every 30 s (pairing needs _remotepairing._tcp from the Apple TV).
if [ "$(jq -r '.debug // true' /data/options.json 2>/dev/null)" = "true" ]; then
    (
        while true; do
            sleep 30
            found="$(timeout 8 avahi-browse -apt 2>/dev/null | grep -Ei 'remotepairing|apple-mobdev|airplay|companion|raop' | cut -d';' -f2-5 | sort -u | head -20)"
            total="$(timeout 8 avahi-browse -apt 2>/dev/null | wc -l)"
            echo "[atvloadly add-on] mDNS: $total services seen; Apple ones:"
            [ -n "$found" ] && echo "$found" | sed 's/^/[atvloadly add-on]   /' || echo "[atvloadly add-on]   (none)"
        done
    ) &
fi

echo "[atvloadly add-on] web interface on port $PORT"
exec /entrypoint.sh

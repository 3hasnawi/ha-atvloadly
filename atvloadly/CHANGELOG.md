## 0.1.3
- Update the bundled atvloadly to v0.8.1 (released 2026-10-27).
- Pin the upstream multi-architecture image by tag and digest, so updates no longer depend on a cached `latest` image.
- Preserve the add-on slug, port, options and persistent `/data` (accounts, pairing and app refresh records).
- After updating tvOS, pair the Apple TV again and refresh the installed app's signature. Upstream does not specifically confirm tvOS 27.2 compatibility.

## 0.1.2
- Fix: an empty `allow-interfaces=` line made Avahi allow no interface at all, so it saw nothing on the network.
- Avahi's own log reaches the add-on log (it was held in a buffer); avahi-browse errors and the first services seen are shown.

## 0.1.1
- Logs the network interfaces, Avahi's own messages and the Apple devices it sees every 30 s (option `debug`).

## 0.1.0
- First version: atvloadly with its own D-Bus and Avahi for Home Assistant OS.

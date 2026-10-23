## 0.1.2
- Fix: an empty `allow-interfaces=` line made Avahi allow no interface at all, so it saw nothing on the network.
- Avahi's own log reaches the add-on log (it was held in a buffer); avahi-browse errors and the first services seen are shown.

## 0.1.1
- Logs the network interfaces, Avahi's own messages and the Apple devices it sees every 30 s (option `debug`).

## 0.1.0
- First version: atvloadly with its own D-Bus and Avahi for Home Assistant OS.

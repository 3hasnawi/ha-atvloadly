# atvloadly

This add-on runs [atvloadly](https://github.com/bitxeno/atvloadly) inside Home Assistant OS, to sideload apps (an
`.ipa` built for tvOS) on an Apple TV and refresh them automatically.

## Setup

1. Install and start the add-on, then open the web interface (port 5533).
2. On the Apple TV: **Settings › Remotes and Devices › Remote App and Devices** to enter pairing mode.
3. Pair the Apple TV from the web interface and enter the code shown on the TV.
4. Add an Apple ID (a dedicated one is recommended). The Apple ID must also be signed in on an iPhone to approve
   the login.
5. Install the `.ipa`. With a free Apple ID an app is valid for 7 days and atvloadly refreshes it on its own while
   the add-on runs; up to 3 apps per free Apple ID.

## Notes

- After a tvOS update the Apple TV has to be paired again; brand-new tvOS versions may not be supported at once.
- The add-on uses the host network and its own Avahi (browse only) to find the Apple TV.
- Data (pairing, accounts, apps) is kept in the add-on's `/data` and survives restarts and updates.
- atvloadly is licensed under the GNU AGPL v3; this add-on only packages the upstream image.

## Update to add-on 0.1.3

This add-on packages **atvloadly v0.8.1**. The Home Assistant add-on version (`0.1.3`) and the upstream tool version (`0.8.1`) are separate.

1. Back up the add-on's data in Home Assistant before updating.
2. Open **Settings → Add-ons → Add-on Store → ⋮ → Check for updates**, then return to this add-on and choose **Update**. The Supervisor builds the pinned upstream image locally; wait for that to complete.
3. Start the add-on and open its web interface. Existing `/data` is retained; no uninstall is needed.
4. Following a tvOS system update, open **Settings → Remotes and Devices → Remote App and Devices** on the Apple TV and pair it again, then refresh the app's signature from atvloadly.

This release does not establish compatibility with tvOS 27.2 or fix an incompatible Cinema app binary. If the app still exits after a successful signature refresh, collect the installation error and the app's crash details separately.

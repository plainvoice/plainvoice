# Install

PlainVoice needs macOS 14 (Sonoma) or later on a Mac with Apple silicon (M1 or newer). There is no
Intel build. Windows is planned for a later 1.x release.

## 1. Download and check the file

From the [latest release](https://github.com/plainvoice/plainvoice/releases/latest), download
both `PlainVoice_<version>_aarch64.dmg` and `SHA256SUMS` into the same folder, then check the DMG
in Terminal:

```sh
cd ~/Downloads
shasum -a 256 -c SHA256SUMS
```

It should print `PlainVoice_<version>_aarch64.dmg: OK`. Anything else means the file is not the one
we published: delete it and download it again.

## 2. Install

Open the DMG and drag **PlainVoice** to **Applications**.

## 3. The first open

Version 1.0 is **not notarised by Apple yet**. The app is signed ad hoc, not with an Apple
Developer ID, so macOS cannot check it with Apple and warns you the first time. The checksum in
step 1 is how you know the DMG is the one published here. Notarisation will come in a later
release.

1. Open PlainVoice from Applications. macOS shows a message that starts with
   "Apple could not verify…" (on macOS 14: "…cannot be opened because Apple cannot check it for
   malicious software"). Click **Done** or **OK**. Do not move it to the Bin.
2. Open **System Settings → Privacy & Security**. Scroll down to the message about PlainVoice and
   click **Open Anyway**. Confirm with your password or Touch ID.
3. Open PlainVoice again and click **Open**.

On macOS 14 you can also Control-click PlainVoice in Applications, choose **Open**, then click
**Open** in the dialog. macOS 15 no longer offers this, so use System Settings there.

You do this once per download. Later opens start normally; a new version you download asks once
again.

### If that does not work

If there is no **Open Anyway** button, or macOS says the app "is damaged", remove the quarantine
flag macOS put on the download, then open the app again:

```sh
xattr -dr com.apple.quarantine /Applications/PlainVoice.app
```

## 4. Download a voice model

PlainVoice ships without voices. The first time, open **Models** and install **ONNX Runtime**
(the engine every model runs on) and at least one voice model, such as **Kokoro 82M English**.
These downloads are the only time PlainVoice uses the network for voicing, and every file is
checked against its published SHA-256 before it is used. Then follow
[Your first job](first-job.md).

## The command line

The app includes the `plainvoice` command, which agents and scripts use. It is inside the app at
`/Applications/PlainVoice.app/Contents/MacOS/plainvoice`. To run it as `plainvoice`, link it into a
folder on your `PATH`:

```sh
sudo mkdir -p /usr/local/bin
sudo ln -sf /Applications/PlainVoice.app/Contents/MacOS/plainvoice /usr/local/bin/plainvoice
plainvoice version
```

If macOS blocks the command the first time, run the `xattr` line above. The command and the app
share one engine, so a job started from either shows in the app's Queue.

## Uninstall

Quit PlainVoice and drag it from Applications to the Bin. To remove its data too (models, the
licence, settings), delete `~/Library/Application Support/PlainVoice`. Your projects stay in
`~/Documents/PlainVoice` (or the workspace you chose) until you delete them. If you made the link
above, remove it with `sudo rm /usr/local/bin/plainvoice`.

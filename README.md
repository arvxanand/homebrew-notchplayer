# homebrew-notchplayer

The Homebrew tap for [NotchPlayer](https://github.com/arvxanand/NotchPlayer):
Spotify now-playing in the MacBook notch, with the album cover and a live
waveform beside the camera, and play/pause/skip when you hover it.

Needs a MacBook with a notch (Apple Silicon), macOS 15 or later, and the
Spotify desktop app, signed in.

```bash
brew install --cask arvxanand/notchplayer/notchplayer
```

Then open NotchPlayer from Applications and click **Allow** when it asks for
Automation (to read and control Spotify) and Audio Recording (for the
waveform). Turn on **Launch at Login** from its menu bar item → the gear.

NotchPlayer isn't notarised (there's no paid Apple Developer account behind
it), so the cask removes macOS's quarantine flag after installing. That's
why it opens without the "could not verify" warning a browser download gets.

```bash
brew upgrade --cask notchplayer          # update; macOS asks for the permissions again
brew uninstall --cask notchplayer        # remove (turn off Launch at Login first)
brew uninstall --zap --cask notchplayer  # also remove its settings, caches and log
```

Something not working? The NotchPlayer
[README](https://github.com/arvxanand/NotchPlayer#if-you-clicked-dont-allow-or-nothing-shows-up)
covers refused permissions.

## Maintainer: a new release

After publishing `vX.Y` on NotchPlayer's Releases page, set `version` and
`sha256` in `Casks/notchplayer.rb`. The sha256 is in the release workflow's
job summary, or:

```bash
curl -sL https://github.com/arvxanand/NotchPlayer/releases/download/vX.Y/NotchPlayer.dmg | shasum -a 256
```

Check with `brew style --cask Casks/notchplayer.rb`, then push.

cask "notchplayer" do
  version "0.4"
  sha256 "dd61da0a0b4a46b72ef9743d55c8f0148e2fd7fddbb83529196e9268e3e90a6a"

  url "https://github.com/arvxanand/NotchPlayer/releases/download/v#{version}/NotchPlayer.dmg"
  name "NotchPlayer"
  desc "Spotify now-playing in the MacBook notch"
  homepage "https://github.com/arvxanand/NotchPlayer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :sequoia

  app "NotchPlayer.app"

  # Not notarised (no paid Apple account), so Gatekeeper would block the first
  # launch. Homebrew 7 dropped --no-quarantine; this is how taps skip it now.
  postflight_steps do
    if_path_exists "{{appdir}}/NotchPlayer.app" do
      run "/usr/bin/xattr",
          args: ["-dr", "com.apple.quarantine", "{{appdir}}/NotchPlayer.app"]
    end
  end

  uninstall quit: "io.github.arvxanand.notchplayer"

  zap trash: [
    "~/Library/Caches/io.github.arvxanand.notchplayer",
    "~/Library/Caches/NotchPlayer",
    "~/Library/HTTPStorages/io.github.arvxanand.notchplayer",
    "~/Library/Logs/NotchPlayer.log",
    "~/Library/Preferences/io.github.arvxanand.notchplayer.plist",
  ]
end

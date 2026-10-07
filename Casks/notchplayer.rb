cask "notchplayer" do
  version "0.5"
  sha256 "16fa8884470ef10471564dda0d18661f3284538799e524876633260ff31a2fde"

  url "https://github.com/arvxanand/NotchPlayer/releases/download/v#{version}/NotchPlayer.dmg"
  name "NotchPlayer"
  desc "Spotify and Apple Music now-playing in the MacBook notch"
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

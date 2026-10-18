cask "notchplayer" do
  version "0.8"
  sha256 "acb93ba0647e5ff9127ae471285d94542a620e305f9501f8670adfe2e19e7911"

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

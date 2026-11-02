cask "verse" do
  version "0.4.0"
  sha256 "d1d4421dc1123645c3baa510b0b1d114ec38698c7d21222bd859e73b854c9010"

  url "https://github.com/enrych/verse/releases/download/v#{version}/Verse.dmg"
  name "Verse"
  desc "Song lyrics on your lock screen, synced word by word"
  homepage "https://verse-6gy.pages.dev/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Verse.app"

  # Verse isn't notarised yet; clear the quarantine flag so it opens without
  # the right-click → Open step.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Verse.app"]
  end

  uninstall quit: "com.enrych.verse"

  zap trash: [
    "~/Library/Caches/com.enrych.verse",
    "~/Library/Preferences/com.enrych.verse.plist",
  ]
end

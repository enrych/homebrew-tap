cask "verse" do
  version "0.3.0"
  sha256 "d2057de96328b63760a66ac5646e6725f266337131d65d778a2217561e3645ee"

  url "https://github.com/enrych/verse/releases/download/v#{version}/Verse.dmg"
  name "Verse"
  desc "Song lyrics on your Mac's lock screen, synced word by word"
  homepage "https://verse-6gy.pages.dev"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "Verse.app"

  # Verse isn't notarised yet; clear the quarantine flag so it opens without
  # the right-click → Open step.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Verse.app"],
                   sudo: false
  end

  uninstall quit: "com.enrych.verse"

  zap trash: [
    "~/Library/Caches/com.enrych.verse",
    "~/Library/Preferences/com.enrych.verse.plist",
  ]
end

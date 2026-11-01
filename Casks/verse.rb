cask "verse" do
  version "0.3.1"
  sha256 "df9621834edb717e3fbe5bd8598909a2919eac70aa176e4e333a2925fd8a776c"

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

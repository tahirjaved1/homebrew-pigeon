cask "pigeon" do
  version "0.8.0"
  sha256 "f5e98b8cddf2d11afe43503770bacf005695699970ca0625207393c152196af8"

  url "https://github.com/tahirjaved1/pigeon/releases/download/v#{version}/Pigeon-#{version}.dmg"
  name "Pigeon"
  desc "Fast, private email client for Gmail"
  homepage "https://tahirjaved1.github.io/pigeon/"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on macos: ">= :ventura"

  app "Pigeon.app"

  # Pigeon isn't notarized by Apple yet. Without this, macOS blocks the first launch
  # ("can't verify the developer") until you click Open Anyway in System Settings.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Pigeon.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.tahirjaved.pigeon",
    "~/Library/Caches/com.tahirjaved.pigeon",
    "~/Library/Logs/Pigeon-crash.log",
    "~/Library/Preferences/com.tahirjaved.pigeon.plist",
    "~/Library/WebKit/com.tahirjaved.pigeon",
  ]
end

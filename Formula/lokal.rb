# Generated from packaging/homebrew/lokal.rb.in in https://github.com/mehmetkose/lokal
# by scripts/homebrew-formula.sh when a release is published. Edit the template there.
class Lokal < Formula
  desc "Real .lokal and .local domains with valid HTTPS for local development"
  homepage "https://github.com/mehmetkose/lokal"
  license "Apache-2.0"

  depends_on macos: :sonoma

  on_arm do
    url "https://github.com/mehmetkose/lokal/releases/download/v0.1.0/lokal-0.1.0-aarch64-apple-darwin.tar.gz"
    sha256 "0bf93d3ab87f75216919fab07fbdd21bb1378dbd98a9d1c659c826da354fade3"
  end
  on_intel do
    url "https://github.com/mehmetkose/lokal/releases/download/v0.1.0/lokal-0.1.0-x86_64-apple-darwin.tar.gz"
    sha256 "390ebe9cd2954a71e807a692e08d0f1648d4ad6e27d0f452b51a9342a671d11a"
  end

  def install
    bin.install "lokal"
  end

  def caveats
    <<~EOS
      To finish installing lokal, run this once (it asks for your password):
        lokal setup

      After each upgrade, switch the background service to the new version:
        lokal upgrade

      Before uninstalling, remove lokal's background service, certificate and resolver:
        lokal uninstall          # add --purge to also delete projects and the CA
    EOS
  end

  test do
    assert_match "lokal #{version} (", shell_output("#{bin}/lokal --version")
  end
end

# Generated from packaging/homebrew/lokal.rb.in in https://github.com/mehmetkose/lokal
# by scripts/homebrew-formula.sh when a release is published. Edit the template there.
class Lokal < Formula
  desc "Real .lokal and .local domains with valid HTTPS for local development"
  homepage "https://github.com/mehmetkose/lokal"
  license "Apache-2.0"

  depends_on macos: :sonoma

  # One prebuilt tarball per architecture. `brew audit --strict` doesn't allow
  # url/sha256 inside on_arm/on_intel blocks, so this is a plain conditional.
  if Hardware::CPU.arm?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.3.0/lokal-0.3.0-aarch64-apple-darwin.tar.gz"
    sha256 "3a2875996a2b729ce746ad89be2da67a3923f983634cdad6811ec6f202f20336"
  else
    url "https://github.com/mehmetkose/lokal/releases/download/v0.3.0/lokal-0.3.0-x86_64-apple-darwin.tar.gz"
    sha256 "9cd0b2e1eef7f06b2b679ceb70a248df45d6e27566dca8e4aa8c2404ba303ecb"
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

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
    url "https://github.com/mehmetkose/lokal/releases/download/v0.2.0/lokal-0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "5c1258142495a05a877e6f477eedfbb4250f89dc2a2d44bee3aab4e15f85c293"
  else
    url "https://github.com/mehmetkose/lokal/releases/download/v0.2.0/lokal-0.2.0-x86_64-apple-darwin.tar.gz"
    sha256 "85d8cd88973717a1b68a40287149ea4e3100942933eb445902c0c4bfcdf08ea7"
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

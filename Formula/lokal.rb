# Generated from packaging/homebrew/lokal.rb.in in https://github.com/mehmetkose/lokal
# by scripts/homebrew-formula.sh when a release is published. Edit the template there.
class Lokal < Formula
  desc "Real .lokal and .local domains with valid HTTPS for local development"
  homepage "https://github.com/mehmetkose/lokal"
  license "Apache-2.0"

  # One prebuilt tarball per OS and architecture. `brew audit --strict` doesn't
  # allow url/sha256 inside on_macos/on_linux/on_arm/on_intel blocks
  # (FormulaAudit/ComponentsOrder), and Homebrew leaves class-level OS conditionals
  # to taps (FormulaAudit/OnSystemConditionals), so this is a plain conditional.
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.5.2/lokal-0.5.2-aarch64-apple-darwin.tar.gz"
    sha256 "94b011d2316861e13def34f611edc3dd777fd3562dc3f6545d7990f0e1c9fc67"
  elsif OS.mac?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.5.2/lokal-0.5.2-x86_64-apple-darwin.tar.gz"
    sha256 "4b7d4018f4419f824cc9c9007f81f9ae3e53936fcd854818771b2483e907a81c"
  elsif Hardware::CPU.arm?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.5.2/lokal-0.5.2-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "690a9c81212dd090a93588be23e963928028d3cd800bcd2e657c6171c422ac7e"
  else
    url "https://github.com/mehmetkose/lokal/releases/download/v0.5.2/lokal-0.5.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "d83582f7dfbb949d758094de4e5e2c952ae074d2dfe46328221d409070a671c6"
  end

  on_macos do
    depends_on macos: :sonoma
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

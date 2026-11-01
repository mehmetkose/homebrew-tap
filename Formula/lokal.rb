# Generated from packaging/homebrew/lokal.rb.in in https://github.com/mehmetkose/lokal
# by scripts/homebrew-formula.sh when a release is published. Edit the template there.
class Lokal < Formula
  desc "Real .lokal domains with valid HTTPS for local development"
  homepage "https://github.com/mehmetkose/lokal"
  license "Apache-2.0"

  # One prebuilt tarball per OS and architecture. `brew audit --strict` doesn't
  # allow url/sha256 inside on_macos/on_linux/on_arm/on_intel blocks
  # (FormulaAudit/ComponentsOrder), and Homebrew leaves class-level OS conditionals
  # to taps (FormulaAudit/OnSystemConditionals), so this is a plain conditional.
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.6.0/lokal-0.6.0-aarch64-apple-darwin.tar.gz"
    sha256 "7729bd60efb124e5751d206f5410536734fa5dc01725519bd9c1bf807514c839"
  elsif OS.mac?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.6.0/lokal-0.6.0-x86_64-apple-darwin.tar.gz"
    sha256 "2b65a3319ed252b8025e104de9ba2dc2a5a82eb2aa68751ce839ab696d9facd0"
  elsif Hardware::CPU.arm?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.6.0/lokal-0.6.0-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "4c6b94cbb1003ab667b474211bee9927bb2ac27095e8ea3faa19cf0d25fded15"
  else
    url "https://github.com/mehmetkose/lokal/releases/download/v0.6.0/lokal-0.6.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "03911242011798224a0d30a372e0dffb051c18be7148ba212b6842dbf75865da"
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

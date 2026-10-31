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
    url "https://github.com/mehmetkose/lokal/releases/download/v0.5.1/lokal-0.5.1-aarch64-apple-darwin.tar.gz"
    sha256 "29dc23b232c85e04e3a002018f14b749a985219e68ba979b88a12187b5564ba3"
  elsif OS.mac?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.5.1/lokal-0.5.1-x86_64-apple-darwin.tar.gz"
    sha256 "019ce0c882ff85d4aad89e3eb68621f69a4c067d3701d1460fd18fbc1ce51dcb"
  elsif Hardware::CPU.arm?
    url "https://github.com/mehmetkose/lokal/releases/download/v0.5.1/lokal-0.5.1-aarch64-unknown-linux-gnu.tar.gz"
    sha256 "cc84c6eeee55b561cdaafb61d348726b6e7f6886f1db570504b5386a1a6e1a7f"
  else
    url "https://github.com/mehmetkose/lokal/releases/download/v0.5.1/lokal-0.5.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "3f827f946845f7cd0ada90b43cbfe5972aa86e5b6256ae01de354a435d2fed89"
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

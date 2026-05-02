class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v2.0.0-aarch64-apple-darwin.tar.gz"
    checksum = "c2cd8e40f09519d20e2036b2a0ad494cb38c551007f577f27c9cb82e8ee0d14d"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v2.0.0-x86_64-apple-darwin.tar.gz"
    checksum = "0bdf040d768f7aa2055c70b27ecf974f979ff4af16a1d9d4bfec38f6ca04b3ec"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v2.0.0-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "ebd2f7e05a2a4895766614a309e06ea48d300bc16a52d9a1074923a8b673ea4c"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbotik-cli-v2.0.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "0e9fb34732287ffed831f3e5142ce98a538267279d30d0a6d6b82511ce7db7d0"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v2.0.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

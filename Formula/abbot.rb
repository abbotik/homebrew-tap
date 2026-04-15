class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.2.0-aarch64-apple-darwin.tar.gz"
    checksum = "1eda1609abe3f6c9c61b31a40a1e95264350e5b4761eeac3eb733a9dee8a2546"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.2.0-x86_64-apple-darwin.tar.gz"
    checksum = "4c9924a2e753c24b10aabb15310308be59f80d882f87dfed5bb028948badc271"
  elsif host_os.include?("linux")
    archive = "abbotik-cli-v1.2.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "47c93484c12d3dfc497508bdeb7e53c5212cc326d68103c852b7857dfa42b9f1"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.2.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

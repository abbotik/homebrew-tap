class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.5.0-aarch64-apple-darwin.tar.gz"
    checksum = "bc01c74a3a55dae20eb3ad9e93a565afa8c4957b10e24a336d56f2bb2fcf3d69"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.5.0-x86_64-apple-darwin.tar.gz"
    checksum = "db821081ce19303339fb1393925491e0c64e09633cf9f728bdf6dac79e256035"
  elsif host_os.include?("linux")
    archive = "abbotik-cli-v1.5.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "65d01e93cd8c99a02c241fce8088891641493ebc9559dff6da7ac4e7c6fbb9ae"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.5.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

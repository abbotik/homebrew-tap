class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.6.0-aarch64-apple-darwin.tar.gz"
    checksum = "8a386a327c8a21782babf8f4e54ba2d63cd9b22d5bfc05ace261ac7de1754932"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.6.0-x86_64-apple-darwin.tar.gz"
    checksum = "3c844e450481e76118f57ff5270eab85cbdd86b30e08cbd14f5bc1ad82d94be7"
  elsif host_os.include?("linux")
    archive = "abbotik-cli-v1.6.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "69071e9344c2fb4dc4ac70b3b90553effc88d13fa9830d07f0e70976a6f1a079"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.6.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

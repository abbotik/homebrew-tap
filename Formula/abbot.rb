class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.0.0-aarch64-apple-darwin.tar.gz"
    checksum = "d8cce349e4af49a1bcc1042664d05f8f8f71b98a63d53f857e7397cd2fdd2262"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.0.0-x86_64-apple-darwin.tar.gz"
    checksum = "179b7ae5e04573d5bec4a9cbcd4e690422cd644912a9714505fd21602b1571ba"
  elsif host_os.include?("linux")
    archive = "abbotik-cli-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "e43c4a9f4a1deecaf2d66760640ebcf374ffb44dc8cb48887a9ceba4da9010a8"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.0.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

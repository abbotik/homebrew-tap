class AbbotApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbot-api-v9.1.0-aarch64-apple-darwin.tar.gz"
    checksum = "446a98ae4b6fe616ff1dd2bcb8d53b2f428336540eaa2f1dc5d7a7e50b2cd494"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbot-api-v9.1.0-x86_64-apple-darwin.tar.gz"
    checksum = "ee19d2d16e4b5b107609f5ed358e081005f22183f9a5d0457736d1d03dd7a108"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbot-api-v9.1.0-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "0021c102518414b4840befec477c52d4ce256933ed2ac4187588974e9a85b53a"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbot-api-v9.1.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "b974800ae1c3c65193da824d0ad75f82e7f54cd5390f825f69174a3a5760f707"
  else
    raise "Unsupported platform for abbot-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-api-v9.1.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot-api"
  end

  test do
    ENV["ABBOTIK_AUTH_JWT_SECRET"] = "homebrew-test-secret"
    assert_match "Abbotik API operator commands", shell_output("#{bin}/abbot-api help")
    assert_match "Startup test successful", shell_output("#{bin}/abbot-api run --no-startup 2>&1")
  end
end

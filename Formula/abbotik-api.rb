class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v8.3.0-aarch64-apple-darwin.tar.gz"
    checksum = "faf348d0dba6e2f63c11a73489f2e2656cf2c2c7a24e8ae60c17f0cc409a58f6"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v8.3.0-x86_64-apple-darwin.tar.gz"
    checksum = "cabaacb33a4371571e3443e7f8cac5e79f6d641d36b5e899d3461d950e4fdb42"
  elsif host_os.include?("linux")
    archive = "abbotik-api-v8.3.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "81a5fa292accfaf633dcd8b50aac16f45fd5af4d00841bd138a96517978cf9ba"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v8.3.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbotik-api"
  end

  test do
    ENV["JWT_SECRET"] = "homebrew-test-secret"
    assert_match "Abbotik API operator commands", shell_output("#{bin}/abbotik-api help")
    assert_match "Startup test successful", shell_output("#{bin}/abbotik-api run --no-startup 2>&1")
  end
end

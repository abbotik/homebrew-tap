class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v7.2.0-aarch64-apple-darwin.tar.gz"
    checksum = "dfc569deb8141bb39caa3fab26a7fdc0f940d765f9fd9b78e29e435c12ccdb14"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v7.2.0-x86_64-apple-darwin.tar.gz"
    checksum = "1487aed010b9f437cdbd2a216073e2d13f58c257be8e709cc20b9b642d278af9"
  elsif host_os.include?("linux")
    archive = "abbotik-api-v7.2.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "62bdbea2513c0e2966c6393820095d6c653fd552c937398da842b7e900d09a3f"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v7.2.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbotik-api"
  end

  test do
    ENV["JWT_SECRET"] = "homebrew-test-secret"
    assert_match "Startup test successful", shell_output("#{bin}/abbotik-api --no-startup 2>&1")
  end
end

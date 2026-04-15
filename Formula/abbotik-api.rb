class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v7.1.0-aarch64-apple-darwin.tar.gz"
    checksum = "6463b2293c5190dc006b3155784e6fa5a17e827a0821de9ea9e7a37a53523825"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v7.1.0-x86_64-apple-darwin.tar.gz"
    checksum = "87ff346703fc514fccf7688b03ab1080a4e5c684ffc568682faf7a362eb4fb42"
  elsif host_os.include?("linux")
    archive = "abbotik-api-v7.1.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "d0d1dcc25fcf3cab4bd49102c494dfe627349e1eb45c2e8244d541cb12be011e"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v7.1.0/#{archive}"
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

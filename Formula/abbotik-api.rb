class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v8.3.2-aarch64-apple-darwin.tar.gz"
    checksum = "2b80c72ab7f01c132d642d417882bfc2af6b257d5435c40397e25c8484fdc80b"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v8.3.2-x86_64-apple-darwin.tar.gz"
    checksum = "9a5f39cdde0897962137b1628155e3ca68b5a42a1bee78e80d7576042668649b"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v8.3.2-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "4a1e2f41b5d23e47ed3d5e7913b0c2d96fc1a58b10bb3bee95188f0976b1ff7a"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbotik-api-v8.3.2-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "5b09876ace7072a4c921a2f201ff40c2d73ad576d41d06ca5518b6f5ac61da09"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v8.3.2/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbotik-api"
  end

  test do
    ENV["ABBOTIK_AUTH_JWT_SECRET"] = "homebrew-test-secret"
    assert_match "Abbotik API operator commands", shell_output("#{bin}/abbotik-api help")
    assert_match "Startup test successful", shell_output("#{bin}/abbotik-api run --no-startup 2>&1")
  end
end

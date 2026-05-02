class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v9.0.0-aarch64-apple-darwin.tar.gz"
    checksum = "3f38438cab27e2b4d445edc7151ed347a10ea0dbbc2a649bf7707fda60d74702"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v9.0.0-x86_64-apple-darwin.tar.gz"
    checksum = "f78d4906fdccb9b7f2ee7cdf9bc70347c942fa976c43bcac11e139a93462747b"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v9.0.0-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "95344e73a7b7b74d44f831a2309efcbb5f728532a32a43eef24d34822c438fa9"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbotik-api-v9.0.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "c813b97645942740378eb39233e371a251b4b012c55255415a3c383625ee76af"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v9.0.0/#{archive}"
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

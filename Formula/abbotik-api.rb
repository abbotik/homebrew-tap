class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v8.1.1-aarch64-apple-darwin.tar.gz"
    checksum = "ddd517308c0fe170818e06a4bbff3d0dcc18f8e35933201586883ad5eef59184"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v8.1.1-x86_64-apple-darwin.tar.gz"
    checksum = "3b0c4f987d42a806b6a5f96dac0971ebb0102b1478f56c5e41c12b4be0c04c0c"
  elsif host_os.include?("linux")
    archive = "abbotik-api-v8.1.1-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "38d96b85a3cb4e5e995ac8dce90f6ffbeb0aaf7161e25d5c3e9035e7de881a41"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v8.1.1/#{archive}"
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

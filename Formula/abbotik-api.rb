class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v7.3.0-aarch64-apple-darwin.tar.gz"
    checksum = "23966e4e38a5cf3a2bc2d701343038ebd6849f41e3c075bd4c9b45f8d0e8f4da"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v7.3.0-x86_64-apple-darwin.tar.gz"
    checksum = "431a54241f9bbd4e0137617f78ec6a936c299d1eb230a500ad4c404c7ce2e6a5"
  elsif host_os.include?("linux")
    archive = "abbotik-api-v7.3.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "d8ab360accd595e8c28e9c549495fb655789c231975a502622a9c6306a252c46"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v7.3.0/#{archive}"
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

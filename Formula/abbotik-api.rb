class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v8.3.1-aarch64-apple-darwin.tar.gz"
    checksum = "86fb16bdd4ff9b46fa6d2f4c2b3145b97273db3aab0709d897957e089c240706"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v8.3.1-x86_64-apple-darwin.tar.gz"
    checksum = "86fb16bdd4ff9b46fa6d2f4c2b3145b97273db3aab0709d897957e089c240706"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v8.3.1-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "ab7bfcdc9d73daed1d8b0ef307a3c4a6b1c12edea5ed38eb13ef41b6f977ba7d"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbotik-api-v8.3.1-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "91f7d2393f7b5bd33cd0a989516f4b581e76d4d93f76cc5d0822ff025a3ed17a"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v8.3.1/#{archive}"
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

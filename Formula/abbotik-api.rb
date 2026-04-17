class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v8.2.0-aarch64-apple-darwin.tar.gz"
    checksum = "1d87419ee4d53e7e662e32b3aacb43f537bac928a16fcfcdbd4c6bcc6a9031e5"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v8.2.0-x86_64-apple-darwin.tar.gz"
    checksum = "0c21659e49a4bd35fc82675c2ed0b8095d37316ec0bf84e3793b1d5c83daf2ee"
  elsif host_os.include?("linux")
    archive = "abbotik-api-v8.2.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "9a28ceab816d1fc2b16de48bb9aa01d387916845d677b0ceaae00d67488d9dd4"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v8.2.0/#{archive}"
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

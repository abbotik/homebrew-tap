class AbbotApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbot-api-v9.2.0-aarch64-apple-darwin.tar.gz"
    checksum = "1ba2f7954c456da4270124e83b4c9720f26618cfec9b2d7fb2f3936bab9b1a5d"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbot-api-v9.2.0-x86_64-apple-darwin.tar.gz"
    checksum = "02e67bde1a6c29dd6d4facaa03bc9a76ac0aa6ebe00dc53abb07f5dc16f2ba5e"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbot-api-v9.2.0-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "db4649d79740869b9ae1f27f5c7e96bf5ad22330f94e1df0b01972347f1aefd0"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbot-api-v9.2.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "e2f8a8bc3ab2866fd60eda6bea60b9bfdbfa38c2ce56f5fecbbbbae14146f441"
  else
    raise "Unsupported platform for abbot-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-api-v9.2.0/#{archive}"
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

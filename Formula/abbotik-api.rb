class AbbotikApi < Formula
  require "rbconfig"

  desc "Standalone Abbotik API server"
  homepage "https://api.abbotik.com"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-api-v8.1.0-aarch64-apple-darwin.tar.gz"
    checksum = "0a26203957e63761521c39752840ec39662f4c3e7586f6c570f104d1fcf8c655"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-api-v8.1.0-x86_64-apple-darwin.tar.gz"
    checksum = "42e8c1c5ba66b04f1d7857c462e024cecfc55079bd94bfcd31e4ea0352e84d2b"
  elsif host_os.include?("linux")
    archive = "abbotik-api-v8.1.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "a025986ce5ae50315a243274dc78fa0d683f5500fb466fc91f237a43a36f50ec"
  else
    raise "Unsupported platform for abbotik-api: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbotik-api-v8.1.0/#{archive}"
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

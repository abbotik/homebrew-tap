class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.9.0-aarch64-apple-darwin.tar.gz"
    checksum = "43e1414ccd84a82d83fbb3bee0aad2b455a6f5bdbc91041d3a3675d6bab78a2b"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.9.0-x86_64-apple-darwin.tar.gz"
    checksum = "50380431ad9e934cb6d7d56cb1edf6fa68d1204e38089fa478e2303928c73267"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.9.0-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "d17ce6cf18e1189e0852aa45c1c6d550d96c967d032b1b022dc1bf3bc72ded18"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.9.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "a1a8870945e78bf08cf36813bfd7345fddce02e3eea70889a094d7ac16b5802b"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.9.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.4.0-aarch64-apple-darwin.tar.gz"
    checksum = "285b663ab5638771d50a854406048ad342d326a4f5c5394dfb734dcd2c57cf98"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.4.0-x86_64-apple-darwin.tar.gz"
    checksum = "c329aad4b12d0f2d1ea210eed5e313c561c25cedf3d22f0eea5a582082820227"
  elsif host_os.include?("linux")
    archive = "abbotik-cli-v1.4.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "a5671eacdb4d02a02aed61ff1ba59827e13fb8f833c27c0b7fcca15107884b8f"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.4.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

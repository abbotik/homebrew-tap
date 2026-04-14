class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.1.0-aarch64-apple-darwin.tar.gz"
    checksum = "725046915919448f9220ad497979c2e3f89eacdc96623958667eb7b6336853e2"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.1.0-x86_64-apple-darwin.tar.gz"
    checksum = "10a0cabfe838a3d90eddbd078a7187e16e6e7f486f61a86b69ca4989a9a05e92"
  elsif host_os.include?("linux")
    archive = "abbotik-cli-v1.1.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "1e761beef269f9934db3daec9005fd00d5f3c1c9595e8b1e31b319ec501819f4"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.1.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

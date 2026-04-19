class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.8.0-aarch64-apple-darwin.tar.gz"
    checksum = "ee91c267dcfd9ca5c0afd06292ffabd012964fe5e4bc94798b348e15144c8a08"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.8.0-x86_64-apple-darwin.tar.gz"
    checksum = "f3327eb0232d7cf060f850799bdd410ffd19896ffd7701fc5e3ee3b39e80c833"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.8.0-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "49caa89b5cd554823560d140b36b2aee19d10d8683cc7ecd782c1fafe3977ff1"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.8.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "7516437ec9e8db8b4134385ddeb3f1995f809be88ac204fd847989b91a7a7bee"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.8.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

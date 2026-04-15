class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.3.0-aarch64-apple-darwin.tar.gz"
    checksum = "516d4e6694cfa23ec73c34af6ff94c13dd247eadc638eb6351702220eed5f607"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.3.0-x86_64-apple-darwin.tar.gz"
    checksum = "359d9e71514f64fd5effa827dcdff0d6c96f076450ff83072cc789ed88054c07"
  elsif host_os.include?("linux")
    archive = "abbotik-cli-v1.3.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "3ca871dba40a569520dc86acad03837e9bcd155ee02782403d6128327031577f"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.3.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

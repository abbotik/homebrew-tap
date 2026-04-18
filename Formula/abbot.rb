class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.7.0-aarch64-apple-darwin.tar.gz"
    checksum = "d6695a56f269f410d4f2343124ef7a7cf904f5db3137461b1df5241ea8e8cd09"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.7.0-x86_64-apple-darwin.tar.gz"
    checksum = "219f83726bd04e8c0561fcb65e051c962b0316db637ce5e5c958a3d3fbe288fc"
  elsif host_os.include?("linux")
    archive = "abbotik-cli-v1.7.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "fc027f1992ecda3a5a319766df6162258d7b4f8b4cdf5edd63dc289fdb015fd9"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.7.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

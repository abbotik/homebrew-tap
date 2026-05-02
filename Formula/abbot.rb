class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.10.0-aarch64-apple-darwin.tar.gz"
    checksum = "bac5a01934741bbe4fdd44b35371fece388c7223ebdeed9ba04b06ba0c792a1c"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.10.0-x86_64-apple-darwin.tar.gz"
    checksum = "37c535b70b53cd6c4dd47ea97ab5640129f5de5af0265735734fa873e47acf4b"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.10.0-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "a316927a712f3f11553a46620920929ae1962b4e64cb531a971dee954b80f2bd"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.10.0-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "5ca893449439941d0acf9dc14e8f63ce5bb6dcdc0678b78373ccfce4cc436dae"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.10.0/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

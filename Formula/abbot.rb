class Abbot < Formula
  require "rbconfig"

  desc "Rust CLI for the Abbotik API"
  homepage "https://github.com/abbotik/cli"

  host_os = RUBY_PLATFORM
  host_cpu = RbConfig::CONFIG.fetch("host_cpu")

  if host_os.include?("darwin") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.7.1-aarch64-apple-darwin.tar.gz"
    checksum = "5f33c81277237a89de464e92c1c4cae860829096c3fb749f1a54384f9a4cbb0f"
  elsif host_os.include?("darwin") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.7.1-x86_64-apple-darwin.tar.gz"
    checksum = "c804cc96a087dbf9deb267b55a5795a68b74004fd022cde982d56d604d811ac2"
  elsif host_os.include?("linux") && host_cpu.match?(/arm|aarch64/)
    archive = "abbotik-cli-v1.7.1-aarch64-unknown-linux-gnu.tar.gz"
    checksum = "78c01cb4b79a36125097924f1badda291f0b43eb23313097e8d864d4c6ae8504"
  elsif host_os.include?("linux") && host_cpu == "x86_64"
    archive = "abbotik-cli-v1.7.1-x86_64-unknown-linux-gnu.tar.gz"
    checksum = "95e0963be1b562967e26708f49c487005a731e19709a4a0e4ea611ea5f68e1e7"
  else
    raise "Unsupported platform for abbot: #{host_os} / #{host_cpu}"
  end

  url "https://github.com/abbotik/homebrew-releases/releases/download/abbot-v1.7.1/#{archive}"
  sha256 checksum
  license "MIT"

  def install
    bin.install "abbot"
  end

  test do
    assert_match "abbot", shell_output("#{bin}/abbot --help")
  end
end

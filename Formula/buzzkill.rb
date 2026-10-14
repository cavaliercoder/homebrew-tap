class Buzzkill < Formula
  desc "Silence daemon that works around the macOS Tahoe USB audio buffer-loop buzz"
  homepage "https://github.com/cavaliercoder/macos-buzzkill"
  url "https://github.com/cavaliercoder/macos-buzzkill/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "47b4863c22d68eefe37141badc16f8361091f85bd8b6704c8423f760f9ff3a91"
  license "MIT"

  depends_on :macos
  depends_on xcode: :build

  def install
    system "swiftc", "-O", "buzzkilld.swift", "-o", "buzzkilld"
    bin.install "buzzkilld"
  end

  service do
    run [opt_bin/"buzzkilld"]
    keep_alive true
    process_type :interactive
    log_path var/"log/buzzkill.log"
    error_log_path var/"log/buzzkill.log"
  end

  test do
    assert_path_exists bin/"buzzkilld"
  end
end


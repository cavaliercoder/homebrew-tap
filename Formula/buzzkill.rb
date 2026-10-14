class Buzzkill < Formula
  desc "Silence daemon that works around the macOS Tahoe USB audio buffer-loop buzz"
  homepage "https://github.com/cavaliercoder/macos-buzzkill"
  url "https://github.com/cavaliercoder/macos-buzzkill/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "dc72cc9a100e645084b07f8e1c82cdf0f9fcce6142a6d498f4409b017c161fb4"
  license "MIT"

  depends_on :macos

  uses_from_macos "swift" => :build

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release"
    bin.install ".build/release/buzzkilld"
  end

  def caveats
    <<~EOS
      macOS may ask to allow microphone access for buzzkilld when the service
      first starts. buzzkilld never records; choose Don't Allow.
    EOS
  end

  service do
    run [opt_bin/"buzzkilld"]
    keep_alive true
    process_type :interactive
    log_path var/"log/buzzkill.log"
    error_log_path var/"log/buzzkill.log"
  end

  test do
    # Without a usable output device the daemon exits with an error instead
    # of playing silence; either way it must start and report its state.
    log = testpath/"buzzkilld.log"
    pid = spawn bin/"buzzkilld", [:out, :err] => log.to_s
    begin
      sleep 2
      assert_match "buzzkilld:", log.read
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
  end
end

class Dmidecode < Formula
  desc "Reports information about your system's hardware"
  homepage "https://github.com/cavaliercoder/dmidecode-osx"
  url "https://github.com/cavaliercoder/dmidecode-osx/archive/refs/tags/v3.1.tar.gz"
  sha256 "b7ee6fe84e0e9015ac09a903fc3906c388087da504e394e07cb2cd274ba3faa1"

  def install
    system "make", "dmidecode"
    bin.install "dmidecode"
    man8.install "man/dmidecode.8"
  end

  test do
    # Apple Silicon has no SMBIOS service, so don't read it.
    assert_match version.to_s, shell_output("#{bin}/dmidecode --version")
  end
end

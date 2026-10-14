class Dmidecode < Formula
  desc "Dmidecode reports information about your system's hardware."
  homepage "https://github.com/cavaliercoder/dmidecode-osx"
  url "https://github.com/cavaliercoder/dmidecode-osx/archive/v3.1.tar.gz"
  version "3.1"
  sha256 "b7ee6fe84e0e9015ac09a903fc3906c388087da504e394e07cb2cd274ba3faa1"

  def install
    system "make", "dmidecode"
    bin.install "dmidecode"
    man8.install "man/dmidecode.8"
  end

  test do
    system "#{bin}/dmidecode"
  end
end


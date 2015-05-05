class Puzzles < Formula
  homepage "http://www.chiark.greenend.org.uk/~sgtatham/puzzles/"
  url "https://mirrors.kernel.org/debian/pool/main/s/sgt-puzzles/sgt-puzzles_20140928.r10274.orig.tar.gz"
  mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/s/sgt-puzzles/sgt-puzzles_20140928.r10274.orig.tar.gz"
  sha256 "d8c61b29c4cb39d991e4440e411fd0d78f23fdf5fb96621b83ac34ab396823aa"
  version "10274"

  head "git://git.tartarus.org/simon/puzzles.git"

  depends_on "halibut"

  def install
    system "perl", "mkfiles.pl"
    system "make", "-d", "-f", "Makefile.osx", "all"
    prefix.install "Puzzles.app"
  end

  test do
    File.executable? prefix/"Puzzles.app/Contents/MacOS/puzzles"
  end
end

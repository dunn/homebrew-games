class Robotfindskitten < Formula
  homepage "http://robotfindskitten.org/"
  url "https://downloads.sourceforge.net/project/rfk/robotfindskitten-POSIX/mayan_apocalypse_edition/robotfindskitten-2.7182818.701.tar.gz"
  sha256 "7749a370796fd23e3b306b00de5f7fb7997a35fef30e3910ff159448c932d719"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
    # This project installs to "games", but we want it in "bin" so it
    # symlinks in.  Can't find a ./configure switch, so just rename
    # it.
    (prefix+"games").rename bin
  end

  test do
    system bin/"robotfindskitten", "-V"
  end
end

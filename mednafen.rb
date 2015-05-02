class Mednafen < Formula
  homepage "http://mednafen.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/mednafen/Mednafen/0.9.38.4/mednafen-0.9.38.4.tar.bz2"
  sha256 "3298e2d5c03efbe638c2a98bf74435e306768461c65d2bb9b9a95e99dc463105"

  bottle do
    root_url "https://downloads.sf.net/project/machomebrew/Bottles/games"
    sha1 "84e3203ab953fbed5a22499a2ad64aa6f17f4d80" => :yosemite
    sha1 "b251d8fb372df3d5665156a6bd49fd17a5eed618" => :mavericks
    sha1 "09ade315444535e750cb204d0280c9c7d833f12a" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "libcdio"
  depends_on "libsndfile"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make", "install"
  end
end

class Freeciv < Formula
  homepage "http://freeciv.wikia.com"
  url "https://downloads.sourceforge.net/project/freeciv/Freeciv%202.5/2.5.0/freeciv-2.5.0.tar.bz2"
  mirror "http://download.gna.org/freeciv/stable/freeciv-2.5.0.tar.bz2"
  sha256 "bd9f7523ea79b8d2806d0c1844a9f48506ccd18276330580319913c43051210b"

  head do
    url "svn://svn.gna.org/svn/freeciv/trunk"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "gettext" => :build
    depends_on "libtool" => :build
  end

  bottle do
    root_url "https://homebrew.bintray.com/bottles-games"
    sha1 "e6fef82f1c970359033bff3cd9d8f809b2023f85" => :yosemite
    sha1 "a495fc6b1197a2e849c08cc0fff194b02ecb267d" => :mavericks
    sha1 "a1a7dbcd4b0ee32c72586e14f7fe53fc5ec5797c" => :mountain_lion
  end

  option "without-nls", "Disable NLS support"
  option "without-sdl", "Disable the SDL Freeciv client"
  option "with-gtk+", "Enable the GTK+ Freeciv client"
  option "without-gtk+3", "Disable the GTK+3 Freeciv client"

  depends_on "gettext" if build.with? "nls"
  depends_on "icu4c"
  depends_on "pkg-config" => :build
  depends_on "readline"
  depends_on :x11

  depends_on "sdl" => :recommended
  if build.with? "sdl"
    depends_on "freetype"
    depends_on "sdl_image"
    depends_on "sdl_gfx"
    depends_on "sdl_mixer"
    depends_on "sdl_ttf"
  end

  depends_on "gtk+" => :optional
  depends_on "gtk+3" => :recommended
  if build.with?("gtk+") || build.with?("gtk+3")
    depends_on "atk"
    depends_on "glib"
    depends_on "pango"
  end
  depends_on "gdk-pixbuf" if build.with? "gdk+3"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --prefix=#{prefix}
      --with-readline=#{Formula["readline"].opt_prefix}
    ]

    if build.without? "nls"
      args << "--disable-nls"
    else
      gettext = Formula["gettext"]
      args << "CFLAGS=-I#{gettext.include}"
      args << "LDFLAGS=-L#{gettext.lib}"
    end

    if build.head?
      inreplace "./autogen.sh", "libtoolize", "glibtoolize"
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end

    system "make", "install"
  end

  test do
    system bin/"freeciv-manual"
    File.exist? testpath/"manual6.html"

    server = fork do
      system bin/"freeciv-server", "-l", testpath/"test.log"
    end
    sleep 5
    Process.kill("TERM", server)
    File.exist? testpath/"test.log"
  end
end

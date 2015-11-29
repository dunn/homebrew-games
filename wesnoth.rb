class Wesnoth < Formula
  desc "Single- and multi-player turn-based strategy game"
  homepage "http://www.wesnoth.org/"

  stable do
    url "https://downloads.sourceforge.net/project/wesnoth/wesnoth-1.12/wesnoth-1.12.6/wesnoth-1.12.6.tar.bz2"
    mirror "https://mirrors.ocf.berkeley.edu/debian/pool/main/w/wesnoth-1.12/wesnoth-1.12_1.12.6.orig.tar.bz2"
    sha256 "a50f384cead15f68f31cfa1a311e76a12098428702cb674d3521eb169eb92e4e"

    if OS.linux?
      # On linux, x11 driver is needed by the windowing and clipboard code
      depends_on "sdl" => "with-x11"
    else
      depends_on "sdl"
    end
    depends_on "sdl_image"
    depends_on "sdl_mixer" => "with-libvorbis" # The music is in .ogg format
    depends_on "sdl_net"
    depends_on "sdl_ttf"
  end

  bottle do
    sha256 "63250b3eefb3ff93eba14addee9acfb6980ba138b9033b824a14f5e2a3a5a4b0" => :yosemite
    sha256 "93e971f838ba9c2bf97974dc3ef7d6823138bdda560671d67cf74794d65c4f30" => :mavericks
    sha256 "dcbc0e81cd0a5c92392b51b1e68f933045277bf75eeddebaa3b99797c45ce6be" => :mountain_lion
  end

  devel do
    url "https://downloads.sourceforge.net/project/wesnoth/wesnoth/wesnoth-1.13.6/wesnoth-1.13.6.tar.bz2"
    sha256 "a10a193ef8bc9963b2e241826628a120bb7dda758eb2d25d9ad110ad4916937c"

    if OS.linux?
      # On linux, x11 driver is needed by the windowing and clipboard code
      depends_on "sdl2" => "with-x11"
    else
      depends_on "sdl2"
    end
    depends_on "sdl2_image"
    depends_on "sdl2_mixer" => "with-libvorbis" # The music is in .ogg format
    depends_on "sdl2_ttf"
  end

  head do
    url "https://github.com/wesnoth/wesnoth.git"

    if OS.linux?
      # On linux, x11 driver is needed by the windowing and clipboard code
      depends_on "sdl2" => "with-x11"
    else
      depends_on "sdl2"
    end
    depends_on "sdl2_image"
    depends_on "sdl2_mixer" => "with-libvorbis" # The music is in .ogg format
    depends_on "sdl2_ttf"
  end

  option "with-ccache", "Speeds recompilation, convenient for beta testers"
  option "with-debug", "Build with debugging symbols"

  depends_on "scons" => :build
  depends_on "gettext" => :build
  depends_on "ccache" => :optional
  depends_on "fribidi"
  depends_on "boost"
  depends_on "libpng"
  depends_on "fontconfig"
  depends_on "cairo"
  depends_on "pango"

  def install
    inreplace "SConstruct", "Carbon", "Cocoa" if build.stable?

    args = %W[
      prefix=#{prefix}
      docdir=#{doc}
      mandir=#{man}
      fifodir=#{var}/run/wesnothd
      gettextdir=#{Formula["gettext"].opt_prefix}
      OS_ENV=true
      install
      wesnoth
      wesnothd
      -j#{ENV.make_jobs}
    ]

    args << "ccache=true" if build.with? "ccache"
    args << "build=debug" if build.with? "debug"

    scons *args
  end

  test do
    system bin/"wesnoth", "-p", share/"wesnoth/data/campaigns/tutorial/", testpath
  end
end

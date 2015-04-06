class Wumpus < Formula
  homepage "http://www.catb.org/~esr/wumpus/"
  url "http://www.catb.org/~esr/wumpus/wumpus-1.6.tar.gz"
  sha256 "965e49b3e53f44023994b42b3aa568ad79d3a2287bb0a07460b601500c9ae16d"

  # Patches to allow `make install` to specify a prefix; both patches
  # can be removed in the next release
  patch do
    url "http://thyrsus.com/gitweb/?p=wumpus.git;a=patch;h=ea272d4786a55dbaa493d016324b7a05b4f165b9"
    sha256 "33730ae3874fe8cafd05ddd1a0280ba72d05f2eabbd9ffc6549eeff53b4a9963"
  end
  patch do
    url "http://thyrsus.com/gitweb/?p=wumpus.git;a=patch;h=99022db86e54c3338d6a670f219a0845fd531530"
    sha256 "43beee9e6bbe42f351b7eabe91d4453d9aadd12a5a5f7f32bcc977cafbb23c13"
  end

  def install
    system "make"
    system "make", "prefix=#{prefix}", "install"
  end

  test do
    assert_match("HUNT THE WUMPUS",
                 pipe_output(bin/"wumpus", "^C"))
  end
end

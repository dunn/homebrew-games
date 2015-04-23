class GnuChess < Formula
  homepage "https://www.gnu.org/software/chess/"
  url "http://ftpmirror.gnu.org/chess/gnuchess-6.2.1.tar.gz"
  mirror "https://ftp.gnu.org/gnu/chess/gnuchess-6.2.1.tar.gz"
  sha256 "17caab725539447bcb17a14b17905242cbf287087e53a6777524feb7bbaeed06"

  option "with-book", "Download the opening book (~25MB)"

  resource "book" do
    url "http://ftpmirror.gnu.org/chess/book_1.02.pgn.gz"
    sha256 "deac77edb061a59249a19deb03da349cae051e52527a6cb5af808d9398d32d44"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
    doc.install Dir["doc/*"], "TODO", "README"

    if build.with? "book"
      resource("book").stage do
        doc.install "book_1.02.pgn"
      end
    end
  end

  if build.with? "book"
    def caveats; <<-EOS.undent
      This formula also downloads the additional opening book.  The
      opening book is a PGN file located in #{doc} that can be added
      using gnuchess commands.
    EOS
    end
  end

  test do
    assert_match version.to_s,
                 shell_output("#{bin}/gnuchess --version")
  end
end

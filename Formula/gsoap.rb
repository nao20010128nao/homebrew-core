class Gsoap < Formula
  desc "SOAP stub and skeleton compiler for C and C++"
  homepage "https://www.genivia.com/products.html"
  url "https://downloads.sourceforge.net/project/gsoap2/gsoap-2.8/gsoap_2.8.63.zip"
  sha256 "c6bbd6cd4290136db77649dd709e7d42dfd7625116487350d5ed6b799b02b72d"

  bottle do
    sha256 "f679d033483903a9be5ed20f39f514439fe8652f9864a08fd361ef7f9a49a7ee" => :high_sierra
    sha256 "5b1ad4ede9de7834fcd144a2212068d67851c7f41eaa796ba40ddcc254673aa8" => :sierra
    sha256 "e0f5e6acf7f21b5505cff2e230e3e9e196f3433d595b2072b4f46a494de2f212" => :el_capitan
    sha256 "93404f6c9edfcd502db40fc6183ebd2c12eb5cf7a1e5b5fb54ff398bc038ff8f" => :x86_64_linux
  end

  depends_on "openssl"
  unless OS.mac?
    depends_on "bison"
    depends_on "flex"
  end

  def install
    # Contacted upstream by email and been told this should be fixed by 2.8.37,
    # it is due to the compilation of symbol2.c and soapcpp2_yacc.h not being
    # ordered correctly in parallel.
    ENV.deparallelize
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/wsdl2h", "-o", "calc.h", "https://www.genivia.com/calc.wsdl"
    system "#{bin}/soapcpp2", "calc.h"
    assert_predicate testpath/"calc.add.req.xml", :exist?
  end
end

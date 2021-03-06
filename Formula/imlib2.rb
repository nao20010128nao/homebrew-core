class Imlib2 < Formula
  desc "Image loading and rendering library"
  homepage "https://sourceforge.net/projects/enlightenment/"
  url "https://downloads.sourceforge.net/project/enlightenment/imlib2-src/1.4.10/imlib2-1.4.10.tar.bz2"
  sha256 "3f698cd285cbbfc251c1d6405f249b99fafffafa5e0a5ecf0ca7ae49bbc0a272"
  revision OS.mac? ? 1 : 2

  bottle do
    rebuild 1
    sha256 "b4ca64f45e433cfa1779ed0a8616f2b8130d63b8e15796dea55ff390cbeaff46" => :high_sierra
    sha256 "8ee074fbc1fa4ec9b48151518cc4dcfaf02ad15a9001288f636d94684e7172a1" => :sierra
    sha256 "139bf652a1e3b056f9100d33adeab3a576cd87cc86e7d7566cf1acadd8638fda" => :el_capitan
    sha256 "c817b22453401f614d195af1009aaa3a94d0e5c08db2d4ef34cf76a1c74720b5" => :yosemite
    sha256 "217f9cb06b4388bb2b365eaf6783b1b963a84251e1cdbdb6f0c7f578520c50d8" => :x86_64_linux
  end

  deprecated_option "without-x" => "without-x11"

  depends_on "pkg-config" => :build
  depends_on "freetype"
  depends_on "libpng" => :recommended
  depends_on "jpeg" => :recommended
  depends_on "giflib" => :recommended
  depends_on "libtiff" => :recommended
  depends_on "libid3tag" => :optional
  depends_on :x11 => :recommended if OS.mac?
  depends_on "linuxbrew/xorg/xorg" unless OS.mac?

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --enable-amd64=no
    ]
    args << "--without-x" if build.without? "x11"
    args << "--without-id3" if build.without? "libid3tag"

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/imlib2_conv", test_fixtures("test.png"), "imlib2_test.png"
  end
end

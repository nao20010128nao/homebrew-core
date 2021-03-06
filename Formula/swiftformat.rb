class Swiftformat < Formula
  desc "Formatting tool for reformatting Swift code"
  homepage "https://github.com/nicklockwood/SwiftFormat"
  url "https://github.com/nicklockwood/SwiftFormat/archive/0.33.4.tar.gz"
  sha256 "d44d9810463b34bb13227343aec887224ee216a9f03a2117545ee28be19fd573"

  head "https://github.com/nicklockwood/SwiftFormat.git", :shallow => false

  bottle do
    cellar :any_skip_relocation
    sha256 "4da606702dec89f7b1dabfa3620bb7158eb73fc31f3fbc85f60a1947c8d5b445" => :high_sierra
    sha256 "c92969aff4a2869fb17a674b455d655388c28775e5816aa66f1d98cd80505c9c" => :sierra
  end

  depends_on :macos
  depends_on :xcode => ["9.0", :build]

  def install
    xcodebuild "-project",
        "SwiftFormat.xcodeproj",
        "-scheme", "SwiftFormat (Command Line Tool)",
        "CODE_SIGN_IDENTITY=",
        "SYMROOT=build", "OBJROOT=build"
    bin.install "build/Release/swiftformat"
  end

  test do
    (testpath/"potato.swift").write <<~EOS
      struct Potato {
        let baked: Bool
      }
    EOS
    system "#{bin}/swiftformat", "#{testpath}/potato.swift"
  end
end

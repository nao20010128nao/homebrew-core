require "language/node"

class Quicktype < Formula
  desc "Generate types and converters from JSON, Schema, and GraphQL"
  homepage "https://github.com/quicktype/quicktype"
  url "https://registry.npmjs.org/quicktype/-/quicktype-8.5.81.tgz"
  sha256 "3011d460bced3b90a0e5cefb1357760d05ec6ae809a3501c71a7fbb5a5b10eb6"

  bottle do
    cellar :any_skip_relocation
    sha256 "e3b33ce565c7edd43e4e376f3b5b11bb548da7f6f152c2b7e5d410879a490260" => :high_sierra
    sha256 "6186b69a8ef1a4d144869544581be7cf8220c41f86a12b8e9dd657978bc76e2a" => :sierra
    sha256 "945f9c2996aefd5ad141feea5c6c5eea60559e051e75f9eb52ac933b9d78d8da" => :el_capitan
    sha256 "48a341bacf0a2de3daa08b5765acc05f0ceb01e09922bc0b33f94082793f7fd3" => :x86_64_linux
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"sample.json").write <<~EOS
      {
        "i": [0, 1],
        "s": "quicktype"
      }
    EOS
    output = shell_output("#{bin}/quicktype --lang typescript --src sample.json")
    assert_match "i: number[];", output
    assert_match "s: string;", output
  end
end

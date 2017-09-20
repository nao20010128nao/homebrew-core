require "language/node"

class FirebaseCli < Formula
  desc "Firebase command-line tools"
  homepage "https://firebase.google.com/docs/cli/"
  url "https://registry.npmjs.org/firebase-tools/-/firebase-tools-3.12.0.tgz"
  sha256 "d4dd900039c30393c5ae0c69f70872aa41b5c00fed5798d5204166210a74d327"
  head "https://github.com/firebase/firebase-tools.git"

  bottle do
    sha256 "582bb25ea4d7fbbde42ffb0282dd40ade2157c23de612546f049071bd0be7277" => :sierra
    sha256 "6c25c041eccffb7459fe141c354574a9d11993b007aa528a384fa055c70e03d7" => :el_capitan
    sha256 "5b7e623aeae62c5f1ef9f55d7aef25f7fc0de5e77212363006de11f430bce32d" => :x86_64_linux
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<-EOS.undent
      spawn #{bin}/firebase login:ci --no-localhost
      expect "Paste"
    EOS
    assert_match "authorization code", shell_output("expect -f test.exp")
  end
end

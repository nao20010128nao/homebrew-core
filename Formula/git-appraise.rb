class GitAppraise < Formula
  desc "Distributed code review system for Git repos"
  homepage "https://github.com/google/git-appraise"
  url "https://github.com/google/git-appraise/archive/v0.6.tar.gz"
  sha256 "5c674ee7f022cbc36c5889053382dde80b8e80f76f6fac0ba0445ed5313a36f1"
  head "https://github.com/google/git-appraise.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "e515979b703cef062e19829399ddb441c91d835e25814614c938af36764fc0d4" => :high_sierra
    sha256 "c048f2cce708e7c85c74d18758e47d3959cce29e2f8e70bca021b1564e65092d" => :sierra
    sha256 "e12ce185286565f4f07f48f1deb2fd4a19043bcafb337de94b9ba7148291b91b" => :el_capitan
    sha256 "c32da22cd50d604799065ab2e1a48921d55f78fb2278f5ba78a9b85c86e85229" => :x86_64_linux
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    (buildpath/"src/github.com/google").mkpath
    ln_s buildpath, buildpath/"src/github.com/google/git-appraise"

    system "go", "build", "-o", bin/"git-appraise", "github.com/google/git-appraise/git-appraise"
  end

  test do
    system "git", "init"
    system "git", "config", "user.email", "user@email.com"
    (testpath/"README").write "test"
    system "git", "add", "README"
    system "git", "commit", "-m", "Init"
    system "git", "branch", "user/test"
    system "git", "checkout", "user/test"
    (testpath/"README").append_lines "test2"
    system "git", "add", "README"
    system "git", "commit", "-m", "Update"
    system "git", "appraise", "request", "--allow-uncommitted"
    assert_predicate testpath/".git/refs/notes/devtools/reviews", :exist?
  end
end

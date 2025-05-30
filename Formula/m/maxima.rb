class Maxima < Formula
  desc "Computer algebra system"
  homepage "https://maxima.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/maxima/Maxima-source/5.47.0-source/maxima-5.47.0.tar.gz"
  sha256 "9104021b24fd53e8c03a983509cb42e937a925e8c0c85c335d7709a14fd40f7a"
  license "GPL-2.0-only"
  revision 20

  livecheck do
    url :stable
    regex(%r{url=.*?/maxima[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c7907d65d5846cc62c4368f9da024012f763817903839890e1bd3a16b3dff656"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f779667b79fa8a03818726304ee810ccdabe86828bd266bb5651da8073da44b8"
    sha256 cellar: :any_skip_relocation, sonoma:        "cd4114427ce23c81a7d821aa8689313678be0b42e68312c0725a097f68ebf740"
    sha256 cellar: :any_skip_relocation, ventura:       "41e318aa895b8a823651a103913dbbeee88866d16f0b41d3c5ecf9809c81eca3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1926acc7d2a714be8db5f47df5b386d8a01031da622abb9d298c17a7fc96df83"
  end

  depends_on "gawk" => :build
  depends_on "gnu-sed" => :build
  depends_on "perl" => :build
  depends_on "texinfo" => :build
  depends_on "gettext"
  depends_on "gnuplot"
  depends_on "rlwrap"
  depends_on "sbcl"

  def install
    ENV["LANG"] = "C" # per build instructions
    system "./configure",
           "--disable-debug",
           "--disable-dependency-tracking",
           "--prefix=#{prefix}",
           "--enable-gettext",
           "--enable-sbcl",
           "--with-emacs-prefix=#{share}/emacs/site-lisp/#{name}",
           "--with-sbcl=#{Formula["sbcl"].opt_bin}/sbcl"
    system "make"
    system "make", "install"
  end

  test do
    system bin/"maxima", "--batch-string=run_testsuite(); quit();"
  end
end

class PasswordCracking < Formula
  desc "High-performance ZIP, PDF and Office password cracker"
  homepage "https://github.com/LiangLliu/password-cracking"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-macos-arm64.tar.gz"
      sha256 "4aa10eceb2c46f7bda93cc4922fd0e5c3fb5944d80abe48d10a2022aff3682bd"
    end

    on_intel do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-macos-amd64.tar.gz"
      sha256 "45fc5e675b7854aa767cdf8ccb724fcf521d97ef23f2ff34ae65eaa17844e446"
    end
  end

  on_linux do
    # Static musl builds run on any distribution, independent of glibc.
    on_arm do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-linux-arm64-musl.tar.gz"
      sha256 "e5a2312686d1289910a5551773a16a78b1b380584378d67458e3133ef1e3b31a"
    end

    on_intel do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-linux-amd64-musl.tar.gz"
      sha256 "8ff42467e8fbaa7e46be0b0103d9876601a306f5738caf98737273af91d03a10"
    end
  end

  def install
    bin.install "password-cracking"

    generate_completions_from_executable(bin/"password-cracking", "completions")

    (buildpath/"password-cracking.1").write Utils.safe_popen_read(bin/"password-cracking", "man")
    man1.install "password-cracking.1"
  end

  test do
    assert_match "password-cracking #{version}", shell_output("#{bin}/password-cracking --version")
    assert_match "per-position character sets", shell_output("#{bin}/password-cracking mask --help")
  end
end

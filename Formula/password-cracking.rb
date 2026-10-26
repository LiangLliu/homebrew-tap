class PasswordCracking < Formula
  desc "High-performance ZIP, PDF and Office password cracker"
  homepage "https://github.com/LiangLliu/password-cracking"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-macos-arm64.tar.gz"
      sha256 "a59353ade448f8f8fb2aa84f0b869259c99dcc03bdd7ebf5fdc32090da224e11"
    end

    on_intel do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-macos-amd64.tar.gz"
      sha256 "37f7bb9856764e12b15615536c04b0bb924fee23a1c5b8f9f21502a495f0f90b"
    end
  end

  on_linux do
    # Static musl builds run on any distribution, independent of glibc.
    on_arm do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-linux-arm64-musl.tar.gz"
      sha256 "68e93c195c469006fa0103778b944542cb6e0743b6c51407e57cd27535308483"
    end

    on_intel do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-linux-amd64-musl.tar.gz"
      sha256 "de3b10f34b72528b26495479e581b097cd0a90b456cd65150dcb3a076dab1bc3"
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

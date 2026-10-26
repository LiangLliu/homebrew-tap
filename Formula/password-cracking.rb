class PasswordCracking < Formula
  desc "High-performance ZIP, PDF and Office password cracker"
  homepage "https://github.com/LiangLliu/password-cracking"
  version "0.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.1/password-cracking-macos-arm64.tar.gz"
      sha256 "90363100d8e28659fabb6a0db723a1b80d7b395189fcddbf864164f13d4ee3e5"
    end

    on_intel do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.1/password-cracking-macos-amd64.tar.gz"
      sha256 "0d4f6215d8942ae367f4c737a738aab228e740f9cc51c7015dfd53e1eb62ecc3"
    end
  end

  on_linux do
    # Static musl builds run on any distribution, independent of glibc.
    on_arm do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.1/password-cracking-linux-arm64-musl.tar.gz"
      sha256 "b37071c4b3f3de4ae5c94d373de4af9a35faa71e2aa501a4fb9fbfe4f3f157cc"
    end

    on_intel do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.1/password-cracking-linux-amd64-musl.tar.gz"
      sha256 "9951337f6c71fe91cb1eaafa733c486387a59adbe350865e9e905e1639c7cdf2"
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

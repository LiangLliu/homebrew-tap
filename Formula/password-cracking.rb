class PasswordCracking < Formula
  desc "High-performance ZIP, PDF and Office password cracker"
  homepage "https://github.com/LiangLliu/password-cracking"
  version "0.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-macos-arm64.tar.gz"
      sha256 "384510796b13c0b4efade3c503ce8ad2ab13d84186c31449bbdbfe250e2fa2f7"
    end

    on_intel do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-macos-amd64.tar.gz"
      sha256 "f45a32a77abad9a6e295e26ea87eae413b98d65486abfaa45e634b76e5ea2d02"
    end
  end

  on_linux do
    # Static musl builds run on any distribution, independent of glibc.
    on_arm do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-linux-arm64-musl.tar.gz"
      sha256 "c09ceb61f58da009e5148821e569940e3ea252dff90cebf67f7761939754b9b5"
    end

    on_intel do
      url "https://github.com/LiangLliu/password-cracking/releases/download/v0.2.0/password-cracking-linux-amd64-musl.tar.gz"
      sha256 "64ac26fd0685117f0c7a3bb48bd262e508e20de32f61de5c2f45d95670bafe21"
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

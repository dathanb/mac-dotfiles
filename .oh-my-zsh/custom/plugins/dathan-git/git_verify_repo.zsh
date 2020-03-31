# Returns failure if the current directory is not part of a git repository
git_verify_repo() {
  git rev-parse --git-dir 2>/dev/null >/dev/null
  if [[ $? != 0 ]]; then
    echo "$PWD is not a git repository"
    return 1
  fi
}

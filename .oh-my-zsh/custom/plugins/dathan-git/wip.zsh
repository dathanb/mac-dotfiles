pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_verify_repo.zsh"

# Commits the current working tree as a "work in progress" commit
# Inspired by https://gist.github.com/tzellman/1948602#file-gitconfig-L2
wip() {
  git_verify_repo || return 1

  git add -A || return 1
  git ls-files --deleted -z | xargs -0 git rm
  git commit -m "wip"
}

# If the last commit was a "work in progress" commit, resets it
# Inspired by https://gist.github.com/tzellman/1948602#file-gitconfig-L3
unwip() {
  git_verify_repo || return 1
  git log -n 1 | grep -q -c wip && git reset HEAD~1
}

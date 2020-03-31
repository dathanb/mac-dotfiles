pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_verify_repo.zsh"

# removes local branches that have been merged
git_clean_merged_branches() {
  git_verify_repo || return 1

  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

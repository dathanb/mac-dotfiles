pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_verify_repo.zsh"

# For gitflow, returns the name of the current feature
# e.g., if your current branch is "feature/some_feature_name", returns "some_feature_name"
git_current_feature() {
  git_verify_repo || return 1

  local _BRANCH
  local _FEATURE

  _BRANCH=`git rev-parse --abbrev-ref HEAD`
  _FEATURE=`sed -e 's/^feature\///' <<< $_BRANCH`

  echo $_FEATURE
}

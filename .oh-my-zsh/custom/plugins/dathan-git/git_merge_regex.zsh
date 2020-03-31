pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_verify_repo.zsh"
. "${pluginDir}/git_branch_regex.zsh"

# Matches the set of local branches against the provided regex
# If there's no match, fails
# If there are multiple matches, prints the matching branches and fails
# If there's a single match, runs git merge --no-ff matching_branch_name
git_merge_regex() {
  git_branch_regex $1 || return 1

  git merge --no-ff "$_matching_branches[1]"
}

pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_verify_repo.zsh"
. "${pluginDir}/git_branch_regex.zsh"

# Matches the set of local branches against the provided regex
# If there's no match, fails
# If there are multipe matches, prints the matching branches and fails
# If there's a single match, runs git branch -d matching_branch_name
git_delete_branch() {
  git_branch_regex $1 || return 1

  git branch -d "$_matching_branches[1]"
}

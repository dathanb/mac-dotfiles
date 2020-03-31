pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_branch_regex.zsh"

# Matches the set of local branches against the provided regex
# If there's no match, fails
# If there are multiple matches, prints the matching branches and fails
# If there's a single match, runs git checkout matching_branch_name
git_checkout_regex() {
  git_branch_regex $1 || return 1

  git checkout "$_matching_branches[1]"
}

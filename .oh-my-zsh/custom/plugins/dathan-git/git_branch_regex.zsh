pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_verify_repo.zsh"

# Matches the set of local branches against the provided regex
# If there's no match, fails
# If there are multiple matches, prints the matching branches and fails
# If there's a single match, returns it
git_branch_regex() {
  git_verify_repo || return 1
  local _branches

  _branches=( $( command git branch | cut -c 3- ) )

  _matching_branches=()

  for b in "${_branches[@]}"; do
    if [[ "$b" =~ "$1" ]]; then
      _matching_branches+=("$b")
    fi
  done

  if [[ ${#_matching_branches[@]} == 0 ]]; then
    echo "No branches matched expression '$1'"
    return 1
  elif [[ ${#_matching_branches[@]} > 1 ]]; then
    echo "Multiple branches matched expression '$1':"
    for b in "${_matching_branches[@]}"; do
      echo $b
    done
    return 2
  fi
}

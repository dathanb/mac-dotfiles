pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_verify_repo.zsh"

open_jira_ticket_for_current_branch() {
  git_verify_repo || return 1

  _BRANCH=`git rev-parse --abbrev-ref HEAD`
  _TICKET=`sed -E -e 's/^([[:alpha:]]+\/)*([[:alpha:]]+-[[:digit:]]+).*$/\2/' <<< $_BRANCH`

  open "https://jira.netflix.com/browse/${_TICKET}"
}

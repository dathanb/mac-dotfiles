# 'Goto Git Root'
# Will change directory to the root of the current git repo
# Also prints the directory, so you can easily use it in a subshell to get the path of your repo
# e.g., cat `ggr`/.gitignore
ggr() {
  local _TMP_REVPARSE
  local RET_VAL
  _TMP_REVPARSE=`git rev-parse --show-toplevel`
  if [ "$?" -ne 0 ]; then
    return 1
  fi

  cd "$_TMP_REVPARSE"
  if [ "$?" -ne 0 ]; then
    return 1
  fi

  pwd
}

# Returns failure if the current directory is not part of a git repository
git_verify_repo() {
  git rev-parse --git-dir 2>/dev/null >/dev/null
  if [[ $? != 0 ]]; then
    echo "$PWD is not a git repository"
    return 1
  fi
}

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

# Matches the set of local branches against the provided regex
# If there's no match, fails
# If there are multipe matches, prints the matching branches and fails
# If there's a single match, runs git branch -d matching_branch_name
git_delete_branch() {
  git_branch_regex $1 || return 1

  git branch -d "$_matching_branches[1]"
}

# Matches the set of local branches against the provided regex
# If there's no match, fails
# If there are multiple matches, prints the matching branches and fails
# If there's a single match, runs git checkout matching_branch_name
git_checkout_regex() {
  git_branch_regex $1 || return 1

  git checkout "$_matching_branches[1]"
}

# Matches the set of local branches against the provided regex
# If there's no match, fails
# If there are multiple matches, prints the matching branches and fails
# If there's a single match, runs git merge --no-ff matching_branch_name
git_merge_regex() {
  git_branch_regex $1 || return 1

  git merge --no-ff "$_matching_branches[1]"
}

# Commits the current working tree as a "work in progress" commit
# Inspired by https://gist.github.com/tzellman/1948602#file-gitconfig-L2
wip() {
  git_verify_repo || return 1

  git add -A || return 1
  git ls-files --deleted -z | xargs -0 git rm
  git commit -m "wip"
}

open_jira_ticket_for_current_branch() {
  git_verify_repo || return 1

  _BRANCH=`git rev-parse --abbrev-ref HEAD`
  _TICKET=`sed -E -e 's/^([[:alpha:]]+\/)*([[:alpha:]]+-[[:digit:]]+).*$/\2/' <<< $_BRANCH`

  open "https://udacity.atlassian.net/browse/${_TICKET}"
}

# If the last commit was a "work in progress" commit, resets it
# Inspired by https://gist.github.com/tzellman/1948602#file-gitconfig-L3
unwip() {
  git_verify_repo || return 1
  git log -n 1 | grep -q -c wip && git reset HEAD~1
}

# removes local branches that have been merged
git_clean_merged_branches() {
  git_verify_repo || return 1

  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

alias gr="git rebase"
alias gci="git commit"
alias gb='git branch -v'
alias gl='git log --graph --date=short'
alias gs='git status --short'
alias gnb='git checkout -b'
# GPU == "Git Push Upstream"
alias gpu='git push --set-upstream origin `git rev-parse --abbrev-ref HEAD`'
alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias gfffc="git flow feature finish \`git_current_feature\`"
# GBDR == "Git Branch Delete with Regex"
alias gbdr="git_delete_branch"
# GCOR == "Git CheckOut with Regex
alias gcor="git_checkout_regex"
# GMR == "Git Merge --no-ff with Regex"
alias gmr="git_merge_regex"
alias gff="git pull --ff-only"
alias jira="open_jira_ticket_for_current_branch"

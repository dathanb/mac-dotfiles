# setup git aliases
alias gst='git status --short'
alias gpu='git push --set-upstream origin `git rev-parse --abbrev-ref HEAD`'
#alias ggr='TMP_REVPARSE=`git rev-parse --show-toplevel` && cd "$_TEMP_REVPARSE" && pwd'
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

git_verify_repo() {
  git rev-parse --git-dir 2>/dev/null >/dev/null
  if [[ $? != 0 ]]; then
    echo "$PWD is not a git repository"
    return 1
  fi
}

git_current_feature() {
  git_verify_repo || return 1

  local _BRANCH
  local _FEATURE

  _BRANCH=`git rev-parse --abbrev-ref HEAD`
  _FEATURE=`sed -e 's/^feature\///' <<< $_BRANCH`

  echo $_FEATURE
}

git_delete_branch() {
  git_verify_repo || return 1
  local _branches

  _branches=( $( command git branch | cut -c 3- ) )

  local _matching_branches
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

  echo Deleting branch: $_matching_branches

  git branch -d "$_matching_branches[1]"
}

git_checkout_regex() {
  git_verify_repo || return 1

  local _branches
  _branches=( $( command git branch | cut -c 3- ) )

  local _matching_branches
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

  git checkout "$_matching_branches[1]"

}

alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias gfffc="git flow feature finish \`git_current_feature\`"
alias gdbr="git_delete_branch"
alias gcor="git_checkout_regex"

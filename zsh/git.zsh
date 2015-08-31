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

git_current_feature() {
  local _BRANCH
  local _FEATURE
  _BRANCH=`git rev-parse --abbrev-ref HEAD`
  if [[ ! $_BRANCH =~ "feature" ]]; then
    echo "Not on a feature"
    return 1
  fi

  _FEATURE=`sed -e 's/^feature\///' <<< $_BRANCH`
  echo $_FEATURE
}

git_delete_branch() {
  local _all_branches

  _all_branches=$( command git branch )
  if [ "$?" -ne 0 ]; then
    echo "Failed; are you in a Git repository?"
    return 1
  fi

  _all_branches=( $( cut -c 3- <<< $_all_branches ) )

  local _matching_branches
  _matching_branches=()

  for b in "${_all_branches[@]}"; do
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

alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias gfffc="git flow feature finish \`git_current_feature\`"

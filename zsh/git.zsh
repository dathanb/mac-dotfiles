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

alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias gfffc="git flow feature finish \`git_current_feature\`"

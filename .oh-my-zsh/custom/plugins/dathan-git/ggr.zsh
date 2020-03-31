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

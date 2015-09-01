if [[ -n "$(alias grunt)" ]]; then
  unalias grunt
fi

grunt() {
  if [[ -f "node_modules/grunt-cli/bin/grunt" ]]; then
    node_modules/grunt-cli/bin/grunt "$@"
    return $?
  fi
  noglob command grunt "$@"
}


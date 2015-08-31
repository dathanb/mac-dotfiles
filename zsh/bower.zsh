if [[ -n "$(alias bower)" ]]; then
  unalias bower
fi

bower() {
  if [[ -f "node_modules/bower/bin/bower" ]]; then
    node_modules/bower/bin/bower "$@"
    return $?
  fi
  noglob command bower "$@"
}


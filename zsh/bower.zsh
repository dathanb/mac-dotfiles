# I don't like to install bower globally, but I also don't like to have to type
# ./node_modules/bower/bin/bower or ./node_modules/.bin/bower
# So this function now allows you to just type "bower" and use the local instal if it exists,
# otherwise failover to the global-installed version, if it exists
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


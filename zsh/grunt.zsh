# I don't like to install grunt globally, but I also don't like to have to type
# ./node_modules/grunt/bin/bower or ./node_modules/.bin/bower
# So this function now allows you to just type "grunt" and use the local instal if it exists,
# otherwise failover to the global-installed version, if it exists

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


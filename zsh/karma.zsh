# I don't like to install karma globally, but I also don't like to have to type
# ./node_modules/karma/bin/karma.js or ./node_modules/.bin/karma
# So this function now allows you to just type "karma" and use the local install if it exists,
# otherwise failover to the global-installed version, if it exists
if [[ -n "$(alias karma)" ]]; then
  unalias karma
fi

karma() {
  if [[ -f "node_modules/karma/bin/karma" ]]; then
    node_modules/karma/bin/karma "$@"
    return $?
  fi
  noglob command karma "$@"
}


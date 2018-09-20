# I don't like to install the Typescript compiler globally, but I also don't like to have to type
# ./node_modules/typescript/bin/tsc or ./node_modules/.bin/tsc
# So this function now allows you to just type "tsc" and use the local install if it exists,
# otherwise failover to the global-installed version, if it exists
if [[ -n "$(alias tsc)" ]]; then
  unalias tsc
fi

tsc() {
  if [[ -f "node_modules/typescript/bin/tsc" ]]; then
    node_modules/typescript/bin/tsc "$@"
    return $?
  fi
  noglob command tsc "$@"
  return $?
}


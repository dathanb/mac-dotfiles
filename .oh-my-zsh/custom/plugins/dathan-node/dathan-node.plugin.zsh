# I don't like to install node modules globally, but I also don't like to have to type
# ./node_modules/bower/bin/bower or ./node_modules/.bin/bower
# So these functions allow you to just type "bower" and use the local install if it exists,
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

if [[ -n "$(alias gulp)" ]]; then
  unalias gulp
fi

gulp() {
  if [[ -f "node_modules/gulp/bin/gulp.js" ]]; then
    node_modules/gulp/bin/gulp.js "$@"
    return $?
  fi
  noglob command gulp "$@"
}

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


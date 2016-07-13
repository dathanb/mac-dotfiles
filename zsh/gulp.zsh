# I don't like to install gulp globally, but I also don't like to have to type
# ./node_modules/gulp/bin/gulp.js or ./node_modules/.bin/gulp
# So this function now allows you to just type "gulp" and use the local install if it exists,
# otherwise failover to the global-installed version, if it exists
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


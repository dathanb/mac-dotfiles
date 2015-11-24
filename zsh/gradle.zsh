for a in gw gwd; do
  if [[ ! -z "$(alias $a)" ]]; then
    unalias "$a"
  fi
done

alias gw="./gradlew"
alias gwd="./gradlew --daemon"


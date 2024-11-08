if [[ -f "/usr/local/bin/virtualenvwrapper.sh" ]]; then
  source /usr/local/bin/virtualenvwrapper.sh
  export WORKON_HOME=~/.virtualenvs
fi

function python3 {
  if [[ -f "./venv/bin/python3" ]]; then
    ./venv/bin/python3 "${@}"
  else
    command python3 "${@}"
  fi
}

function pip3 {
  if [[ -f "./venv/bin/pip3" ]]; then
    ./venv/bin/pip3 "${@}"
  else
    command pip3 "${@}"
  fi
}

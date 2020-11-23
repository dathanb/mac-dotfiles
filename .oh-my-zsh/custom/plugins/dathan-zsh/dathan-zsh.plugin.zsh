# No good reason for this number - I just like it
export HISTSIZE=65535
# persist the same number of history events we keep in memory
export SAVEHIST=$HISTSIZE
export HIST_EXPIRE_DUPS_FIRST=true
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
export EXTENDED_HISTORY=true     # Write the history file in the ":start:elapsed;command" format.
#setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt APPEND_HISTORY            # sessions will append their local history to the history file, rather than replace it
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
#setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
#setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
#setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# I don't like RPROMPT, because I copy from the terminal a lot and it makes that inconvenient
unset RPROMPT

# don't activate the pager when output is less than one screen
export LESS="${LESS} --no-init --quit-if-one-screen"

# scroll through command history with arrow keys
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Use vim from MacVim
alias mvim='/Applications/MacVim.app/Contents/bin/mvim'
alias vim='mvim -v'

export TERM=xterm-256color

# use ctrl+v for edit in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd ^v edit-command-line

export PATH="${PATH}:/Users/dathanb/bin"

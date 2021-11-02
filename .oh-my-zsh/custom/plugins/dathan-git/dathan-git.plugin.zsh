pluginDir="$(dirname $0:A)"

. "${pluginDir}/ggr.zsh"
. "${pluginDir}/git_verify_repo.zsh"
. "${pluginDir}/git_current_feature.zsh"
. "${pluginDir}/git_branch_regex.zsh"
. "${pluginDir}/git_delete_branch.zsh"
. "${pluginDir}/git_checkout_regex.zsh"
. "${pluginDir}/git_merge_regex.zsh"
. "${pluginDir}/wip.zsh"
. "${pluginDir}/open_jira_ticket_for_current_branch.zsh"
. "${pluginDir}/git_semver.zsh"
. "${pluginDir}/git_clean_merged_branches.zsh"

# use vimdiff
git config --global diff.tool vimdiff
git config --global merge.tool vimdiff

alias gr="git rebase"
alias gci="git commit"
alias gb='git branch -v'
alias gl='git log --graph --date=short'
alias gs='git status --short'
alias gnb='git checkout -b'
# GPU == "Git Push Upstream"
alias gpu='git push --set-upstream origin `git rev-parse --abbrev-ref HEAD`'
alias gffs="git flow feature start"
alias gfff="git flow feature finish"
alias gfffc="git flow feature finish \`git_current_feature\`"
# GBDR == "Git Branch Delete with Regex"
alias gbdr="git_delete_branch"
# GCOR == "Git CheckOut with Regex
alias gcor="git_checkout_regex"
# GMR == "Git Merge --no-ff with Regex"
alias gmr="git_merge_regex"
alias gff="git pull --ff-only"
alias gffp="git pull --ff-only --prune && git_clean_merged_branches"
#alias jira="open_jira_ticket_for_current_branch"

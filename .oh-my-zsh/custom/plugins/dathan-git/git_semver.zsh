pluginDir="$(dirname $0:A)"

. "${pluginDir}/git_verify_repo.zsh"

##
# Using tags in the git history, create a new final version by striping off
# snapshot and release information from the most recent tag and bumping its
# major version number.
function bump_major() {
  git_verify_repo || return 1
  version="$(git describe --tags)" || return 1
  newVersion="$("${pluginDir}/semver.sh" bump major "${version}")" || return 1
  git tag "v${newVersion}" || return 1
  git push origin --tags || return 1
}

##
# Using tags in the git history, create a new final version by striping off
# snapshot and release information from the most recent tag and bumping its
# minor version number.
function bump_minor() {
  git_verify_repo || return 1
  version="$(git describe --tags)" || return 1
  newVersion="$("${pluginDir}/semver.sh" bump minor "${version}")" || return 1
  git tag "v${newVersion}" || return 1
  git push origin --tags || return 1
}

##
# Using tags in the git history, create a new final version by striping off
# snapshot and release information from the most recent tag and bumping its
# patch version number.
function bump_patch() {
  git_verify_repo || return 1
  version="$(git describe --tags)" || return 1
  newVersion="$("${pluginDir}/semver.sh" bump patch "${version}")" || return 1
  git tag "v${newVersion}" || return 1
  git push origin --tags || return 1
}

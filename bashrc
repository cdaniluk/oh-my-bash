# Path to your oh-my-bash installation.
export OSH=~/.oh-my-bash
OSH_THEME="font"

CASE_SENSITIVE="true"

# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# export UPDATE_OSH_DAYS=13
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"

completions=(
  awscli
  docker
  git
  packer
  ssh
  terraform
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

source $OSH/oh-my-bash.sh


#!/usr/bin/env bash
#
# One line prompt showing the following configurable information
# for git:
# time (virtual_env) username@hostname pwd git_char|git_branch git_dirty_status|→
#
# The → arrow shows the exit status of the last command:
# - bold green: 0 exit status
# - bold red: non-zero exit status
#
# Example outside git repo:
# 07:45:05 user@host ~ →
#
# Example inside clean git repo:
# 07:45:05 user@host .oh-my-bash ±|master|→
#
# Example inside dirty git repo:
# 07:45:05 user@host .oh-my-bash ±|master ✗|→
#
# Example with virtual environment:
# 07:45:05 (venv) user@host ~ →
#

SHOW_AWS_PROMPT=true
BASH_THEME_AWS_PREFIX="[AWS:"
BASH_THEME_AWS_SUFFIX="] "
SCM_NONE_CHAR=''
SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=""
SCM_THEME_PROMPT_PREFIX="${green}|"
SCM_THEME_PROMPT_SUFFIX="${green}|"
SCM_GIT_SHOW_MINIMAL_INFO=true

CLOCK_THEME_PROMPT_PREFIX=''
CLOCK_THEME_PROMPT_SUFFIX=' '
THEME_SHOW_CLOCK=false
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$bold_blue"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%I:%M:%S"}

VIRTUALENV_THEME_PROMPT_PREFIX='('
VIRTUALENV_THEME_PROMPT_SUFFIX=') '

function prompt_command() {
    # This needs to be first to save last command return code
    local RC="$?"

    hostname="${bold_black}\u@\h"
    virtualenv="${white}$(virtualenv_prompt)"

    # Set return status color
    if [[ ${RC} == 0 ]]; then
        ret_status="${bold_green}"
    else
        ret_status="${bold_red}"
    fi

    # Append new history lines to history file
    history -a

    PS1="$(aws_prompt_info)${virtualenv}\u:${bold_cyan}\w $(scm_prompt_char_info)${ret_status}→ ${normal}"
}

# AWS prompt
function aws_prompt_info() {
  [[ -z $AWS_PROFILE ]] && return
  echo "${BASH_THEME_AWS_PREFIX:=<aws:}${AWS_PROFILE}${BASH_THEME_AWS_SUFFIX:=>}"
}

# Custom functions
awslogin() {
    aws-okta login ${AWS_PROFILE}-okta
}

function awsprofiles() {
  [[ -n $1 ]] && FILTER=$1
  [[ -r "${AWS_CONFIG_FILE:-$HOME/.aws/config}" ]] || return 1
  grep '\[profile' "${AWS_CONFIG_FILE:-$HOME/.aws/config}"|sed -e 's/.*profile \([a-zA-Z0-9_\.-]*\).*/\1/' | grep -v "\(-login\|-okta\)$" | grep "${FILTER:-.*}"
}

safe_append_prompt_command prompt_command

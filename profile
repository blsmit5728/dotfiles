# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
source .colors

log_msg() {
    MSG="$1"
    STATUS="$2"
    G=$(tput setaf 2)
    N=$(tput sgr0)
    R=$(tput setaf 1)
    if [ "$STATUS" == "OK" ]
    then
        STATUSCOLOR="[  ${G}${STATUS}${N}  ]"
    else
        STATUSCOLOR="[ ${R}${STATUS}${N} ]"
    fi
    let COL=$(tput cols)-${#MSG}+${#STATUSCOLOR}-${#STATUS}-6
    echo -n $MSG
    printf "%${COL}s\n"  "$STATUSCOLOR"
}

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias mov_lib='cd /mnt/disk1/Library/'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -e /usr/bin/dropbox ]
then
    START=`dropbox status`
    if [ "$START" == "Up to date" ]
    then
        log_msg "Checking Dropbox" "OK"
    else
        log_msg "Checking Dropbox" "FAIL"
        dropbox start
    fi
fi

#export PATH=/home/bsmith/Scripts/flexget:$PATH
alias sort_unptv='flexget --logfile /home/bsmith/.flexget/flexget-sorting.log -c /home/bsmith/.flexget/sort.yml execute --task Sort_Unpacked_TV_Shows --disable-advancement'
alias sort_unpmo='flexget --logfile /home/bsmith/.flexget/flexget-sorting.log -c /home/bsmith/.flexget/sort.yml execute --task Sort_Unpacked_Movies'
alias directory_sort='du -k * | sort -nr | cut -f2 | xargs -d '\n' du -sh'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias mov_lib='cd /mnt/disk1/Library/'
# Alias rm so that I don't accidentally delet files...
alias rm='rm -i'
alias flex_forget='flexget series forget'
alias flex_show='flexget series show'

alias plex_status='python /home/bsmith/repos/plex_status/get_plex_status.py'

export PS1="${GREEN}\u${NORMAL}${CYAN}@${NORMAL}\h:${PURPLE}\W${NORMAL}# "
#

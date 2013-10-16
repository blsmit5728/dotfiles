# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

P=`pwd`
source ${HOME}/.colors

WORK=0

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ "$WORK" -eq "0" ]
then
    if [ -f /usr/bin/dropbox ]
    then 
        START=`dropbox status`
        if [ "$START" == "Idle" ]
        then
	    echo "Dropbox is running"
        else
	    dropbox start
        fi
    fi
    export PATH=/home/bsmith/Scripts/flexget:$PATH
    alias quit_xbmc='/usr/bin/xbmc-send --host=uranium.local --action="XBMC.Quit"'
    alias sort_unptv='flexget --logfile /home/bsmith/.flexget/flexget-sorting.log -c /home/bsmith/.flexget/sort.yml --task Sort_Unpacked_TV_Shows --disable-advancement'
    alias sort_unpmo='flexget --logfile /home/bsmith/.flexget/flexget-sorting.log -c /home/bsmith/.flexget/sort.yml --task Sort_Unpacked_Movies'
    alias sync_files='rsync -arv -update /mnt/disk1/Library/ /mnt/disk2/Library/'
    alias clean_xbmc='/usr/bin/xbmc-send --host=192.168.1.4 --action="XBMC.cleanlibrary(video)"'
    alias update_xbmc='/usr/bin/xbmc-send --host=192.168.1.4 --action="XBMC.updatelibrary(video)"'
else
    alias iv_api_build='cd /proj/accts/picoflexor/bsmith/master_trunk/Iveia_API_lib/2_19_4/ && export BOARD=atlas-i-lpe && make lpe && make install && cd -'
    alias mainapp_quick='make clean && make 2>&1 | tee make.log && grep --color=auto "warning\|error" make.log'
    alias pf_api_doxy_debug='cmake ../ -DCMAKE_BUILD_TYPE=DEBUG -DDOXYGEN_LATEX=YES'
    alias pf_api_doxy='cmake ../ -DDOXYGEN_LATEX=YES'
    alias pf_api_build='cmake ../'
    if [ -d /opt/microchip/ ]
    then 
        export PATH=$PATH:"/opt/microchip/xc32/v1.21/bin:/opt/microchip/mplabx/mplab_ide/bin/"
    fi
    if [ -d /proj/frell_svn_backup/ ]
    then
        # this means that FRACK is mounted...lets alias a couple things.
        alias frack='/proj/accts/'
        alias si9150='/proj/accts/si9150/'
    fi
fi

export PS1="${GREEN}\u${OFF_COLOR}${CYAN}@${OFF_COLOR}${WHITE}\h${OFF_COLOR}:${PURPLE}\W${OFF_COLOR}# "

stty ixany
stty ixoff -ixon




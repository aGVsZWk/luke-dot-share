#                       ██████   █████  ███████ ██   ██
#                       ██   ██ ██   ██ ██      ██   ██
#                       ██████  ███████ ███████ ███████
#                       ██   ██ ██   ██      ██ ██   ██
#                       ██████  ██   ██ ███████ ██   ██

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#                                   Settings

# TERMCAP Setup
# enter blinking mode - red
export LESS_TERMCAP_mb=$(printf '\e[01;31m')
# enter double-bright mode - bold, magenta
export LESS_TERMCAP_md=$(printf '\e[01;35m')
# turn off all appearance modes (mb, md, so, us)
export LESS_TERMCAP_me=$(printf '\e[0m')
# leave standout mode
export LESS_TERMCAP_se=$(printf '\e[0m')
# enter standout mode - green
export LESS_TERMCAP_so=$(printf '\e[01;32m')
# leave underline mode
export LESS_TERMCAP_ue=$(printf '\e[0m')
# enter underline mode - blue
export LESS_TERMCAP_us=$(printf '\e[04;34m')

# Add custom enviroment
PATH=$PATH:~/Scripts

# PS1 Setup
PROMPT_COMMAND=__prompt_command

__prompt_command() {
    local EXITCODE="$?"

    local HOSTCOLOR="5"
    local USERCOLOR="3"
    local PATHCOLOR="4"

    PS1="\[\e[3${HOSTCOLOR}m\] \h  \[\e[3${USERCOLOR}m\] \u  \[\e[3${PATHCOLOR}m\] \w \n";



    if [ $EXITCODE == 0 ]; then
        PS1+="\[\e[32m\]\$ \[\e[0m\]";
    else
        PS1+="\[\e[31m\]\$ \[\e[0m\]";
    fi
}

#                                    Binds

# Fancy commands output
alias ls='els --els-icons=fontawesome'
alias la='els -laH --els-icons=fontawesome'
alias du='du -kh'
alias df='df -kTh'
alias grep='grep --color=auto'
alias mkdir='mkdir --parents'
alias free='free -h'
alias less='less -r'
# Upagrade distro
alias upgradearch='sudo pacman -Syy && yaourt -Syua --noconfirm'
# Load configs for bash and nvim
alias settings='nvim -O ~/.bashrc ~/.config/nvim/init.vim'
# Load configs for i3 and polybar
alias settingswm='nvim -O ~/.config/i3/config ~/.config/polybar/config'
# Get current IP
alias myip="curl http://ipecho.net/plain; echo"

#                                   Functions

# Extract archive
function extract {
    if [ -z "$1" ]; then
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    else
        if [ -f $1 ] ; then
            case $1 in
                *.tar.bz2)   tar xvjf ./$1    ;;
                *.tar.gz)    tar xvzf ./$1    ;;
                *.tar.xz)    tar xvJf ./$1    ;;
                *.lzma)      unlzma ./$1      ;;
                *.bz2)       bunzip2 ./$1     ;;
                *.rar)       unrar x -ad ./$1 ;;
                *.gz)        gunzip ./$1      ;;
                *.tar)       tar xvf ./$1     ;;
                *.tbz2)      tar xvjf ./$1    ;;
                *.tgz)       tar xvzf ./$1    ;;
                *.zip)       unzip ./$1       ;;
                *.Z)         uncompress ./$1  ;;
                *.7z)        7z x ./$1        ;;
                *.xz)        unxz ./$1        ;;
                *.exe)       cabextract ./$1  ;;
                *)           echo "extract: '$1' - unknown archive method" ;;
            esac
        else
            echo "$1 - file does not exist"
        fi
    fi
}

# config by luke
# 2019-08-25
# My custom config = {{{
alias vi=nvim
alias vim=nvim
alias ra=ranger

export EDITOR=nvim    # default for ranger default editor

# }}}

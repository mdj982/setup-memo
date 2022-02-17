# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

######################################################################

# Linux
alias open=xdg-open

# WSL
function open() {
if [ $# -ne 1 ]; then
    echo "Usage: open [file_name]"
else
    cmd.exe /C start $1
fi
}

# WSL
function nautilus() {
if [ $# -ge 2 ]; then
    echo "Usage: nautilus [directory_name]"
elif [ $# -eq 1 ]; then
    case "$1" in
        /* ) explorer.exe `wslpath -w "$1"`;;
        ~* ) explorer.exe `wslpath -w "$1"`;;
        * ) explorer.exe `wslpath -w "$PWD/$1"`;;
    esac
else
    explorer.exe `wslpath -w "$PWD"`
fi
}

# WSL
function append_winpath_in_lowest_priority() {
    local sbuf=$(cd /mnt/c && /mnt/c/Windows/system32/cmd.exe /c echo %path% | sed -e 's/\r//g' | awk 'BEGIN {FS=";"} { for (i = 1; i <= NF; i++) { printf("\"%s \" ", $i); } }')
    local sresult=$(eval 'for word in '$sbuf'; do wslpath -u "$word" | xargs; done' | tr '\n' ':')
    if [ ${sresult: -1} = ":" ]; then
        sresult=${sresult/%?/}
    fi
    PATH="$PATH:$sresult"
}
# need to run the following command in order to disable automatically include WINPATH
# ````
# sudo bash -c "echo -e '[interop]\nappendWindowsPath = false' >> /etc/wsl.conf"
# ````
# run and unset the function by remove comment out of the following command
# ````
# append_winpath_in_lowest_priority
# unset append_winpath_in_lowest_priority
# ````

# for dualboot
# alias mnt="sudo bash ~/myshell/mnt.sh"

# for paper reading
alias zref="~/myshell/zref"

# include my shells
## - content
## - filename
## - makecpp
## - touchcpp
## - sshgen
## - nautback
## - topps
## - substall
## - whitefmt
## - extractline
## - extractcol[csvfmt/tsvfmt]
## - convertpdf2png[trim]
## - convertpng2jpg
## - dockermnt
## - showlargefile

function myshell() {
    echo -e " content \n filename \n makecpp \n touchcpp \n sshgen \n nautback \n topps \n substall \n whitefmt \n extractline \n extractcol[csvfmt/tsvfmt] \n convertpdf2png[trim] \n dockermnt \n showlargefile"
}

##
function content() {
if [ $# -ne 1 ]; then
	echo "Usage: content [content]"
	echo "cf.    grep \"[content]\" -rl ./"
else
	grep "$1" -rl ./
fi
}

##
function filename() {
if [ $# -ne 1 ]; then
	echo "Usage: filename [partial_filename]"
	echo "cf.    find ./ -maxdepth [depth] -type f -name \"*[partial_filename]*\""
else
	find ./ -type f -name "*$1*"
fi
}

##
function makecpp() {
if [ $# -ne 1 ]; then
	echo "Usage: makecpp [filename_without_extension]"
	echo "cf.    g++ -std=c++1z -O3 -Wall -fopenmp -o test test.cpp"
else
	g++ -std=c++1z -O3 -Wall -fopenmp -o $1 $1.cpp
fi
}

##
function touchcpp() {
if [ $# -ne 1 ]; then
	echo "Usage: touchcpp [filename_without_extension]"
elif [ -e $1.hpp ]; then
    echo "Error: "$1".hpp exists."
elif [ -e $1.cpp ]; then
    echo "Error: "$1".cpp exists."
else
	touch $1".hpp"
	if [ $? -eq 1 ]; then
		return 1
	fi
	touch $1".cpp"
	if [ $? -eq 1 ]; then
    	return 1
	fi
	local basename=${1##*/}
	local UPPERNAME=${basename^^}
	echo -e "#ifndef "${UPPERNAME//-/_}_HPP"\n""#define "${UPPERNAME//-/_}_HPP"\n\n""#endif // "${UPPERNAME//-/_}_HPP >> $1".hpp"
	echo -e "#include \""${basename}".hpp\"" >> $1".cpp"
fi
}

##
function sshgen() {
if [ $# -ne 1 ]; then
    echo "Usage: sshgen [filename_without_extension]"
    echo "cf.    ssh-keygen -t ed25519 -f [filename_without_extension].pub "
else
    ssh-keygen -t ed25519 -f $1
    mv $1 $1.pem
fi
}

##
function nautback() {
if [ $# -ne 1 ]; then
    echo "Usage: nautback [directory_name]"
    echo "cf.    nautilus [directory_name] & > /dev/null "
else
    nautilus $1 & > /dev/null
fi
}

##
function topps() {
if [ $# -ne 1 ]; then
	echo "Usage: topps [process_name]"
else
	local pids=`pgrep $1`
	pids=`echo ${pids} | awk '{ gsub(" ", ","); print }'`
	top -p ${pids}
fi
}

##
function substall() {
if [ $# -ne 2 ]; then
    echo "Usage: substall \"[before]\" \"[after]\""
    echo "cf.    grep [before] \rl ./ | xargs sed -i \"s/[before]/[after]/g\""
else
    local targetfiles=`grep "$1" -rl ./`
    if [ -z $targetfiles ]
    then
        echo "No file has string \"$1\""
    else
        echo "Confirmation: substitution occurs in the following files"
        echo $targetfiles
        read -p "Continue? (y/n): " res
        case "$res" in
        [yY]*)
            echo $targetfiles | xargs sed -i "s/$1/$2/g"; echo "Done.";;
        *)
            echo "Abort.";;
        esac
    fi
fi
}

##
function whitefmt() {
if [ $# -eq 0 ]; then
    echo "Usage: whitefmt [filename]"
    echo "cf.    sed -i -e \"s/[ \\t]*\$//\" [filenames]; sed -i \"\$a\\\" [filenames]"
else
    sed -i -e "s/[ \t]*$//" $*
    sed -i '$a\' $*
fi
}

##
function convertpdf2png() {
if [ $# -eq 0 ]; then
    echo "Usage: convertpdf2png [PDF filenames]"
    echo "cf.    convert -verbose -density 300 -trim [fheader].pdf -quality 100 -flatten -sharpen 0x1.0 [fheader].png"
else
    for fname in $@; do
        local fheader=`dirname ${fname}`/`basename ${fname} .pdf`
        convert -verbose -density 300 -trim ${fheader}.pdf -quality 100 -flatten -sharpen 0x1.0 ${fheader}.png
    done
fi
}

##
function convertpdf2pngtrim() {
if [ $# -eq 0 ]; then
    echo "Usage: convertpdf2pngtrim [PDF filenames]"
    echo "cf.    convert -verbose -density 300 -trim [fheader].pdf -quality 100 -flatten -sharpen 0x1.0 [fheader].png"
else
    for fname in $@; do
        local fheader=`dirname ${fname}`/`basename ${fname} .pdf`
        convert -verbose -density 300 -trim ${fheader}.pdf -quality 100 -flatten -sharpen 0x1.0 ${fheader}.png
        convert -trim ${fheader}.png ${fheader}.png
    done
fi
}

##
function convertpng2jpg() {
if [ $# -eq 0 ]; then
    echo "Usage: convertpdf2pngtrim [png filenames]"
    echo "cf.    convert [fheader].png [fheader].jpg"
else
    for fname in $@; do
        local fheader=`dirname ${fname}`/`basename ${fname} .png`
        convert ${fheader}.png ${fheader}.jpg
    done
fi
}

##
function extractline() {
    if [ $# -eq 0 ]; then
        echo "Usage1: extractline [keywords] < [filename]"
        echo "Usage2: cat [filenames] | extractline [keywords]"
        echo "Note: Use escape sequence in keywords as \"\\\\\\.\""
    else
        printf -v keywords '%s\t' "$@"
        awk -v buf="${keywords::-1}" 'BEGIN {n=split(buf, keys, "\t"); p = 1} {if ($0 ~ keys[p]) {print $0; p = p % n + 1;}}'
    fi
}

##
function extractcol() {
    if [ $# -eq 0 ]; then
        echo "Usage1: extractcol [column numbers] < [filename]"
        echo "Usage2: cat [filenames] | extractcol [column numbers]"
    else
        printf -v columns '%s\t' "$@"
        awk -v buf="${columns::-1}" 'BEGIN {n=split(buf, cols, "\t"); p = 1} {printf $cols[p]; p = p % n + 1; if (p == 1) printf "\n"; else printf " ";}'
    fi
}

##
function extractcolcsvfmt() {
    if [ $# -eq 0 ]; then
        echo "Usage1: extractcolcsvfmt [column numbers] < [filename]"
        echo "Usage2: cat [filenames] | extractcolcsvfmt [column numbers]"
    else
        printf -v columns '%s\t' "$@"
        awk -v buf="${columns::-1}" 'BEGIN {n=split(buf, cols, "\t"); p = 1} {printf $cols[p]; p = p % n + 1; if (p == 1) printf "\n"; else printf ", ";}'
    fi
}

##
function extractcoltsvfmt() {
    if [ $# -eq 0 ]; then
        echo "Usage1: extractcolcsvfmt [column numbers] < [filename]"
        echo "Usage2: cat [filenames] | extractcolcsvfmt [column numbers]"
    else
        printf -v columns '%s\t' "$@"
        awk -v buf="${columns::-1}" 'BEGIN {n=split(buf, cols, "\t"); p = 1} {printf $cols[p]; p = p % n + 1; if (p == 1) printf "\n"; else printf "\t";}'
    fi
}

##
function dockermnt() {
        if [ $# -ne 1 ]; then
        echo "Usage: dockermnt [docker image name]"
        echo "cf.    docker run --gpus all -it -v `pwd`:/`basename \`pwd\`` -w /`basename \`pwd\`` [docker image name]"
        else
        docker run --gpus all -it -v `pwd`:/`basename \`pwd\`` -w /`basename \`pwd\`` $1
        fi
}

##
function showlargefile() {
        if [ $# -ne 1 ]; then
                echo "Usage: showlargefile <depth>"
                echo "cf.    du --max-depth=<depth> -ah ./ | sort -rh | head -n 10"
        else
                du --max-depth=$1 -ah ./ | sort -rh | head -n 10
        fi
}

#*-          Prompt          -*#

# hashing hostname
# hash algorithm which used in function is SDBM algorithm. the original source
# from: http://www.cse.yorku.ca/~oz/hash.html
name=`hostname`
len=${#name}
hsh=0
for (( i=0; i<len; i++ )); do
	ch=${name:$i:1}
	ascii=`printf "%d" "'$ch"`
	eq="$ascii + ($hsh * 64) + ($hsh * 65536) - $hsh"
	# hsh=`echo "$eq" |bc`
	hsh=$(( eq ))
	hsh=$((hsh % 4294967296)) # treat hsh as a unsigned 32-bit integer
done
hsh=$((hsh % 256))

local ret_status="%(?:%{$fg_bold[green]%}? :%{$fg_bold[red]%}? )"
local hostname_color="%{$(printf '\033')[38;5;${hsh}m%}"

PROMPT="${ret_status}%{$reset_color%}%{$bg[white]%}%{$fg[black]%}%D{%H:%M}%{$reset_color%} %B%{$fg_bold[green]%}%n%{$fg_bold[white]%}@${hostname_color}%M%{$reset_color%}:%{$fg[cyan]%}%B%~%{$reset_color%}%b \$(git_prompt_info)"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}*"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

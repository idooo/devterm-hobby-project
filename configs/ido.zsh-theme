if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

PROMPT='%{$reset_color%}%{${fg[green]}%}%3~ $(git_prompt_info)%{${fg_bold[$CARETCOLOR]}%}$CARET_POINTER%{${reset_color}%} '
RPROMPT='$(battery_pct_prompt) %F{yellow}%D{%L:%M} %D{%p}%f'

CARET_POINTER="%{$fg[red]%}❯%{$reset_color%}%{$fg[yellow]%}❯%{$reset_color%}%{$fg[green]%}❯%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

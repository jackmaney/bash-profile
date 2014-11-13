export CLICOLOR=1

function git_prompt() { echo -e $(vcprompt --format="\033[36m%b\033[m \033[34m%r\033[m \033[31;1m%m%a%u\033[m ") ;}

# http://stackoverflow.com/a/20026992
function virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "(venv:$venv) "
}

export VIRTUAL_ENV_DISABLE_PROMPT=1

VENV="\$(virtualenv_info)";

export PS1="${VENV}\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[33;1m\]\w\[\033[m\] \$(git_prompt)$ "

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/local/bin/virtualenvwrapper.sh

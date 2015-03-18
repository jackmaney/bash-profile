export CLICOLOR=1

## pyenv

export PYENV_ROOT=$HOME/.pyenv
export PATH=${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:$PATH

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Get name and hash of the current git repo (if it exists)

function git_prompt() { echo -e $(vcprompt --format="\033[36m%b\033[m \033[34m%r\033[m \033[31;1m%m%a%u\033[m ") ;}

# Get the name of the current version of Python via pyenv.
# Note that this includes virtual environments via pyenv-virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

pyenv_python_version(){
    result=""
    pyenv_version="$(pyenv version-name)";
    if [ -n "$pyenv_version" ]; then
        result="$pyenv_version";
    fi
    [[ -n "$result" ]] && echo "($result) "
}

PYENV_PYTHON_VERSION="\$(pyenv_python_version)";

export PS1="${PYENV_PYTHON_VERSION}\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[33;1m\]\w\[\033[m\] \$(git_prompt)$ "

export CLICOLOR=1

## pyenv

if hash pyenv 2>/dev/null; then
    export PYENV_ROOT=$HOME/.pyenv
    export PATH=${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:$PATH

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Get name and hash of the current git repo (if it exists)

function git_prompt() { echo -e $(vcprompt --format="\033[36m%b\033[m \033[34m%r\033[m \033[31;1m%m%a%u\033[m ") ;}

# Get the name of the current version of Python via pyenv.
# Note that this includes virtual environments via pyenv-virtualenv
export VIRTUAL_ENV_DISABLE_PROMPT=1

pyenv_python_version(){
    result=""
    if hash pyenv 2>/dev/null; then
        pyenv_version="$(pyenv version-name)";
        if [ -n "$pyenv_version" ]; then
            result="$pyenv_version";
        fi
    fi
    [[ -n "$result" ]] && echo "($result) "
}

export PS1="\$(pyenv_python_version)\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h\[\033[33;1m\]\w\[\033[m\] \$(git_prompt)$ "

## Homebrew stuff

export HOMEBREW_GITHUB_API_TOKEN="OldMcDonaldHadAFarmEIEI0"

# This is only necessary to get around a nuisance that isn't so much in Homebrew,
# but in ruby itself:
#
# see https://github.com/Homebrew/homebrew/issues/21679
#
# NOTE: This assumes you have the following environment variables set:
#   http_proxy, HTTP_PROXY, https_proxy, and HTTPS_PROXY.
# Also, this assumes that https_proxy and HTTPS_PROXY point to the same thing.
#
# This function hijacks the `brew` executable, changing the HTTPS proxy to
# HTTP, executing the command as given, and then restoring https_proxy.

brew() {
    https_proxy=${http_proxy}
    command /usr/local/bin/brew "$@"
    https_proxy=${HTTPS_PROXY}
}

### Replace '//' with '/' in path and dedupe
# This Python snippet should work with Python 2.6+, and should be 2 & 3 compatible.

export PATH=$(echo $PATH | python -c 'from __future__ import print_function;\
    import sys,re;\
    path=[re.sub("/+", "/", x.strip()) for x in sys.stdin.read().split(":") if x.strip()];\
    print(":".join([x for i, x in enumerate(path) if x not in path[:i]]))')

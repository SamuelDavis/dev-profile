# EXPORTS
if [ -d '/Applications/Sublime Text.app/Contents/SharedSupport/bin' ]; then
    PATH+=':/Applications/Sublime Text.app/Contents/SharedSupport/bin'
fi
export PATH;
export CLICOLOR=1;

# DEFINITIONS
if [ -x "$(command -v docker)" ]; then
    alias dc="docker-compose";
    alias dssh="docker exec -it";

    function dprune() {
        docker rm --force $(docker ps -aq);
        docker container prune --force;
        docker volume prune --force;
        docker network prune --force;
    }
fi

if [ -x "$(command -v git)" ]; then
    function ref() {
        git branch --no-color 2>/dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\[\1\]/" || return;
    }

    function sha() {
        git rev-parse --short HEAD 2>/dev/null | sed -e "s/\(.*\)/\[\1\]/" || return;
    }
fi

# PROMPT
setopt PROMPT_SUBST;
PROMPT='';
PROMPT+='%F{green}%n@%m%f'; # USER
PROMPT+='%F{yellow}[$(date +%H:%M:%S)]%f'; # DATE
if [ -x $(command -v git) ]; then
    PROMPT+='%F{cyan}$(ref)%f'; # GIT REF
    PROMPT+='%F{magenta}$(sha)%f'; # GIT SHA
fi
PROMPT+='%/'; # PATH
PROMPT+=' %% ';

if [ -f "${HOME}/.zshrc.private" ]; then
    source "${HOME}/.zshrc.private";
fi

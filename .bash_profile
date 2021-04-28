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
    function repo() {
        git remote -v 2>/dev/null | grep 'origin.*fetch' | awk '{print $2}' | sed -e 's/.*\///' -e 's/\.git//' -e 's/\(.*\)/\[\1\]/'
    }
    function ref() {
        git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/' -e 's/\(.*\)/\[\1\]/' || return;
    }

    function sha() {
        git rev-parse --short HEAD 2>/dev/null | sed -e 's/\(.*\)/\[\1\]/' || return;
    }
fi

function colortext() {
    COLOR=${1:-"01;32"}
    TEXT=${2:-"Example Text"}
    echo "\[\033[${COLOR}m\]${TEXT}\[\033[00m\]"
}

# PROMPT
PS1=""
PS1+=$(colortext "32" '\u@\h') # USER
PS1+=$(colortext "33" '[$(date +%H:%M:%S)]') # DATE
PS1+=$(colortext "31" '$(repo)') # GIT REPO
PS1+=$(colortext "36" '$(ref)') # GIT REF
PS1+=$(colortext "35" '$(sha)') # GIT SHA
PS1+=$(colortext "39" ':\w\$ ') # PATH

if [ -f "${HOME}/.bashrc.private" ]; then
    . "${HOME}/.bashrc.private";
fi

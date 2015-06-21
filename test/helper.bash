dir_test=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
dir_sisdi=$(dirname "${dir_test}")

export PATH=$PATH:${dir_sisdi}/bin

test_command_exists() {
    . ~/.bashrc
    hash $1 2>/dev/null && return
    type $1 >/dev/null 2>&1  && return
    command -v $1 >/dev/null 2>&1 && return
    return 1
}
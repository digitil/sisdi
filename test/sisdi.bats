#!/usr/bin/env bats

load helper

setup() {
    tempfile=$(mktemp -t 'tmp.XXXX')
}

teardown() {
    rm -f $dir_sisdi/bin/requires
    rm $tempfile
}

@test "sisdi --version prints semantic version" {
    run sisdi --version

    [ "$status" -eq 0 ]
    expr "${lines[0]}" : '^\([1-9]\{1,2\}\.[0-9]\.[0-9]\)$'
}

@test "install fails on unrecognized option" {
    run sisdi install --unrecognized

    [ "$status" -eq 1 ]
}

@test "install fails if --install-dir not specified" {
    run sisdi install

    [ "$status" -eq 1 ]
}

@test "install fails if --install-dir does not exist or is not a directory" {
    run sisdi install --install-dir /foo/bar
    [ "$status" -eq 1 ]

    run sisdi install --install-dir $tempfile
    [ "$status" -eq 1 ]
}

@test "install provides 'requires' command" {
    ! test_command_exists requires
    
    run sisdi install --install-dir "${dir_sisdi}/bin"

    [ "$status" -eq 0 ]
    test_command_exists requires
}
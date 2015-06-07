#!/usr/bin/env bats

load helper

@test "sisdi --version prints semantic version" {
    run sisdi --version

    [ "$status" -eq 0 ]
    expr "${lines[0]}" : '^\([1-9]\{1,2\}\.[0-9]\.[0-9]\)$'
}
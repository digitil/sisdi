#!/usr/bin/env bats

load helper

setup() {
    sisdi install --install-dir "${dir_sisdi}/bin"
}

teardown() {
    rm -f $dir_sisdi/bin/requires
}

@test "a .sisdi.source file is required to use 'requires'" {
    run sh $BATS_TEST_DIRNAME/example_bad_sisdi_source/test.sh

    [ "$status" -ne 0 ]
    expr "${lines[0]}" : ".*no .sisdi.source file found"
}

@test "local repositories defined with relative paths are validated" {
    cat <<eof > $BATS_TEST_DIRNAME/example_bad_sisdi_source/.sisdi.source
repositories=(
    file://bin
)
eof

    run sh $BATS_TEST_DIRNAME/example_bad_sisdi_source/test.sh
    rm $BATS_TEST_DIRNAME/example_bad_sisdi_source/.sisdi.source

    [ "$status" -ne 0 ]
    expr "${lines[0]}" : ".*invalid repository file://bin"
}

@test "local repositories defined with absolute paths are validated" {
    cat <<eof > $BATS_TEST_DIRNAME/example_bad_sisdi_source/.sisdi.source
repositories=(
    file://$BATS_TEST_DIRNAME/example_bad_sisdi_source/bin
)
eof

    run sh $BATS_TEST_DIRNAME/example_bad_sisdi_source/test.sh
    rm $BATS_TEST_DIRNAME/example_bad_sisdi_source/.sisdi.source

    [ "$status" -ne 0 ]
    expr "${lines[0]}" : ".*invalid repository file://$BATS_TEST_DIRNAME/example_bad_sisdi_source/bin"
}

@test "function can be sourced from a local repository" {
    run sh $BATS_TEST_DIRNAME/example_local_repo/test.sh

    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "hello world" ]
}
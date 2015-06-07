VPATH = lib

install:
	./install_sisdi.sh

test: bats
	$</bin/bats test/

bats:
	git clone --depth 1 --single-branch --branch master git@github.com:sstephenson/bats.git lib/bats
	rm -rf ./lib/bats/.git

.PHONY: install test
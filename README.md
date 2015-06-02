# SISDI is Shell Dependency Injection

**sisdi** makes it easy for developers to share and reuse shell scripts.

Shell scripting is a very powerful part of a developer's toolkit.
And, although shell scripts can be very intuitive and flexible, they can also become unwieldy -- too intricate or complex to effectively manage.
A common solution is to break large shell scripts up into small, easy-to-understand scripts that can be maintained seperately and called upon when needed. 

_sisdi_ wants to be your dependency management and injection system for shell scripts. Inspired by repositories like [Maven][] and [Docker Hub][] and package managers like [npm][], _sisdi_ brings powerful tooling to shell scripting.


## Installing sisdi

You can install/upgrade sisdi using the install script. **Recommended**

    curl install_sisdi.sh | sh 

Or, build it from source by cloning this repository.

    cd sisdi
    make install

Run `sisdi --version` to check the installed version.


## Installing functions locally

There are two places _sisdi_ will look for dependencies -- a `.sisdi_functions` directory within the project or a repository defined in a `.sisdi.source` file.

If you want your script to run without network access, then you want to install functions locally beforehand. 
On the other hand, if you don't mind network access, functions can be easily retrieved from a remote repository. (_repositories can be local as well_)

- - -

A function can be downloaded with the command `sisdi install <function path>`

    sisdi install digitil/argparse

This will create a `.sisdi_functions` directory and download the latest version of the function to that directory.
The "function path" is composed of a contributor or package (e.g. digitil) and the function name. 

All functions in the public repository are scoped by contributor.

- - - 

**Versioning**

You can also specify a function version.

    sisdi install digitil/argparse:1.1

When a function is downloaded, its function path and version will be recorded in the depedencies section of a `.sisdi.source` file in the project root.

- - -

**Managing dependencies manually**

You can manually install/update dependencies defined in .sisdi.source by adding new depenedencies and running `sisdi install` with no arguments.
Dependencies will then be installed or updated accordingly.


## Using a function

```shell

    #!/bin/sh

    # sisdi provides the *import* function
    # use import to require other shell functions in your script
    # the extension need not be specified
    import digitil/argparse

    # use newly imported function as a part of your script
    argparse count=[7] dry-run=[true]

    echo "count = $count"
    echo "dry-run = $dry_run"
```


## Publishing functions

You can publish any directory that has a `.sisdi.source` file.

- - - 

**Authoring**

A shared function should be in a file of the same name. 

```shell
--- argparse.sh

    #!/bin/sh 

    argparse() {
        # TODO
    }
```

- - - 

**Contributing**

To publish a function, you need a contibutor account. 
To create a new account use the `sisdi login` command.
This will also store the account credentials for future use.

Use `sisdi publish` to publish your function. 

To update the version, run `sisdi version major|minor`, then run `sisdi publish` again.

- - -

**Test**

1. Publish your function 
2. Make a new directory with a test script that imports and calls the function
3. Run your script. It should execute successfully



[maven]: https://maven.apache.org/
[npm]: https://www.npmjs.com/
[docker hub]: https://hub.docker.com/
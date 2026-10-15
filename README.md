# test_cicd_repo

A minimal C++17 project for the private wt-cicd-lab runner experiment.
It has no third-party source dependencies.

## Build and test locally

```bash
./build.sh -b -t Release
ctest --test-dir build --output-on-failure --no-tests=error
./build/bin/hello
./build/bin/hello runner
```

Expected output: Hello, world! and Hello, runner!

The tests cover greeting generation, the default executable invocation,
and a custom command-line name.

## CI

The workflow calls the test/wt-cicd-lab branch of the existing
wwjszz/cicd_template repository. It selects the separate self-hosted runner
label wt-cicd-lab, then executes Prepare, Build Release, and Test.

The runner deployment remains in wwjszz/cicd_runner on the same branch name.
On the server, all three checkouts live under /home/wangwenjie/test_dev.

The build container uses the already available image
localhost:5000/cxx_builder_devtoolset_8:1.3.
Coverage, automatic tags, and releases are not enabled in this first exercise.

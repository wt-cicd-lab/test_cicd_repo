# test_cicd_repo

A minimal C++17 project for the wt-cicd-lab runner experiment.
It has no third-party source dependencies.

## Build and test locally

Requirements: a C++17 compiler, Make, and CMake 3.20 or newer.

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

Create both workflows manually from the organization templates in
[wt-cicd-lab/.github](https://github.com/wt-cicd-lab/.github):

1. Open [Actions > New workflow](https://github.com/wt-cicd-lab/test_cicd_repo/actions/new).
2. Add **wt-cicd-lab C++ 开发分支构建** to main.
3. Add **wt-cicd-lab C++ 默认分支打标与归档** to main.
4. The second commit triggers the first tag and artifact workflow.

Other branch pushes run Build Release and Test. Each main push runs Build
Release and Test before creating a tag, then builds RelWithDebInfo and saves
the workflow artifact. Pushes of the generated tags do not trigger these callers.
Create development branches from the latest main so they contain the workflow.
Remove any old cpp-ci.yml caller before installing both new templates.

The reusable implementation remains in wwjszz/cicd_template on branch
test/wt-cicd-lab. It selects the organization runner group lab-runners and
label wt-cicd-lab. Jobs compile directly inside that runner.

Configure CI_SSH_KEY with an SSH private key that can read this repository
and push tags. Grant this repository access to the organization secret and
runner group; allow public repositories in the group.
GITHUB_TOKEN only needs contents: read because tag pushes use SSH.

## Automatic version tags and artifacts

`./build.sh -T` only generates and pushes a version tag; it does not compile.
The initial version is 0.1.0. Subsequent new commits increment the patch
number based on existing numeric version tags: 0.1.1, 0.1.2, and so on.
Running again on an already tagged commit reuses its version.
Use -T alone; it cannot be combined with build or test options.

The artifact is available on the Actions run page. It contains the full
build/ directory as build-output.tar.gz, build-info.txt, and SHA256SUMS.
The binary and static library are compiled with RelWithDebInfo.
GitHub Release publication and coverage are not enabled in this exercise.

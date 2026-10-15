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

Create the workflow manually from the organization template:

1. Open [Actions > New workflow](https://github.com/wt-cicd-lab/test_cicd_repo/actions/new).
2. Select **wt-cicd-lab C++ 构建与测试** and click **Configure**.
3. Confirm the generated branch filters are `main` and commit the workflow to `main`.

The starter template is maintained in [wt-cicd-lab/.github](https://github.com/wt-cicd-lab/.github).
It enables pushes and pull requests targeting the default branch, plus manual runs.
The previous workflow was removed so this template setup can be tested from the UI.

The generated workflow calls the test/wt-cicd-lab branch of the existing
wwjszz/cicd_template repository. It selects the organization runner group
lab-runners and the self-hosted runner label wt-cicd-lab, then executes
Prepare, Build Release, and Test directly inside that runner. The runner image includes GCC/G++, Make, and CMake.

Configure the CI_SSH_KEY Actions secret with an SSH private key authorized
to read this repository. The workflow passes it to the reusable template for
SSH checkout. For an organization secret, grant this repository access.
GitHub Free private repositories need a repository-level secret instead.

The runner deployment remains in wwjszz/cicd_runner on the same branch name.
On the server, all three checkouts live under /home/wangwenjie/test_dev.
Coverage, automatic tags, and releases are not enabled in this first exercise.

The organization group lab-runners must grant this repository access and
allow public repositories. The group can later be shared with more lab repos.

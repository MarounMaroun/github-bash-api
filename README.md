# GitHub Bash API ![Test APIs](https://github.com/MarounMaroun/github-bash-api/workflows/Test%20APIs/badge.svg)

Scripts for the GitHub API in Bash.

This repo aims to expose basic functions for using the [GitHub API](https://developer.github.com/v3/) in Bash.

You can copy any of the functions and use it wherever you want. For example, in your own GitHub action script.

## Usage

Each file aggregates functions that are relevant for the specific API. You can copy-paste whichever function that suits your needs.

For example, the `pull_request.sh` script have functions that expose the [Pull Requests API](https://developer.github.com/v3/pulls/).

You can call whichever function you want from your script. For example, to count the PRs of some repository:

```bash
#!/usr/bin/env bash

source "pull_request.sh"

prs_count <token> <owner> <repo>
```

For commenting on a PR, you should run:

```bash
#!/usr/bin/env bash

source "pull_request.sh"

comment_on_pr <token> <owner> <repo> <pr_num> <comment>
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License ⚖️
[MIT](https://choosealicense.com/licenses/mit/)

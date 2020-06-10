# GitHub Bash API

Scripts for the GitHub API in Bash.

This repo aims to expose basic functions for using the [GitHub API](https://developer.github.com/v3/) in Bash.

You can copy any of the functions and use it wherever you want. For example, in your own GitHub action script.

## Usage

Each file aggregates functions that are relevant for the specific API.

For example, the `pull_request.sh` script have functions that expose the [Pull Requests API](https://developer.github.com/v3/pulls/).

You can test each function by simply calling it inside the file. For example, to get the PRs count in some repository, you can call the `prs_count` function in the `pull_requests.sh` file, and then execute:

```bash
./pull_request.sh <token> <owner> <repo>
```

Which yields the number of PRs for the given repository.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License ⚖️
[MIT](https://choosealicense.com/licenses/mit/)

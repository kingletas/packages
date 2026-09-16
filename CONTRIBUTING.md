# Contributing

Thanks for looking.

## The gate

```bash
make check
```

That builds the repository and installs every release in it. It needs Docker. It's also what the workflow runs before anything is published.

## What a change should look like

- One concern per pull request, with the reasoning in the description.
- `make check` green.
- A change to a check under `bin/` shows it both ways: that it fails on the input it exists to catch, and stays quiet on a good build. **One direction isn't a test.**
- An entry in `CHANGELOG.md` under today's date, saying what changed for somebody installing the modules.
- Comments say what the code does or what it guards against, in a sentence or two. History belongs in the commit message and the changelog.

A problem in a module itself belongs in that module's repository, not here.

## Security

Don't open a public issue for a vulnerability. [SECURITY.md](SECURITY.md) has the reporting route.

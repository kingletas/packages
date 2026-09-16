# Kingletas packages

A Composer repository for the Kingletas Magento 2 modules. Add it to your store once, then require any module by name. Composer finds the modules it depends on by itself.

## Install a module

Add the repository:

```bash
composer repo add kingletas composer https://kingletas.github.io/packages
```

Then require the module you want:

```bash
composer require kingletas/module-section-policy
```

That's it. `module-section-policy` needs `module-foundation`, which needs `module-logger`, and all three arrive together.

If your Composer is too old to have a `repo` command, this does the same as the first step:

```bash
composer config repositories.kingletas composer https://kingletas.github.io/packages
```

Magento's own packages still come from `repo.magento.com`, which your store already has configured.

### If you added the modules one repository at a time

You probably have a `vcs` entry per module in your `composer.json`. They still work, but you had to list every dependency by hand, and Composer reads each repository's history on every update. Swap them for the one entry above:

```bash
composer repo list
```

Remove each `github.com/kingletas/magento2-module-*` entry by the name it shows:

```bash
composer repo remove foundation
```

Then add the `kingletas` repository as above. Composer will warn that the lock file is out of date, because the repository list changed. This clears the warning without changing any version:

```bash
composer update --lock
```

## What's in it

Every module whose repository is public, from its first release under the Kingletas name: `module-logger` from 3.0, every other module from 2.0. Earlier releases were published under a different vendor name and depend on packages that no longer exist, so they are left out rather than offered and then failing to install.

The live list, with every version, is at [kingletas.github.io/packages](https://kingletas.github.io/packages/). [`satis.json`](satis.json) is what decides it.

## How it stays current

The repository is rebuilt on every push here, once a day, and whenever someone runs `make publish`. A new module release is installable within a day, or straight away after `make publish`.

Two things are checked before a build goes live, and a failed check leaves the previous build up:

- **Every release installs.** Each one is required into an empty project and resolved by Composer. Magento's packages are replaced by empty stand-ins for this, so it runs without `repo.magento.com` credentials.
- **Nothing private gets in.** A repository that can't be read without credentials stops the build, whatever token the build has.

A separate job compares `satis.json` with the module repositories that are public on GitHub, and turns red when a public module isn't listed. It doesn't hold back the build.

## Adding a module

1. Make the module's repository public, and tag at least one release.
2. Add its repository and its package name to [`satis.json`](satis.json), with the release floor:

    ```json
    { "type": "vcs", "url": "https://github.com/kingletas/magento2-module-search" }
    ```

    ```json
    "kingletas/module-search": ">=2.0"
    ```

3. Run `make check`.
4. Commit and push. The site rebuilds on the push.

## Running it locally

You need Docker, `jq`, `python3` and `git`. `gh` is optional: when it's signed in, the build borrows its token so GitHub doesn't limit it to 60 requests an hour.

```bash
make check
```

That builds the repository into `local.d/site` and installs every release from it. `make help` lists the rest.

The build writes links for the address it will be served from, which defaults to the `homepage` in `satis.json`. To serve it somewhere else:

```bash
make check REPOSITORY_URL=https://packages.example.com
```

If something fails, each release's project and Composer's full output are in `local.d/check/projects/`.

## Licence

[MIT](LICENSE) for this repository. Each module carries its own licence.

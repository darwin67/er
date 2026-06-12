# Hugo - Er theme

Forked from https://github.com/lingxz/er.

A configurable blog theme for Hugo, with elements inspired by [this blog](https://aranair.github.io/posts/).

Checkout the [demo](https://er-6wj.pages.dev).

## Features

<!-- - produces an Atom feed at `feed.xml`(taken from [this discussion](https://github.com/comfusion/after-dark/issues/32)). It generates the latest 15 posts by default. -->
- Open graph tags
- Tag and category pages
- Table of contents for your posts (from [tocbot](https://github.com/tscanlin/tocbot))
<!-- - Renders Math with KaTeX -->
- Tag cloud on big screens
- Optional Pagefind search
- Styled with TailwindCSS

## Installation

### Git submodule

```sh
git submodule add git@github.com:darwin67/er.git themes/er
git submodule update
```

### Hugo module

``` sh
hugo mod get github.com/darwin67/er
```

## Configurations

### Favicon

You can put your favicon at `static/favicon.ico`, the theme will automatically look for it there. If you want to choose a different path, please set the `favicon` parameter in `[params]` in the config.

<!-- ### Atom feed -->

<!-- In order to enable Atom feed (instead of RSS), put this in your `config.toml`: -->

<!-- ```toml -->
<!-- [outputs] -->
<!-- home = ["HTML", "Atom"] -->

<!-- [mediaTypes] -->
<!-- [mediaTypes."application/atom"] -->
<!-- suffix = "xml" -->

<!-- [outputFormats.Atom] -->
<!-- mediaType = "application/atom" -->
<!-- baseName = "feed" -->
<!-- isPlainText = false -->

<!-- disableKinds = ['RSS'] -->
<!-- ``` -->
<!-- ### Customize the colors -->

<!-- This theme uses TailwindCSS for styling. You can customize the colors by editing the `tailwind.config.js` file in the theme directory. The main colors are defined in the `theme.extend.colors` section. -->

<!-- ### Google analytics -->

<!-- Google analytics tracking code can be added to `config.toml` like this: -->

<!-- ```toml -->
<!-- googleAnalytics = "UA-123-45" -->
<!-- ``` -->

### Markdown TOC

Table of contents is activated by default, if it detects markdown headings. To turn it off, just add `toc = false` in the frontmatter. Alternatively, you can turn off contents page for the whole site by setting `showtoc = false` under the `[params]` section of `config.toml`, like this:
```toml
[params]
showtoc = false
```

<!-- ### Math rendering -->

<!-- Math rendering is off by default, can be turned on for individual posts or pages by setting `math = true` in the frontmatter. -->

### Tag cloud

Tag cloud is shown by default. To disable, add `showTagCloud = false` under the `[params]` section, similar to `showtoc`. You can also configure the maximum number of tags you want to show in your tag cloud, using the `maxTags` key under `[params]`. This number is 50 by default.

<!-- ### Back to top button -->

<!-- Back to top button is also shown by default. To disable, add `showScrollToTop = false` under `[params]`. -->

### Search

Search is disabled by default. To enable the search UI, set `search = true`
under `[params]`:

```toml
[params]
search = true
```

Search uses [Pagefind](https://pagefind.app/), so enabling the UI also requires
your site build to generate and deploy a Pagefind index. Run Pagefind after
Hugo renders the site:

```sh
hugo --minify
pagefind --site public --force-language en
```

Deploy `public/pagefind/` with the rest of `public/`. If `search = true` is set
but `public/pagefind/` is missing, the search assets or index files will 404.

## Development

The preferred development shell is `nix develop`; it provides Hugo, Pagefind,
Tailwind, Go, and release tooling.

To run the demo site from the repository root:

```sh
make dev
```

To modify the theme styles:

1. Run `make dev` from the repo root
2. Run `make css-watch` from the repo root to rebuild CSS live as the demo
   templates change

To test search locally in the demo, build the demo site, generate its Pagefind
index, and serve the generated `demo/public/` directory with any static file
server:

```sh
cd demo
hugo -b http://127.0.0.1:4173/
pagefind --site public --force-language en
python3 -m http.server --directory public 4173
```

`hugo server` does not create a fresh Pagefind index. At the theme root,
`make build` runs `pagefind --site public --force-language en` after Hugo and
writes `public/pagefind/` for the root fixture.

## Releases

Pull request titles must use Conventional Commits. The release workflow uses
git-cliff to derive the next semver tag from conventional commit history:

- `feat`: minor release
- `fix` and most other included types: patch release
- breaking changes marked with `!` or `BREAKING CHANGE`: major release

Merges to `main` create or update a `release/next` pull request with a generated
`CHANGELOG.md` entry. Merging that release PR creates a `vX.Y.Z` tag and
publishes a GitHub release.

The release workflows require a private GitHub App installed on this repository
with `Contents: write` and `Pull requests: write` permissions. Store its app ID
and private key as repository secrets named `RELEASE_APP_ID` and
`RELEASE_APP_PRIVATE_KEY`. The release PR workflow intentionally does not use
the default `GITHUB_TOKEN` for release branch pushes because events created with
that token do not trigger normal downstream workflow runs.

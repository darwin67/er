# Hugo - Er theme

Forked from https://github.com/lingxz/er.

A configurable blog theme for Hugo, with elements inspired by [this blog](https://aranair.github.io/posts/).

Checkout the [demo](https://er-6wj.pages.dev).

## Features

<!-- - produces an Atom feed at `feed.xml`(taken from [this discussion](https://github.com/comfusion/after-dark/issues/32)). It generates the latest 15 posts by default. -->
- Open graph tags
- Tag and category pages
- Collapsible table of contents at the top of each post (built from Hugo's native `.TableOfContents`)
- Light and dark mode with a `clay` (warm-earth) or `nord` (arctic) color palette
<!-- - Renders Math with KaTeX -->
- Tag cloud on big screens
- Hugo multilingual sites
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

### Projects

The theme ships a `projects` content type for case studies / portfolio
work, with a dedicated single-page layout, a grid list, and an optional
"Featured work" block on the homepage. Drop projects under
`content/projects/` (either single markdown files or page bundles when
you have a cover image + gallery).

The homepage featured block is **opt-in**:

```yaml
params:
  showFeaturedProjects: true
```

It surfaces up to 3 projects whose frontmatter sets `featured: true`,
and renders nothing if none match — so flipping the param on without
any featured content is also safe.

Frontmatter schema (all fields optional except `title` and `date`):

```yaml
---
title: "Acme rebuild"
date: 2025-03-12

role:     "Lead engineer"
client:   "Acme Co"            # omit for personal work
period:   "2024 – 2025"
stack:    [go, postgres, terraform]

repo:     "https://github.com/you/acme"
live_url: "https://acme.example"

status:   "shipped"            # shipped | wip | archived
cover:    "cover.jpg"          # relative to the page bundle
summary:  "Rebuilt the order pipeline; cut p99 latency by 38%."

featured: true                 # surface on the homepage
---
```

Helpful shortcodes inside a project page:

- `{{< gallery >}}` — responsive image grid with lightbox.
- `{{< results >}} ... {{< /results >}}` — metric strip at the top of
  a case study.

Stacks are a real Hugo taxonomy, so `/stacks/rust/` etc. work out of
the box.

### Color palette

The theme ships with two color palettes. Both support a light and dark mode
(the visitor's choice is respected via the moon/sun toggle and persisted in
`localStorage`).

| Palette | Vibe |
|---------|------|
| `clay`  | Warm-earth terracotta + sage. Default. |
| `nord`  | Arctic Snow Storm (light) / Polar Night (dark). |

Pick one in your site config:

```yaml
params:
  palette: nord
```

If unset, the site uses `clay`.

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

### Multilingual sites

The theme supports Hugo multilingual sites. Define languages in the importing
site config, not in the theme:

```yaml
defaultContentLanguage: en
languages:
  en:
    locale: en-US
    label: English
    weight: 1
  ja:
    locale: ja-JP
    label: 日本語
    weight: 2
```

The theme uses each rendered page's language for `<html lang>`,
language-aware navigation URLs, taxonomy links, and the language switcher. The
language switcher is shown when Hugo renders more than one language site, which
the theme detects with `len hugo.Sites > 1`.

Add translated fixed UI strings by overriding the theme's `i18n/*.yaml` keys in
your site.

For example, to change the default English search label, create
`i18n/en.yaml` in your site:

```yaml
search:
  other: Find
searchPlaceholder:
  other: Find something...
olderPosts:
  other: Earlier
newerPosts:
  other: Later
```

Site-level i18n files take precedence over the theme defaults. Override only
the keys you want to phrase differently.

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
pagefind --site public
```

Deploy `public/pagefind/` with the rest of `public/`. If `search = true` is set
but `public/pagefind/` is missing, the search assets or index files will 404.
For multilingual sites, do not pass `--force-language`; Pagefind reads the
rendered `<html lang>` values and creates language-specific indexes.

## Development

The preferred development shell is `nix develop`; it provides Hugo, Pagefind,
Watchexec, Tailwind, Go, and release tooling.

To run the demo site from the repository root:

```sh
make dev
```

This builds the demo into `demo/public/`, rebuilds its Pagefind index, and then
starts Hugo's live-reload server at `http://127.0.0.1:1414/`. While the server
runs, a file watcher refreshes `demo/public/pagefind/` after content, template,
asset, or config changes.

To modify the theme styles:

1. Run `make dev` from the repo root
2. Run `make css-watch` from the repo root to rebuild CSS live as the demo
   templates change

At the theme root, `make build` runs `pagefind --site public` after Hugo and
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

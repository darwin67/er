# Agent Guide

This file provides guidance to AI coding agents working in this repository.

## Commit Titles

Use conventional commit titles for any commit you create. This repository's
changelog configuration in `cliff.toml` enables conventional commit parsing, and
the PR workflow validates conventional commit titles.

Prefer these commit types because they are grouped or validated today:

- `feat`
- `fix`
- `doc`
- `docs`
- `perf`
- `refactor`
- `style`
- `test`
- `chore`
- `ci`
- `revert`
- `security`

Use standard conventional commit formatting such as `fix(feed): support Hugo
0.162` or `ci(release): align changelog tag validation`.

## Development Commands

### Environment

- `nix develop` enters the preferred development shell. It provides Hugo, the
  Tailwind v4 standalone CLI, Go, and `git-cliff`. There is no Node toolchain.

### Building

- `make css` regenerates `assets/css/main.css` from `assets/css/app.css`.
- `make css-watch` rebuilds CSS on change.
- `make build` regenerates CSS and runs `hugo --minify`.
- `make serve` runs `hugo server --disableFastRender`.
- `hugo --minify` builds the root theme fixture without regenerating CSS.
- From `demo/`, `hugo -b http://example.test` builds the demo site.

### Release Tooling

- `git-cliff --config cliff.toml --bumped-version` previews the next semver
  version.
- Release tags and changelog headings are expected to use the `vX.Y.Z` form.

## Project Structure

This repository is a Hugo theme with Tailwind CSS styling.

- `layouts/` contains Hugo templates and partials.
- `assets/css/app.css` is the Tailwind source.
- `assets/css/main.css` is generated CSS that is committed to the repo.
- `static/` contains static CSS and JavaScript assets.
- `config/_default/hugo.yaml` contains theme-level Hugo configuration.
- `demo/` contains a demo Hugo site that imports this theme.

## Working Style

- Prefer minimal, targeted changes that preserve the existing style.
- Run relevant checks for the area you touch when practical.
- Commit in small logical chunks. Each commit should be self-reviewable and
  contain one coherent change with its relevant tests or docs.
- Do not introduce a second commit-title convention; keep commit types aligned
  with `cliff.toml` and `.github/workflows/commits.yml`.
- Add comments only when they describe intent for non-obvious logic,
  compatibility constraints, workarounds, or safety guardrails.
- Keep comments succinct and useful for review.

## Generated Assets

Treat generated assets deliberately:

- If you change `assets/css/app.css` or Tailwind-related markup, regenerate
  `assets/css/main.css`.
- If generated CSS changes unexpectedly, inspect the diff before committing.
- Preserve the explicit Tailwind `@source inline(...)` entries unless you have
  confirmed the corresponding generated utilities are no longer needed.

## Verification

Useful checks before finishing work:

- `nix develop -c make css`
- `git diff --exit-code -- assets/css/main.css`
- `nix develop -c hugo --minify`
- From `demo/`: `nix develop .. -c hugo -b http://example.test`
- `ruby -e 'require "yaml"; Dir[".github/workflows/*.yml"].each { |f| YAML.load_file(f) }'`
- `nix develop -c git-cliff --config cliff.toml --bumped-version`

---
title: "notes-cli"
date: 2025-09-04
role: "Solo"
period: "2025 –"
stack: [rust, sqlite]
repo: "https://github.com/example/notes-cli"
status: wip
summary: "Local-first plain-text notes CLI with full-text search and tagging."
---

A small command-line notes tool I'm building to replace the patchwork
of `~/notes/` markdown files I've been carrying between machines.

## Why another notes tool

Most notes apps either lock content into a proprietary store or require
a sync server. I want plain `.md` files on disk and an opt-in FTS index
that I can rebuild from scratch any time.

## Status

Early; the storage layer and basic CRUD work, FTS is wired through but
not exposed in the CLI yet. Not yet packaged for distribution.

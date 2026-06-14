---
title: "Mermaid Diagrams in Markdown"
date: 2025-10-12
tags:
  - mermaid
  - diagrams
  - markdown
categories:
  - documentation
description: "Flowcharts and sequence diagrams rendered from fenced Mermaid blocks."
---

Mermaid diagrams can live beside prose as ordinary fenced code blocks. The
theme loads Mermaid only when a page contains at least one diagram.

## Publishing workflow

This flowchart shows a small documentation pipeline:

```mermaid
flowchart LR
    A[Write Markdown] --> B{Preview locally}
    B -->|Needs work| A
    B -->|Looks good| C[Build with Hugo]
    C --> D[Deploy site]
```

## Request lifecycle

Sequence diagrams are useful for documenting interactions between services:

```mermaid
sequenceDiagram
    actor Reader
    participant Browser
    participant HugoSite as Hugo site
    Reader->>Browser: Open an article
    Browser->>HugoSite: Request generated page
    HugoSite-->>Browser: Return HTML
    Browser->>Browser: Render Mermaid diagram
    Browser-->>Reader: Display the article
```

The same blocks follow the selected light or dark color palette.

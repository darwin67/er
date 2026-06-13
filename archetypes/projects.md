---
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
date: {{ .Date }}
draft: true

# Project metadata — surfaced in case-study meta sidebar and listings.
role:        ""           # e.g. "Lead engineer"
client:      ""           # e.g. "Acme Co" — omit for personal work
period:      ""           # e.g. "2024 – 2025"
stack:       []           # e.g. [go, postgres, terraform]

# Links — both optional; rendered as icon badges when set.
repo:        ""           # https://github.com/...
live_url:    ""           # https://...

# Status drives the dot indicator: shipped | wip | archived.
status:      "shipped"

# Cover image (relative to the page bundle or static path) and one-line
# summary used in list/grid views.
cover:       ""
summary:     ""

# Set true to surface this project on the homepage featured-work block.
featured:    false
---

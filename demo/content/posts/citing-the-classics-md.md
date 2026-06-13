---
title: "Citing the classics (Markdown)"
date: 2025-10-04
tags: [meta, demo, footnotes]
categories: [tutorials]
---

This post demonstrates the theme's footnote treatment. The inline marker
is a bracketed superscript number like Wikipedia or a research paper[^donald],
and each note carries a back-link `↩` that returns you to the spot you were
reading.

Repeat citations are supported in Markdown: cite the same source twice and
Hugo emits two separate `fnref` anchors, with one back-link per use on
the note itself[^donald]. Clicking either back-link returns to the
matching site.

Long-form notes work too[^observation], including emphasis, links, and
multi-sentence prose. The note body sits in the footnotes block at the
bottom of the post, separated by a thin rule and labelled "Notes".

Try this: click `[1]` above, then click the `↩` next to "Knuth (1974)".
Notice the brief background flash on the target — that's pure CSS using
`:target` and the theme's `--color-background-alt`, so it works in both
light and dark mode without JS.

[^donald]: Knuth, D. E. (1974). "Structured Programming with go to
    Statements." *Computing Surveys*, 6(4), 261-301. The original
    citation of "premature optimization is the root of all evil."

[^observation]: This page also exercises the theme's other typography
    bits — the prose measure stays at ~65ch, but the footnotes block
    follows the same narrow measure rather than expanding to the wider
    canvas reserved for code and figures. That makes notes feel like
    part of the reading column rather than a separate widget.

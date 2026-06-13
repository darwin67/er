---
title: "Pasta Pipeline"
date: 2025-03-12
role: "Lead engineer"
client: "Trattoria della Nonna"
period: "2024 – 2025"
stack: [go, postgres, terraform, kafka]
repo: "https://github.com/example/pasta-pipeline"
live_url: "https://pasta.example"
status: shipped
cover: "ingredients.jpg"
summary: "Rebuilt the order pipeline end-to-end; cut p99 latency from 3.2s to under a second."
featured: true
tags: [backend, distributed-systems]
---

{{< results >}}
38%|p99 latency reduction
3x|deploys per week
2.1k|orders/min sustained
{{< /results >}}

## Background

The legacy order system was a single monolith with a synchronous write
path and no clear observability story. Every Saturday at the dinner
rush, p99 spiked above three seconds and the on-call rotation tightened.

## What we did

We split the hot write path off into a streaming pipeline anchored on
Kafka, with idempotent consumers writing to Postgres. The rest of the
monolith stayed put; only the latency-sensitive surface was rebuilt.

```go
func (s *Server) HandleOrder(w http.ResponseWriter, r *http.Request) {
    order, err := decode(r.Body)
    if err != nil { http.Error(w, "bad request", 400); return }
    if err := s.producer.Publish(r.Context(), order); err != nil {
        http.Error(w, "queue down", 503); return
    }
    w.WriteHeader(202)
}
```

## Outcomes

- p99 latency cut by 38% with headroom for 3x growth.
- The Saturday-night pager went silent within two weeks of cutover.
- New consumers (analytics, reporting) plug into the same stream
  without touching the order surface.

{{< gallery >}}

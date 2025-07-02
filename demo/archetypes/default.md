---
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
date: {{ .Date }}
draft: true
uuid: {{ hash.FNV32a (printf "%s%d" .File.Filename now.UnixNano) }}
category:
tags: []
---

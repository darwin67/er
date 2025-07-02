---
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
date: {{ .Date }}
draft: true
uuid: {{ crypto.FNV32a (printf "%s%d" .File.Filename now.UnixNano) }}
category:
tags: []
---

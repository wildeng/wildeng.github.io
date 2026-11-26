---
layout: blog
title: "In italiano"
locale: it
permalink: /it/
pagination:
  enabled: true
  locale: it
  permalink: '/page/:num/'
  title: ' - pagina :num'
---

Uno spazio in cui raccolgo articoli e riflessioni
su informatica, fotografia, tecnologia e altro ancora.

{% assign posts = site.posts | where: "locale", "it" %}

{% for post in posts %}
- [{{ post.title }}]({{ post.url | relative_url }})
  — {{ post.date | date: "%d/%m/%Y" }}
{% endfor %}

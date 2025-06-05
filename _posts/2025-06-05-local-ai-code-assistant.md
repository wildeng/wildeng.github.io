---
layout: post
author: Wildeng
2024: 2025-06-05
title: Local ai code assistant
---

#### Disclaimer: Because the README file of this project is good, I decided to duplicate it here too.

## Build your personal code assistant

This is a personal experiment to explore whether it's possible to build a local, offline-first code assistant on top of an open-source language model.

The assistant maintains context in a `JSON` file, which is updated with each interaction — allowing the model to pick up where it left off.

## Problem Context

This started because I didn’t want to rely on commercial products like GitHub Copilot, nor be dependent on an internet connection. I wanted something that works even on a train or plane.
The second constraint is about my development environment. I'm a [Lunarvim](https://www.lunarvim.org) user and occasionally use [Neovim](https://neovim.io), so my goal was to first create something pluggable in `Lunarvim` and then adapt it for use in plain `Neovim`.
The third constraint was focusing on the programming language. I'm mainly `Ruby` developer and occasionally `Python` so I've started by focusing on these two only.

## How it Works (High-level)

- Lua plugin captures code context from the buffer
- Lua calls Python script, passing selected code (or surrounding context)
- Python script prompts the model via Ollama and returns code suggestions
- Suggestions are rendered in a floating window (markdown) or inline (ghost text)

## Draft Implementation

To make the agent run I had to do two things first:

- Install [Ollama](https://github.com/ollama/ollama) and pull my model of choice [Deepseek Coder 1.3b](https://huggingface.co/deepseek-ai/deepseek-coder-1.3b-instruct). The code is general enough to be used with other models, depending on your machine available resources.
- To keep stuff segregated I created a `Python` environment where all the libraries should be installed. It's not strictly necessary though.

The first iteration is the `get_suggestions.py` and `ai_assistant.lua`. These two work together as follows:

- `ai_assistant.lua` digests what's been selected in the current buffer and passed to it. It then calls `get_suggestions.py` which returns a markdown formatted suggestion for the selected code and displays everything in a floating window.
- I then added some line to my `Lunarvim` configuration file to trigger the process:

```lua
-- Keymap to trigger the AI assistant
lvim.keys.visual_mode["<leader>ai"] = ":<C-U>lua require('ai.ai_assistant').run_code_assistant()<CR>"
```

The second iteration is more close to what I had in mind and is made up by two other files `inline_suggest.lua` and `get_inline_suggestions.py`.

- `inline_suggest.lua` gets the position of the cursor and the context around it by going back 100 lines and forward 20. It then calls the `get_inline_suggestions.py` and displays the results using "virtual text" or "ghost text".
- `get_inline_suggestions.py` is much simpler than the previous one and tries to instruct the model by using a prompt  designed to keep the model concise and avoid excessive commentary. What I need is the code only, without comments or other kind of suggestions.

To call this last bit I added to my config the following lines

```lua
vim.o.updatetime = 500  -- 500 ms (you can tweak this)
vim.api.nvim_create_autocmd("CursorHold", {
  pattern = { "*" },
  callback = function()
    require("ai.inline_suggest").run()
  end,
})
```
This creates an auto command that triggers when the cursor is idle for 500ms and interrogates the model.

This is just a basic idea and a work in progress. My hope is to finally have a product that works well enough for my purposes and that can let me use these new technologies without being to0 dependent on the big corporations.

## What’s Next
- Support for more languages
- Configurable context window size?
- Automatic memory/context trimming?
- Model fine-tuning (eventually?)

---

#### Things I like - in random order ####

Experimenting with colours:
<br/>
<img class="post-image"  src="https://pxscdn.com/public/m/_v2/424813098022428933/4f692c7f1-e20d1b/uGQzULFTPkrW/F6CAF7vfAQMVvObfZIc4eNbfogHxTTR6YODmYhn2.jpg" loading="lazy" alt="The image captures a quiet urban scene on a bright day. In the foreground, delicate cherry blossoms frame the view, their pale petals glowing warmly in the light. A white car is parked in an almost empty lot, while a cyclist wearing a helmet rides along a path beside the trees. Behind them, tall buildings rise — a red brick one to the left and a modern glass tower to the right. The sky is striking, a surreal mix of turquoise and violet tones, adding a dreamlike mood. The street is calm, evoking a peaceful, almost cinematic pause in the city.">
<br/>
<br/>
Experimenting with cinematic style:
<br/>
<img src="https://pxscdn.com/public/m/_v2/424813098022428933/4f692c7f1-e20d1b/8lMIcI8Kc88G/2mYqpFXjqPEPYodAmWVyVJ5OYWfq7q0ZnA05xx2W.jpg" loading="lazy" alt="A young person in dark clothing crosses a quiet city street beneath a pale, overcast sky. To the left, a brick building marked &quot;BBC Radio Sheffield&quot; stands beside a street sign and a tall clock. Straight ahead, a faded beige building is covered in graffiti, with bare trees and empty benches nearby. Traffic lights show green, but only a few people are visible—two figures walking away on the right pavement, and a few distant cars. The scene feels still and contemplative, with muted colors and cinematic black bars above and below, adding a sense of framing and introspective distance." width="1770" height="1080" onerror="this.onerror=null;this.src='/storage/no-preview.png'" class="post-image">
<br/>

---

#### Today's Links ####

Nintendo Switch 2 is the upgrade of my dreams [The Guardian](https://www.theguardian.com/games/2025/jun/03/nintendo-switch-2-release-mario-kart-world)  

As usual corporate greed is at the base of this race to deploy AI agents:

>Make no mistake: We've talked to scores of CEOs at companies of various sizes and across many industries.
Every single one of them is working furiously to figure out when and how agents or other AI technology can displace human workers at scale.
The second these technologies can operate at a human efficacy level, which could be six months to several years from now, companies will shift from humans to machines.

Dario Amodei on the future of AI and the job market [Behind the Curtain: A white-collar bloodbath](https://www.axios.com/2025/05/28/ai-jobs-white-collar-unemployment-anthropic)

20 years ago [Postcrossing](https://www.postcrossing.com/20years/meetups) was started. You should get into it, it's fun!!


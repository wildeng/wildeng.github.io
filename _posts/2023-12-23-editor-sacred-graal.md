---
layout: post
author: Wildeng
title: The Sacred Graal of Editors  
---

In my last post I said that I wanted to be more technical and so be it. But in a different way and not "so technical": I won't talk about classes, methods, modules, mixin or some other Ruby related stuff. I'm going to write about my journey in search of my "almost perfect" editor.

<img align="left" src="https://twobithistory.org/images/c64_startup.png" class="post-image align-post-image" alt="a commodore 64 shell" />  When I started doing some programming there wasn't much of a choice. The C64 was offering one type of editing mode and nothing more so I didn't bother much about it and the
same happened while in high school, [Olivetti M24](https://en.wikipedia.org/wiki/Olivetti_M24) and [Olivetti M240](https://classic.technology/wp-content/uploads/2021/10/olivettim240german.pdf) had some really simple text editors not that different from C64 shell. In the end I got used to it and this probably why
I still find myself comfortable using the command line.
Not much to say about university years. I was studying electronics and not coding much. I also didn't have a computer at home so I was using whatever was present on the University computers, from [JBuilder](https://en.wikipedia.org/wiki/JBuilder) to Notepad or [Notepad++](https://en.wikipedia.org/wiki/Notepad%2B%2B).

When I started professionally as a web developer, the first company I worked for was using ASP and provided me a desktop equipped with [VisualInterDev](https://en.wikipedia.org/wiki/Visual_InterDev). The company then went bankrupt and I moved to another one where I really learned web development from scratch. Starting out with HTML/CSS and then, at the time, the next natural step was PHP. I then started developing with Java so I moved from [PHPEdit](https://en.wikipedia.org/wiki/PHPEdit) to [Eclipse](https://www.eclipse.org/downloads/) that became my preferred choice for both languages. Given the type of work required by the company, I also started getting used to FreeBSD servers and [Vim](https://www.vim.org) as an editor for configuration files and small shell scripts.  
At that time I was freelancing and sometimes I had to code with programming languages chosen by the customer and thus the IDE choice by was not under my control. The list is long and I won't mention all of them, just that that I had to use Delphi and PL/SQL :sweat: 

The real change happened when I did two things after I've started working with a company building a web application using Ruby on Rails: I adopted Ubuntu as-my-day to day OS and started using [Aptana RadRails](https://github.com/aptana/studio3). Being that a small startup we also had to do some system administration on Ubuntu servers so Vim was the standard choice. However, those early version of Ubuntu weren't that "user friendly" so I had frequently to use the command line and edit files. Constantly switching between editors became tiresome so I started looking for a more flexible alternative and while reading a book about early open source movement contributors, I've noticed that many of them were using [Emacs](https://en.wikipedia.org/wiki/Emacs), so I've installed it and started using it.
The beginning was hard, I had to learn all the basic concepts, how to navigate and edit files and more how to configure it for my purposes. But once I digested all this preliminary information and started getting used to it, the experience was highly satisfactory. I also discovered [Tmuxinator](https://github.com/tmuxinator/tmuxinator), a Ruby Gem that makes [Tmux](https://en.wikipedia.org/wiki/Tmux) session management easier, and using it together with Emacs was absolutely dope! I was finally able to configure my development environment in such a way that I could have different Tmux sessions opened for different projects with all that I need already in place.

That should have been my sweet spot; however, since I was still doing some sysadmin work, most of the times Vim was the only available editor and I then decided after 4 years of Emacs to finally move to [Lunarvim](https://www.lunarvim.org), a [Neovim](https://neovim.io) based editor which comes by default with a lot of nice features. The only thing I had to configure was the code completion and the Golang support.

The search for my 'Sacred Graal of Editors' has been driven by my inherent laziness. I don't want to change much some of my daily routines and constantly switching between IDEs while using different programming languages and while editing configuration files on some remote server was making me less productive. At the end what we need is a well ingrained muscle memory that keeps us productive and helps us getting the job done. Vim is ubiquitous and can be found in all Unix-like systems which means that I can just sit down and start coding.

At the end what makes difference is how comfortable are with your tools. If you prefer a comprehensive IDE that takes care of all the aspects of a developer's workflow, just use it. IDEs will continue to improve, but I will persist with my tools, which may appear antiquated to some, but if you're still trying to find your preferred editor, give Vim or Emacs a try, you won't regret it.

Note: This post has been entirely written and edited on Lunarvim <img src="/images/downhand.gif" alt="a gif of a hand pointing down" />

<img src="/images/lunarvim.png" class="post-image" alt="lunarvim welcome screen" />

---

#### Things I like - in random order ####

Perseverance's 360 view from Airey Hill - Original [here](https://mars.nasa.gov/resources/27844/perseverances-360-degree-view-from-airey-hill/?utm_source=iContact&utm_medium=email&utm_campaign=nasas-mars-public-engagement-team&utm_content=20231220-MarsNewsletter-A)
<br/>
<img src="/images/perseverance-airey-hill.jpg" alt="a 360 degrees of airey hill taken from perseverance mars rover" class="post-image"/>
<br/>
<br/>
My Christmas tree - picture taken using one of Hipstamatic lenses 
<br/>
<img src="/images/christmas-tree.jpeg" alt="the christmas tree in my living room with a instant camera filter" class="post-image"/>
<br/>

---

#### Today's Links ####

Apple explores A.I. deals with some news publishers [N.Y. Times](https://www.nytimes.com/2023/12/22/technology/apple-ai-news-publishers.html)

Britain is an 'omni-surveillance society' [The Guardian](https://www.theguardian.com/uk-news/2023/oct/29/britain-omni-surveillance-society-watchdog-warns?utm_term=658531d6070054b93415af41a0313739&utm_campaign=FirstEdition&utm_source=esp&utm_medium=Email&CMP=firstedition_email)

Police to be able to run [facial recognition](https://www.theguardian.com/technology/2023/dec/20/police-to-be-able-to-run-face-recognition-searches-on-50m-driving-licence-holders)

Building Future Mars [Helicopters](https://mars.nasa.gov/news/9513/nasa-uses-two-worlds-to-test-future-mars-helicopter-designs/)

Introducing Solid Queue - A DB-based queuing [backend](https://dev.37signals.com/introducing-solid-queue/)  

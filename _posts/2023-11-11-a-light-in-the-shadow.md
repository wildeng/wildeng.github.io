---
layout: post
author: Wildeng
date: 2023-11-11
title: A Light in the Shadow
---

The past week at work has been quite nice from a personal perspective. I've delivered a couple of nice cool features and sorted out an interesting bug.
I cannot say much about the contest but I'm working in a software company that creates tools for professional sport teams and we deal with games and periods. We thus had the following problem: After creating a game with a certain duration and a certain number of periods, the UI was always displaying 90 minutes and 2 periods of 45 minutes.
<br/>
<img src="/images/boyhack.gif" alt="gif of a boy furiously typing on a computer keyboard seen by the back">
<br/>
So I started tracing down the bug and found the cause: A case of variable shadowing. 

But what is variable shadowing? According to [wikipedia](https://en.wikipedia.org/wiki/Variable_shadowing) variable shadowing occurs when a variable declared within a certain scope has the same name of the variable in the outer scope leading to some possible confusion about which one of the two is used. An example of this similar to the code I had and one that you can try in `irb` - open the terminal and type [irb](https://rubyreferences.github.io/rubyref/intro/irb.html) - is:

A case with variables
```ruby
irb(main):069:0> x = 0
=> 0
irb(main):070:1* def shadow
irb(main):071:1*   x = x || 1
irb(main):072:1*   puts x
irb(main):073:0> end
=> :inner
irb(main):074:0> shadow
1
```
<br/>
And a case with methods
```ruby
irb(main):059:1* class Baz
irb(main):060:2*   def bar
irb(main):061:2*     "bar"
irb(main):062:1*   end
irb(main):063:2*   def shadow
irb(main):064:2*     bar = bar || 21
irb(main):065:2*     puts bar
irb(main):066:1*   end
irb(main):067:0> end
=> :shadow
irb(main):068:0> Baz.new.shadow
21
```

but hey, why is this happening? To put it in simple terms, the local variable is created during parsing time and not during the code execution when the assignment really occurs. This means that you can't access the outer variable because you have defined a local one with the same name. Remember, this could also happen to methods too, as you can see from one of the examples. Nice uh?  
Scary? No, not at all! There are many programming languages where variable shadowing can happen, such as Python, Rust, Go etc. so be aware of it and take your own precautions. 

<br/>
##### Further readings and sources: #####
[The curious incident of the Shadow in the Runtime](https://www.paulfioravanti.com/blog/curious-incident-shadow-run-time/) where you can find some other interesting links.  
Local variables and methods: [Ruby Docs](https://docs.ruby-lang.org/en/2.4.0/syntax/assignment_rdoc.html#label-Local+Variables+and+Methods)

---

#### Things I like - in random order ####

Even though I don't think about myself as a "hard" sporty person - I do sport, mostly to try to keep up a bit my fitness level and indulge with some food treats :smile: - I really enjoy watching live sport events  and here are my favourite ones

- Volleyball - I've played and coached volleyball for a total of more than 30 years.... 
- Football - Just remember that there's no such thing called soccer :wink:
- Basketball - Given the age I now play walking basketball 
- Rugby - both Union and League. Fun fact about this: Not being a rugby conosseur I didn't know the difference betwen them until when we moved to Sheffield we were looking for a rugby team that they could have joined (this was their sport back in Italy) and we found a local one, Sheffield Hawks. After a couple of training sessions we've been invited to assist a pro rugby game from the local team Sheffield Eagles and at the first tackle they stopped, set the defense and offense lines and started again. Well, I turned to a man next to me and asked "Is this a particular kind of foul?" and this man kindly told me "This is rugby league NOT UNION!" - :rofl: 

There's been a lot of criticism around the last Beatles song, but I like it, so who cares? [Now And Then](https://youtu.be/Opxhh9Oh3rg?si=Q12a1NWKn4ei5uiE)

Sheffield has some stunning views, this is one that I took from the [Bole Hills](https://en.wikipedia.org/wiki/Bolehill_Recreation_Ground)
<figure>
<img src="/images/bole_hills.jpeg" alt="view of the neighborough of Stannington in Sheffield as seen from the bole hills park" class="post-image">
</figure>
<br/><br/>
Here is one that I took from the back of Bradfield School in [Worrall](https://en.wikipedia.org/wiki/Worrall)
<figure>
<img src="/images/worrall.jpg" alt="view of the countryside around worrall as seen from the back of bradfield school" class="post-image">
</figure>

---

#### Today's Links ####

Gemini Project [Going Dark](https://cheapskatesguide.org/articles/gemini.html)

Ruby delights built into the language [no gems needed](https://technology.doximity.com/articles/ruby-delights-built-into-the-language)

The secret life of [Josephine Baker](https://podcast.duolingo.com/episode-96-the-secret-life-of-josephine-baker-josephine-la-danseuse) a Duolingo podcast

C64 [Programming Reference Guide](https://www.commodore.ca/commodore-manuals/commodore-64-programmers-reference-guide/)

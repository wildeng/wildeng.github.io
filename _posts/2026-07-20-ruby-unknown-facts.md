---
layout: post
author: Wildeng
2024: 2026-07-20
title: Ruby Hidden Gems
---

Ruby is a beautiful and expressive language that gives developers a great deal of flexibility. Along with that flexibility come a number of lesser-known language features that can sometimes produce surprising results.

Let's have a look at some of them:

## Operators Precedence ##

Ruby operators precedence can sometimes lead to some unexpected behaviour, especially when comparing `&&` and `and`

```
a = true && false
b = true and false
```
One would expect that `&&` and `and` are two spellings of same operator, so you might expect a and b to have
the same value, `true`.

They don't  

Ruby evaluates the two expressions in a different way because of operator precedence:

```
a = true && false # a => false   
# parsed as a=(true && false)

b = true and false # b => true
# parsed as (b=true) and false
```
The assignment operator (`=`) has a lower precedence than `&&`, but a higher precedence than `and`. This is why `and` and `or` are commonly used for control flow, while `&&` and `||` are preferred for boolean expressions.

For example, this common Rails idiom:

```ruby
redirect_to(root_path) and return
```

works exactly because `and` has a lower precedence than the method call and `return`, making it read almost like natural language.

### `defined?` is... special

Ruby also has a keyword called `defined?`, and it's one of the most unusual constructs in the language.

Consider the following example:

```ruby
c = nil

c += 1 if defined?(c)
```

At first glance this looks harmless. Since `defined?(c)` checks whether `c` exists, you might expect the expression to be skipped if `c` is `nil`.

Instead, Ruby raises:

```text
undefined method `+' for nil:NilClass
```

Why?

The expression is parsed as:

```ruby
(c += 1) if defined?(c)
```

The condition is evaluated first.

The important detail is that `defined?` does **not** inspect the value of `c`. Instead, it asks the parser/runtime environment whether the expression exists.

```ruby
c = nil

defined?(c)
# => "local-variable"
```

Since `"local-variable"` is a truthy value, Ruby executes:

```ruby
c += 1
```

which becomes:

```ruby
c = c + 1
```

and `nil + 1` raises a `NoMethodError`.

So `defined?(c)` can be truthy even when `c` is `nil`.

Now take a deep breath, because it's time for something even stranger.

## The Flip-Flop operator ##

For some people, flip-flops are summer footwear. 

For others, they're a fundamental electronic circuit.  

For Ruby, they're an operator.

Let's briefly talk about the electronic [flip-flop](https://en.wikipedia.org/wiki/Flip-flop_(electronics)).
A flip-flop is a bistable circuit capable of storing one bit of information. It has two stable states and changes state when one or more control inputs are activated.  

What does this have in common with Ruby's flip-flop? 
- it has an input that turns it **on**
- it has an input that turns it **off**

Let's look at an example:

```ruby
# Select the multiples of 7 and its immediate subsequent number

mults = []
(1..100).each do |x|
 mults << x if (x % 7)==0..(x % 7) == 1
end

p mults
[7, 8, 14, 15, 21, 22, 28, 29, 35, 36, 42, 43, 49, 50, 56, 57, 63, 64, 70, 71, 77, 78, 84, 85, 91, 92, 98, 99]
```
Ruby's expressiveness shines in this example, in just 4 lines of code we have an elegant solution. 
The interesting part is this expression  
```ruby
 # on the "if" right there's the flip-flop operator
 mults << x if (x % 7) == 0..(x % 7) == 1  
```
like its electronic counterpart it does have an input that triggers the `on` state `(x % 7) == 0` and one that triggers the
`off` state `( x % 7 ) == 1`. Once the left condition becomes true, the flip-flop remains active until the right condition becomes true, so the selected values are pushed into the array.

Let's look at another example

```ruby
ff = ->(x) { (x == 2)..(x == 4) }

(1..6).each do |i|
  puts "#{i}: #{ff.call(i)}"
end

1: false..false
(irb):13:in `block in <top (required)>': bad value for range (ArgumentError)
        from (irb):16:in `block in <top (required)>'
        from (irb):15:in `each'
        from (irb):15:in `<main>'
        from <internal:kernel>:187:in `loop'
        from /Users/alain.mauri/.rbenv/versions/3.3.1/lib/ruby/gems/3.3.0/gems/irb-1.11.0/exe/irb:9:in `<top (required)>'
        from /Users/alain.mauri/.rbenv/versions/3.3.1/bin/irb:25:in `load'
        from /Users/alain.mauri/.rbenv/versions/3.3.1/bin/irb:25:in `<main>'
```
This throws an exception, but I've used the same syntax! Well, it turns out that to be a flip-flop operator it must be used in a 
conditional expression otherwise it would be treated as a `range` operator and fail like in this case.
The corrected example is

```ruby
ff = ->(x) { x if x == 2..x == 4 }

(1..6).each do |i|
  puts "#{i}: #{ ff.call(i) }"
end

1:
2: 2
3: 3
4: 4
5:
6:
```
Notice what's happening:

* x = 1 → flip-flop is OFF
* x = 2 → left condition becomes true → flip-flop turns ON → returns 2
* x = 3 → stays ON → returns 3
* x = 4 → right condition becomes true → still returns 4, then turns OFF
* x = 5 → OFF
* x = 6 → OFF

The flip-flop operator's state persists across lambda calls. This tells us that the state is not tied to the value of x, but to that particular flip-flop expression. Ruby keeps one hidden bit of state associated with that piece of code, remarkably similar to its electronic counterpart.

#### Throw - Catch ####

Come on, everyone know `throw/catch`, almost every language implement them. They are a way to handle exceptions! Well, not in Ruby,
that's `begin/rescue`.  
In Ruby these operators are used to control the execution flow, more precisely, as the Ruby Guide [says](https://docs.ruby-lang.org/en/master/syntax/control_expressions_rdoc.html#throwcatch)
>throw and catch are used to implement non-local control flow in Ruby. They operate similarly to exceptions, allowing control to pass directly from the
>place where throw is called to the place where the matching catch is called. The main difference between throw/catch and the use of exceptions is that
>throw/catch are designed for expected non-local control flow, while exceptions are designed for exceptional control flow situations, such as handling
>unexpected errors.

Here is a simple example:

```ruby
def foo(n)
  throw :bar if (n % 2) == 0
end

def baz(n)
  puts n if (n % 3) == 0
  foo(n)
end

(1..10).each do |n|
  catch :bar do
    baz(n)
  end
end

# Results are
3
6
9
```
henever n is even, foo throws :bar, immediately transferring control to the matching catch block and skipping the remainder of the current execution path.
A more practical example is breaking out of nested loops:  

```ruby
result = catch(:found) do
  (1..30).each do |x|
    (1..20).each do |y|
       if x*y == 25
        throw :found, [x, y]
       end
     end
  end
end

# Result is
[5, 5]
```
Without the throw, exiting nested loops would have required flags, extra conditions or extracting the logic into a separate method.
Using `throw` and `catch` makes the intent more explicit: as soon as the desired value is found, execution jumps to the matching `catch`.

## There are many ways to solve the same problem ##

None of these features are things you'll necessarily use every day, and some of them you'll probably never use in production code. But they reveal something important about Ruby's philosophy. Ruby isn't a language that tries to force a single "correct" way of writing code. Instead, it gives developers a rich vocabulary, trusting them to choose the level of expressiveness that best fits the problem at hand.

I think that's enough Ruby hidden gems for today. I hope this brief journey has shown how Ruby has always valued expressiveness over rigidity. Perhaps that's one of the reasons so many of us enjoy writing it: every now and then, it still manages to surprise us.

---

#### Things I like - in random order ####

Summer is the perfect time for a challenge. I consider myself an avid reader, so I decided to try something different. I challenged my wife to choose a romance novel for me to read, while I would pick one of my favourite science books for her.

She chose Ali Hazelwood's *[Two Can Play](https://alihazelwood.com/two-can-play/)*, and, honestly, the time flew by. It turned out to be a surprisingly relaxing read. Not that my wife has converted me to romance novels—I probably wouldn't buy one myself—but it's well written and genuinely entertaining.

Did I pass the challenge? I think so.

Anyway check Oriana's - my wife - website, she's a novelist too [Oriana](https://orianawrites.eu/en/)

Some pictures I recently took in London and Brighton

<br/>
<img src="https://pxscdn.com/public/m/_v2/424813098022428933/4c90d8e69-c5a1c2/6LiFwiyd14K5/FFc9817nys8vCSVHlaHErswAHIXbM0Tn1QuB2s12.jpg" alt="A bright blue vintage-style fish and chips van stands beneath a wooden canopy in a busy London public space. Large illuminated letters spelling “FISH &amp; CHIPS” crown the stall, while menus and hand-painted signs decorate its sides. Three customers wait at the serving hatch: one young man in a pale T-shirt, another partially hidden beside him, and a man in a pink shirt carrying a striped tote bag as he receives his order" class="post-image"/>
<br/>
<br/>
<img src="https://pxscdn.com/public/m/_v2/424813098022428933/4c90d8e69-c5a1c2/EzYBBJEDsLyi/y2HCJXUb0JF4O0sTWNrbwPqaqXTRR7V6HmTmZWPB.jpg" alt="A wide pebble beach stretches across the foreground, leading to a calm blue-grey sea beneath a pale, hazy sky. Near the centre, two traditional blue-and-white striped deckchairs face the horizon. One is occupied by a person in a white sunhat, while another person reclines beside them, mostly hidden from view. Between the chairs sits a cream tote bag with a large red heart, alongside a woven straw beach bag. To the right, another pair of empty deckchairs stands alone, separated by open space." class="post-image">
<br/>
<br/>

---

#### Today's Links ####

Naomi Klein [Season of Smoke](https://naomiklein.substack.com/p/season-of-smoke)  
Langdon Winner [Do Artifacts Have Politics?](https://www.jstor.org/stable/pdf/20024652)  
Cory Doctorow [Deranged billionaires and their syndromes](https://pluralistic.net/2026/07/16/lucky-orifices/#invisible-hands)  
Futurism [Suno stole decades worth of copyrighted music](https://futurism.com/artificial-intelligence/hacker-ai-music-suno-copyright) 
Wired [Madison Square Surveillance Machine](https://www.wired.com/story/madison-square-garden-jim-dolan-surveillance-machine/)


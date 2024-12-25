---
layout: post
author: Wildeng
2024: 2024-12-25
title: Simplify Ruby Blocks
---

I didn't plan to write anything on Christmas, and honestly, I haven't been great at blogging. But here we are, another 25th of December and another Ruby release!  
This time, Ruby 3.4 brings an array of fantastic features, including Prism as the default parser, improved performance, reduced memory usage for YJIT, and much more. I highly encourage you to explore all the updates.
What caught my attention the most, though is the introduction of the `it` parameter. Back in Ruby 2.7 the shorthand `_1` block parameter was introduced allowing developers to write more concise
and elegant blocks. This enhancement made code more readable and intuitive.
The traditional approach is to use the `|` symbol in a block, something like:

```ruby
[1, 2, 3].map { |n| n * 2 }
```
the `_1` (and `_2, _3`) parameters removes the need to explicit the block variable explicitely and so, the above code could be written as:

```ruby
[1, 2, 3].map { _1 * 2 }  # _1 refers to each element in the array
```
Let's take a look at another example:

```ruby
[[1, 2], [3, 4]].map { _1 + _2 }
```
In this case `_1` refers to the first element of the array, `_2` to the second and so on. Ruby supports an unlimited number of block parameters allowing you to use `_1,_2,_3` and so
on, depending on the number of arguments passed to the block.  
Ruby `3.4`, released today, introduced `it` as a reference to a block parameter with no variable name and it's especially useful in the case of one parameter only or when the block operation is straightforward providing a more readable alternative
to `_1` for developers unfamiliar with `_1`.  
```ruby
[1, 2, 3].map { it * 2 }
```
These approaches are particularly useful in situations where block variables have no semantic meaning, such as simple transformations or operations. However, in complex blocks or scenarios where parameter names add clarity, traditional syntax remains preferable.  
In conclusion, these block parameters are a useful tool to write more concise and readable block.  

I think is enough writing for Christmas day, happy coding!

---

#### Things I like - in random order ####

I love the colours of this sunrise I caught a week ago from my window.
<br/>
<img src="https://pxscdn.com/public/m/_v2/424813098022428933/9da63c77d-bc90ba/kxkzDdkmcZuY/Bcbk4cuQtHWulxSy9fN3lg5jUdMsp7vLVHORk0JJ.jpg" alt="Sunrise from my window in Sheffield" class="post-image"/>
<br/>

---

#### Today's Links ####

A Christmas Cartoon from the [New Yorker](https://www.newyorker.com/cartoons/daily-cartoon/wednesday-december-25th-worth-it?utm_source=nl&utm_brand=tny&utm_mailing=TNY_Humor_122524&utm_campaign=aud-dev&utm_medium=email&bxid=63cda847194f293410074e42&cndid=72627383&esrc=subscribe-page&utm_term=TNY_Humor)  
The 20 most read stories on [Ars Technica](https://arstechnica.com/staff/2024/12/the-20-most-read-stories-of-2024-on-ars-technica/)  
A complete guide for linting [Go programs](https://freshman.tech/linting-golang/)   
Rails 8 [No PaaS Required](https://rubyonrails.org/2024/11/7/rails-8-no-paas-required)  




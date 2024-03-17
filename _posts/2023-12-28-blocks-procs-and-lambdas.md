---
layout: post
author: Wildeng
date: 2023-12-28
title: Blocks Procs and Lambdas
---

Ruby has three types of anonymous functions: Blocks, Procs and Lambdas.

##### ====== Block ====== #####

Blocks are anonymous pieces of code that are not objects but can be passed to methods for execution. An example is the `map` method from the [Enumerable mixin](https://ruby-doc.org/core-3.0.2/Enumerable.html#method-i-map), which accepts and executes a block of code:

```ruby
[1,2,3].map { |x| x* 2 }
```

Methods explicitly or implicitly accept blocks:

```ruby
def method_implicit
  puts "Starting the method"
  yield if block_given?
  puts "ending"
end

def method_explicit(&block)
  puts "Starting explicit"
  block.call
  puts "ending explicit"
end
```

In the first case, the method uses `yield` to execute the block if provided. In the second case, the ``&block`` syntax indicates that the method expects a block as an argument.
One more thing to remember is that when the block is executed the control passes to it and returns to the method when the block has finished its execution. 

##### ====== Proc ====== #####

Unlike blocks, Proc - from the [Ruby docs](https://ruby-doc.org/3.3.0/Proc.html) - are objects which encapsulate blocks of code. They can be stored in a variable, passed to a method or to other Procs. Proc are closures,meaning they remember and can use the entire context in which they were created. For instance:   

```ruby
pow_two = Proc.new { |x| x**2 }
pow_two.call(3) # Output: 9
```

Procs retain access to variables in their creation context:

```ruby
def create_proc
  local_variable = "I am from the original scope"
  proc = Proc.new do
    puts local_variable
  end
  proc
end

# Create a Proc in one scope
my_proc = create_proc

# Call the Proc in a different scope
my_proc.call # Output: I'm from the original scope
```
It's worth mentioning that this could potentially lead to troubles if the creation context is not available anymore or has changed such in the case of serialization/deserialization or if used in a different object or class context.  

Consider now this example:

```ruby
def another_proc
  local_var = "I'm local"
  proc = Proc.new { return local_var }
  proc.call
  return "another one"
end

irb(main):053:0> puts another_proc
I'm local
```

Procs do not pass back control to the calling method but immediately return.    
They are generous about accepting arguments. Missing ones will be fit with `nil`, single Array will be deconstructed if having multiple arguments and no errors will be raised on extra ones.

##### ====== Lambda ====== #####

Lambdas are objects of the Proc class created using the [kernel#lambda](https://ruby-doc.org/3.3.0/Kernel.html#method-i-lambda) semantics. They are stricter with passed arguments compared to regular Procs. Notably, `return` and `break` in a lambda exits the lambda and returns control to the calling function:

```ruby
def lambda_method
  local = "I'm local"
  lam = lambda {return local }
  puts lam.call
  puts "end"
end

lambda_method # Output: I'm local end
```
Understanding when to employ each of these constructs is crucial for writing clean and efficient Ruby code. Blocks are excellent for short, one-off operations, Procs offer encapsulation and context retention, while Lambdas provide a balance of strict argument handling and the familiarity of Proc behavior.

---

#### Things I like - in random order ####

The Astronomy Picture of the Day is something beautiful: [Cathedral, Mountain, Moon](https://apod.nasa.gov/apod/ap231225.html)

Probably a lot of people started using a computer with Windows installed - a stock [Windows 3.1](https://archive.org/details/win3_stock) on the Internet Archive

What an extraordinary historical archive: [BBC Computer Literacy Project 1980 - 1989](https://clp.bbcrewind.co.uk/)

<br/>
The Acorn BBC Micro  
<br/>
<img src="/images/acorn-bbc-micro.jpg" alt="the acorn bbc micro computer" class="post-image"/>
<br/>
<br/>

---

#### Today's Links ####

>  They say that electronic mail tends to be informal in style (as opposed to written mail) and makes people bolder. This encourages those who wouldn’t dare to say something direct to your face (and who don’t have anything serious enough to say to commit it to a formal, written memo) to send you “brazen” messages.

Sounds familiar? An old article about email and conventional post - 1983 [Could electronic mail undermine conventional post?](https://www.theguardian.com/technology/2023/dec/01/could-email-undermine-conventional-post-1983)

[Ruby 3.3](https://www.ruby-lang.org/en/news/2023/12/25/ruby-3-3-0-released/) has been released with some really interesting additions to the language

The Most Important Unsolved Problem in Computer Science [Scientific American](https://www.scientificamerican.com/article/the-most-important-unsolved-problem-in-computer-science/)

Good news you didn't hear about [Futurecrunch](https://futurecrunch.com/goodnews2023/)

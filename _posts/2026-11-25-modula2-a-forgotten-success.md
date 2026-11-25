---
layout: post
author: Wildeng
2024: 2026-11-25
title: Modula-2 a forgotten success?
---

While reading some old issues of BYTE discussing object-oriented programming and Smalltalk, I was reminded of a programming language I had learnt back in my university days, now quite some time ago. I remembered little more than its name.

So I decided to do a little research, and here is what I found.

#### The origins of Modula-2

Modula-2 was developed by Niklaus Wirth, who had previously designed Pascal (a language I loved and used during my secondary school years), with the aim of overcoming some of the limitations of its predecessor.

Between 1976 and 1977, Wirth spent a sabbatical year at Xerox PARC, where he encountered two projects:

- **Xerox Alto**, a workstation with a graphical user interface.
- **Mesa**, a programming language that supported modularity, separation of interface from implementation, and separate compilation.

Upon returning to ETH Zurich, Wirth began developing his own workstation, Lilith, with the ambition of using a single programming language to build its entire software environment.

[![The Lilith workstation on display at the Enter Museum](https://thumb.wikimedia.org/wikipedia/commons/thumb/1/15/Lilith-enter-museum.jpg/500px-Lilith-enter-museum.jpg)](https://commons.wikimedia.org/wiki/File:Lilith-enter-museum.jpg)

*The Lilith workstation. Photo: Enter Museum, [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/), via Wikimedia Commons.*

In Wirth's view, Pascal was sufficiently simple but not suited to the task, whereas Mesa was too complicated.

The main limitations of the original Pascal were the lack of a module system and of a standard mechanism for compiling individual program components separately. When developing complex systems, this presented several problems:

- Long compilation times.
- Difficulties in dividing the work among development teams.
- Difficulties in reusing software components.
- Greater complexity in managing dependencies between different parts of the system.

Wirth also drew on ideas from Modula, an experimental language he had developed in the preceding years, giving rise to Modula-2 in 1978.

The compiler, initially developed on a PDP-11 and later ported to Lilith, allowed modules to be compiled independently and subsequently linked together, while preserving static type checking across separately compiled modules.

The features and advantages of Modula-2 became particularly apparent during the development of Lilith's software: the operating system, drivers, text editors, compiler and so on.

The project demonstrated that using a single programming language to develop an entire software environment was not only possible but also beneficial.

#### The features of the language

So, what are the main features of Modula-2?

- The ability to divide programs into separately compilable modules (hence the name).
- Explicit import of identifiers and exposure of the public interface through the definition module. Separating the interface from the implementation allows implementation details to be hidden from those using the module (*information hiding*).
- Coroutines as a basic mechanism for managing concurrent processes.
- Static and strong typing.
- Case sensitivity, with keywords written entirely in uppercase.
- Access to low-level and hardware-specific resources through the `SYSTEM` module.

Many of these features are familiar to us because they are also found in modern programming languages. Think, for instance, of the import mechanisms used in Go and Python.

Furthermore, Modula-2 was conceived not primarily as a teaching language but as a systems programming tool. As Wirth himself explained in [A Brief History of Modula and Lilith](https://www.modula2.org/modula2-history.php), the language was, in a sense, a by-product of the development of Lilith:

*"It is evident that our primary concern was not a language satisfying all wishes of all programmers, but the creation of a sufficiently powerful tool for implementing an entire software system in a short time with the limited manpower at hand. Modula-2 was, so to speak, a subordinate goal, a means to an end."*

Let's look at a simple example taken from a [tutorial on the language](https://www.modula2.org/tutor/chapter3.php):

```modula2
MODULE IntVar;

FROM Terminal2 IMPORT WriteLn, WriteString, WriteInt;

VAR Count : INTEGER;  (* The sum of two variables *)
    x,y   : INTEGER;  (* The two variables to add *)

BEGIN

   x := 12;
   y := 13;
   Count := x + y;

          (* Assignments complete, now display the results *)

   WriteString("The value of x  =");
   WriteInt(x,3);
   WriteLn;
   WriteString("The value of y  =");
   WriteInt(y,4);
   WriteLn;
   WriteString("The sum of them =");
   WriteInt(Count,6);
   WriteLn;

   x := 0FFH;   (* This is the way to assign a hexadecimal number *)
   y := 177B;   (* This is the way to assign an octal number      *)

END IntVar.
```

`Terminal2` is a support module used by the tutorial for input/output operations.

The program begins with the module declaration, followed by the import of several procedures (using syntax remarkably similar to Python's), the variable declarations and, finally, the body of the program, enclosed between the keywords `BEGIN` and `END`, the latter followed by the module name.

Notice how the types of the variables are explicitly declared before they are used.

Another thing worth noting is how several elements of the syntax were inherited from Pascal: the keywords `BEGIN` and `END`, the assignment operator `:=`, the semicolon as a statement separator, and even the comment syntax.

A reminder, perhaps, that when evolving a programming language, there is no need to change what already works well.

#### Modular programming

Two module-related constructs deserve particular mention.

`DEFINITION MODULE` is conceptually similar to an `interface` in Java, although it can also expose types, constants and variables. It defines the public interface of a module, providing the compiler with the information needed to perform type checking even across separately compiled modules.

The separation of interface from implementation is a concept we find in many modern programming languages, not just Java.

Here is an example taken from the same [tutorial](https://www.modula2.org/tutor/chapter12.php):

```modula2
DEFINITION MODULE Circles;

PROCEDURE AreaOfCircle(Radius : REAL; VAR Area : REAL);

PROCEDURE PerimeterOfCircle(Radius : REAL; VAR Perim : REAL);

END Circles.
```

Once the interface has been defined, the actual implementation follows, and this is where `IMPLEMENTATION MODULE` comes into play.

```mGodula2
IMPLEMENTATION MODULE Circles;

PROCEDURE GetPi(VAR Pi : REAL);
BEGIN
   Pi := 3.14159;
END GetPi;

PROCEDURE AreaOfCircle(Radius : REAL; VAR Area : REAL);
VAR Pie : REAL;
BEGIN
   GetPi(Pie);
   Area := Pie * Radius * Radius;
END AreaOfCircle;

PROCEDURE PerimeterOfCircle(Radius : REAL; VAR Perim : REAL);
VAR Cake : REAL;
BEGIN
   GetPi(Cake);
   Perim := 2.0 * Cake * Radius;
END PerimeterOfCircle;

BEGIN (* IMPLEMENTATION MODULE body, empty in this case *)
END Circles.
```

Notice that the procedure `GetPi`, not being declared in the `DEFINITION MODULE`, is only accessible from within the module itself.

In this way, the definition exposes the module's public interface while hiding implementation details that, in the context of a large-scale software system, are not needed by those using the module.

#### Why did Modula-2 remain a niche language?

Although the Modula-2 compiler developed at ETH Zurich had been distributed to several hundred universities and companies, why did the language never reach the critical mass needed to become mainstream?

According to K.N. King, in a [1991 article](https://jacobfilipp.com/DrDobbs/articles/DDJ/1991/9106/9106d/9106d.htm) published in Dr. Dobb's Journal, Modula-2, despite being considered a mature language by then, faced competition from languages such as Ada and C++ and was even at risk of being superseded by its own successors, Modula-3 and Oberon.

Rich Gogesch of Stony Brook Software estimated that there were around 150,000 users worldwide at the time: a considerable number, but still nowhere near the number of Pascal and C users. Added to this was the limited availability of third-party libraries. King also described a situation of stagnation in the United States, in contrast to wider adoption in Europe, particularly in embedded systems.

Another obstacle to the adoption of Modula-2 was the slow standardisation process, which led to the publication of the first ISO standard in 1996.

In the meantime, other Pascal implementations, such as Turbo Pascal, had introduced some of Modula-2's distinctive features, including separate compilation through *units*, introduced in Turbo Pascal 4.0 in 1987, with the advantage of extending a language developers were already familiar with.

#### Whatever happened to Modula-2?

Nearly fifty years after its creation, Modula-2 has not disappeared. In 2023, with the release of GCC 13, the GNU Modula-2 compiler officially became part of the [GNU Compiler Collection](https://gcc.gnu.org/pipermail/gcc-announce/2023/000175.html), and there is still a community dedicated to developing software and tools related to the language.

Despite its limited commercial adoption, Modula-2 helped popularise ideas that we now find, albeit in different forms, in widely used programming languages such as Java, Go, Python and Ruby. These similarities do not necessarily imply direct descent from Modula-2.

In my eyes, this still makes it a successful language, because the value of a programming language is measured not only by the number of people using it but also by the longevity of the ideas it helped spread.

#### If this has sparked your curiosity...

- Niklaus Wirth – [Summary of projects by N. Wirth, 1962–1999](https://people.inf.ethz.ch/wirth/projects.html)
- Niklaus Wirth – [A Brief History of Modula and Lilith](https://www.modula2.org/modula2-history.php), 1995.
- K.N. King – [What's New With Modula-2?](https://jacobfilipp.com/DrDobbs/articles/DDJ/1991/9106/9106d/9106d.htm), Dr. Dobb's Journal, June 1991.
- [Modula-2 Standardization](https://archive.psg.com/sc22wg13.htm)
- [Modula-2 Tutorial](https://www.modula2.org/tutor/)
- Niklaus Wirth – [The Programming Language Modula-2](https://freepages.modula2.org/report4/modula-2.html).
- [GNU Modula-2 Documentation](https://gcc.gnu.org/onlinedocs/gm2/)

#### Modula-2 today: communities and discussions

For anyone interested in rediscovering the language, talking to fellow enthusiasts or following its development:

- [GNU Modula-2 Mailing List](https://lists.nongnu.org/mailman/listinfo/gm2)
- [comp.lang.modula2 – Usenet archive](https://groups.google.com/g/comp.lang.modula2)
- [Free Modula-2 Pages](https://freepages.modula2.org/)
- [Reddit – What ever happened to Modula-2?](https://www.reddit.com/r/programming/comments/1cuam2p/)
- [Reddit – Portable Pragmas for Pascal, Modula-2 and Oberon](https://www.reddit.com/r/ProgrammingLanguages/comments/1uf8ouu/)




---

#### Things I like - in random order ####

<br/>
<img src="" alt="" class="post-image"/>
<br/>
<br/>
<img src="" alt="" class="post-image">
<br/>
<br/>

---

#### Today's Links ####

Keza MacDonald [GTA VI Review](https://www.theguardian.com/games/2026/nov/18/grand-theft-auto-vi-gta-6-review-playstation-rockstar?CMP=share_btn_url)

New York Times 100 notable [books of 2026](https://www.nytimes.com/2026/11/23/books/review/notable-books.html?unlocked_article_code=1.TFE.Ds3w.RhMDLWb3-wFD&smid=url-share)

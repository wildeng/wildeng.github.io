---
layout: post
title: "Modula-2: un successo mancato?"
author: Wildeng
locale: it
translation_id: modula-2
permalink: /it/modula-2/
---

Mentre leggevo alcuni vecchi numeri di BYTE in cui si parlava di programmazione a oggetti e Smalltalk, mi sono ricordato di un linguaggio imparato ai tempi, ormai lontani, dell'università, di cui ricordavo principalmente il nome e poche altre cose.

Ho così iniziato a documentarmi ed ecco qui i risultati.

#### Le origini di Modula-2

Modula-2 fu sviluppato da Niklaus Wirth, lo stesso che in precedenza aveva ideato Pascal (linguaggio che ho amato e utilizzato durante la scuola superiore), con l'obiettivo di superare alcune delle limitazioni del suo predecessore.

Tra il 1976 e il 1977 Wirth trascorse un anno sabbatico allo Xerox PARC, dove venne in contatto con due progetti:

- **Xerox Alto**, una workstation dotata di interfaccia grafica.
- **Mesa**, un linguaggio di programmazione che supportava la modularità, la separazione tra interfaccia e implementazione e la compilazione separata.

Al suo ritorno all'ETH di Zurigo, Wirth iniziò a sviluppare una propria workstation, Lilith, con l'ambizione di utilizzare un unico linguaggio di programmazione per realizzarne l'intero ambiente software.

Agli occhi di Wirth, Pascal era sufficientemente semplice ma non adeguato al compito, mentre Mesa era troppo complicato.

Le principali limitazioni del Pascal originale riguardavano la mancanza di un sistema di moduli e di un meccanismo standard per compilare separatamente i vari componenti di un programma. Nello sviluppo di sistemi complessi, questo comportava alcuni problemi:

- Tempi di compilazione lunghi.
- Difficoltà nel suddividere il lavoro tra diversi gruppi di sviluppo.
- Difficoltà nel riutilizzare componenti software.
- Maggiore complessità nella gestione delle dipendenze tra le diverse parti del sistema.

Wirth riprese quindi anche alcune idee di Modula, un linguaggio sperimentale che aveva sviluppato negli anni precedenti, dando vita a Modula-2 nel 1978.

Il compilatore, inizialmente realizzato su un PDP-11 e successivamente portato su Lilith, consentiva la compilazione indipendente dei moduli e il loro successivo collegamento, preservando al contempo il controllo statico dei tipi anche tra moduli compilati separatamente.

Le caratteristiche e i vantaggi di Modula-2 si rivelarono particolarmente evidenti durante lo sviluppo del software per Lilith: sistema operativo, driver, editor di testo, compilatore e così via.

Il progetto dimostrò che utilizzare un unico linguaggio di programmazione per lo sviluppo dell'intero ambiente software non era soltanto possibile, ma anche vantaggioso.

#### Le caratteristiche del linguaggio

Ma quali sono le caratteristiche principali di Modula-2?

- Possibilità di suddividere i programmi in moduli (da cui il nome), compilabili separatamente.
- Importazione esplicita degli identificatori ed esposizione dell'interfaccia pubblica attraverso il modulo di definizione. La separazione tra interfaccia e implementazione permette di nascondere i dettagli implementativi dei moduli a chi li utilizza (*information hiding*).
- Coroutine come meccanismo di base per la gestione di processi concorrenti.
- Tipizzazione statica e forte.
- Distinzione tra lettere maiuscole e minuscole (*case sensitivity*) e parole chiave scritte interamente in maiuscolo.
- Accesso a risorse di basso livello e specifiche dell'hardware attraverso il modulo `SYSTEM`.

Molte di queste caratteristiche ci sono familiari perché presenti anche nei linguaggi di programmazione moderni. Pensiamo, ad esempio, ai meccanismi di importazione utilizzati da Go e Python.

Modula-2, inoltre, non era stato concepito principalmente come linguaggio didattico, ma come strumento di programmazione di sistema. Come Wirth stesso raccontò in [A Brief History of Modula and Lilith](https://www.modula2.org/modula2-history.php), il linguaggio era, in un certo senso, un sottoprodotto dello sviluppo di Lilith:

*"It is evident that our primary concern was not a language satisfying all wishes of all programmers, but the creation of a sufficiently powerful tool for implementing an entire software system in a short time with the limited manpower at hand. Modula-2 was, so to speak, a subordinate goal, a means to an end."*

Vediamo un semplice esempio di programma, tratto da un [tutorial sul linguaggio](https://www.modula2.org/tutor/chapter3.php):

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

`Terminal2` è un modulo di supporto utilizzato dal tutorial per le operazioni di input/output.

Il programma inizia con la dichiarazione del nome del modulo, seguita dall'importazione di alcune procedure (con una sintassi molto simile a quella di Python), dalla dichiarazione delle variabili e, infine, dal corpo del programma, racchiuso tra le parole chiave `BEGIN` ed `END`, quest'ultima seguita dal nome del modulo.

Si può osservare come il tipo delle variabili venga esplicitamente dichiarato prima del loro utilizzo.

Un'altra cosa da notare è che diversi elementi della sintassi sono stati ereditati da Pascal: le parole chiave `BEGIN` ed `END`, l'operatore di assegnazione `:=`, il punto e virgola come separatore delle istruzioni e persino la sintassi dei commenti.

Quasi a ribadire che, nell'evoluzione di un linguaggio, non è necessario cambiare ciò che già funziona bene.

#### La programmazione modulare

Meritano un cenno particolare due costrutti relativi ai moduli:

`DEFINITION MODULE`, un costrutto concettualmente simile a un'`interface` di Java, sebbene possa esporre anche tipi, costanti e variabili. Definisce l'interfaccia pubblica del modulo, fornendo al compilatore le informazioni necessarie per effettuare il controllo dei tipi anche tra moduli compilati separatamente.

La separazione tra interfaccia e implementazione è un concetto che ritroviamo in molti altri linguaggi di programmazione moderni, oltre al già citato Java.

Vediamo un esempio tratto dal [tutorial sul linguaggio](https://www.modula2.org/tutor/chapter12.php):

```modula2
DEFINITION MODULE Circles;

PROCEDURE AreaOfCircle(Radius : REAL; VAR Area : REAL);

PROCEDURE PerimeterOfCircle(Radius : REAL; VAR Perim : REAL);

END Circles.
```

Alla definizione dell'interfaccia segue l'implementazione vera e propria, ed è qui che entra in gioco `IMPLEMENTATION MODULE`.

```modula2
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

Da notare che la procedura `GetPi`, non essendo dichiarata nel `DEFINITION MODULE`, è accessibile solamente all'interno del modulo stesso.

In questo modo la definizione espone le informazioni pubbliche del modulo, nascondendo i dettagli implementativi che, nell'economia di un programma su larga scala, non sono necessari a chi utilizza il modulo.

#### Perché Modula-2 è rimasto un linguaggio di nicchia?

Nonostante il compilatore di Modula-2 sviluppato all'ETH fosse stato distribuito a diverse centinaia di università e aziende, come mai il linguaggio non ha raggiunto una massa critica tale da farlo diventare mainstream?

Secondo quanto riportato da K.N. King in un [articolo del 1991](https://jacobfilipp.com/DrDobbs/articles/DDJ/1991/9106/9106d/9106d.htm), pubblicato sul Dr. Dobb's Journal, Modula-2, pur essendo ormai considerato un linguaggio maturo, soffriva la concorrenza di linguaggi come Ada e C++ e rischiava addirittura di essere soppiantato dai suoi successori, Modula-3 e Oberon.

Il numero di utilizzatori all'epoca era stimato da Rich Gogesch, di Stony Brook Software, in circa 150.000 a livello mondiale: un numero considerevole, ma comunque lontano da quello degli utilizzatori di Pascal e C. A questo si aggiungeva la scarsa disponibilità di librerie sviluppate da terze parti. King descriveva inoltre una situazione di stagnazione negli Stati Uniti, a fronte di una maggiore diffusione in Europa, in particolare nell'ambito dei sistemi embedded.

Un altro ostacolo alla diffusione di Modula-2 era la lentezza del processo di standardizzazione, che portò alla pubblicazione del primo standard ISO nel 1996.

Nel frattempo, altre implementazioni di Pascal, come Turbo Pascal, avevano introdotto alcune delle caratteristiche distintive di Modula-2, tra cui la compilazione separata attraverso le *unit*, introdotte in Turbo Pascal 4.0 nel 1987, con il vantaggio di estendere un linguaggio già conosciuto dagli sviluppatori.

#### Ma che fine ha fatto?

A quasi cinquant'anni dalla sua nascita, Modula-2 non è scomparso. Nel 2023, con il rilascio di GCC 13, il compilatore GNU Modula-2 è entrato ufficialmente a far parte della [GNU Compiler Collection](https://gcc.gnu.org/pipermail/gcc-announce/2023/000175.html) ed esiste ancora una comunità dedita allo sviluppo di software e strumenti legati a questo linguaggio.

Nonostante la sua limitata diffusione commerciale, Modula-2 ha contribuito a diffondere idee che ritroviamo oggi, seppure in forme diverse, in linguaggi di programmazione di largo utilizzo come Java, Go, Python e Ruby. Queste analogie non implicano necessariamente una discendenza diretta da Modula-2.

Ai miei occhi questo lo rende comunque un linguaggio di successo, perché il valore di un linguaggio di programmazione non si misura solamente dal numero dei suoi utilizzatori, ma anche dalla longevità delle idee che ha contribuito a diffondere.

#### Se tutto questo vi ha incuriosito...

- Niklaus Wirth – [Summary of projects by N. Wirth, 1962–1999](https://people.inf.ethz.ch/wirth/projects.html)
- Niklaus Wirth – [A Brief History of Modula and Lilith](https://www.modula2.org/modula2-history.php), 1995.
- K.N. King – [What's New With Modula-2?](https://jacobfilipp.com/DrDobbs/articles/DDJ/1991/9106/9106d/9106d.htm), Dr. Dobb's Journal, giugno 1991.
- [Modula-2 Standardization](https://archive.psg.com/sc22wg13.htm)
- [Modula-2 Tutorial](https://www.modula2.org/tutor/)
- Niklaus Wirth – [The Programming Language Modula-2](https://freepages.modula2.org/report4/modula-2.html).
- [GNU Modula-2 Documentation](https://gcc.gnu.org/onlinedocs/gm2/)

#### Modula-2 oggi: comunità e discussioni

Per chi volesse riscoprire il linguaggio, confrontarsi con altri appassionati o seguirne gli sviluppi:

- [GNU Modula-2 Mailing List](https://lists.nongnu.org/mailman/listinfo/gm2)
- [comp.lang.modula2 – Archivio Usenet](https://groups.google.com/g/comp.lang.modula2)
- [Free Modula-2 Pages](https://freepages.modula2.org/)
- [Reddit – What ever happened to Modula-2?](https://www.reddit.com/r/programming/comments/1cuam2p/)
- [Reddit – Portable Pragmas for Pascal, Modula-2 and Oberon](https://www.reddit.com/r/ProgrammingLanguages/comments/1uf8ouu/)


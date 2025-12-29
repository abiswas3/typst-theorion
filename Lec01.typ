#import "@preview/xarrow:0.4.0": xarrow, xarrowSquiggly, xarrowTwoHead
#import "/lib.typ": *
// #import "@preview/theorion:0.4.1": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import cosmos.fancy: *
#show link: underline
#show link: set text(rgb("#1e66f5").darken(20%), weight: "semibold")
#show cite: set text(fill: rgb("#1e66f5").darken(15%), weight: "medium") // citation colour 
#show footnote.entry: set text(fill: rgb("#282828")) // footnote colours
#show ref: set text(fill: rgb("#006633"), weight: "bold") // equation refs colour 

// Equation settings:
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")
//-------------------------------------------------------------

#show: show-theorion

// =====================
// Page setup
// =====================
#set page(
  margin: (top: 2cm, bottom: 2cm, left: 2.5cm, right: 2.5cm)
)

#set text(
  font: "Libertinus Serif",
  size: 11pt
)

#show heading: set block(below: 1em)
#set heading(numbering: "1.1.1.1")

// =====================
// Lecture metadata
// =====================
#let lecture-number = "1"
#let lecture-title = "Course Introduction"
#let lecturer = "Rahul Santhanam"
#let scribe = "Ari"
#let date = "15 Oct 2025"

// =====================
// Lecture header box
// =====================
#block(
  stroke: 1pt,
  radius: 6pt,
  inset: 12pt,
)[
  #align(center)[
    #text()[*Lecture #lecture-number*]:  
    #underline(stroke: 1pt, offset: 2pt)[
    #text(size: 13pt, weight: "bold", fill: blue)[#lecture-title]
    ]
  ]

  #v(8pt)

  #table(
    columns: (1fr, auto),
    align: horizon,
    inset: 0pt,
    stroke: none,
    [
      *Lecturer:* #lecturer \
      *Course*: _Computational Complexity Theory, Oxford_
    ],
    [
      *Scribe:* #scribe \
      Date: 16/12/2025
      
    ]
  )
]

#v(1.5em)

= Course Structure
This is a rough outline of the course structure.

+ Motivation And Recap of Turing Machines [2 Lectures]
+ Time And Space [2 Lectures]
+ Nondeterminism [4 Lectures]
+ Alternation [2 Lectures]
+ Circuits and Non-uniformity [2 Lectures] 
+ Randomness [2 Lectures]
+ Approximation [2 Lectures]
 


Problem sets for Weeks 3-8, and posted at the end of the week.
 
= Motivation 

We are interested in answering questions such as:

+  What makes one algorithm for solving some problem better than another?
+  What's the best possible algorithm for solving some problem ?
+  How does the difficulty of solving one problem compare to the difficulty of solving another problem i.e. can we quantify how much harder it is to solve one problem over another?

As a motivating example, consider the problem of sorting $n$ distinct values. 
To compare algorithms, we need some measure of complexity of the problem. 
Let the number of comparisons between items be the complexity measure of the algorithm. 

#definition[
A comparison-based sorting algorithm takes as input an array $[a_1,a_2,... ,a_n]$ of $n$ items, and can only gain information about the items by comparing pairs of them. Each comparison
(“is $a_i > a_j$?”) returns YES or NO and counts as 1 time-step. The algorithm may also for free reorder items based on the results of comparisons made. In the end, the algorithm must output a
permutation of the input in which all items are in sorted order.
]

We list below some well known comparison based sorting algorithms and the upper bounds on the number of comparisons needed:

+  Merge Sort: $O(n log n)$
+  Heap Sort: $O(n log n$
+  Quick Sort: Amortised $O(n log n)$ but worst case $O(n^2)$
+  Bubble Sort, Selection Sort: $O(n^2)$

But how do we know that $O(n log n)$ is the best we can do? 

#theorem[
Any deterministic comparison-based sorting algorithm must perform $Omega(n log n)$ comparisons to sort $n$ elements in the _worst case_.

]
#proof[
The output of any sorting algorithm is a permutation of the original input $[a_1,a_2,... ,a_n]$. Notice that there (a) $n!$ such permutations, and (b) for each such permutation there is an input for which that permutation is the _only_ correct answer.
If all $n$ elements in the input are distinct, then there is 1-1 correspondence with an input and correct output.
Thus we start with some set $S$ which initially contains all $n!$ outputs as a possible answer.
On performing one comparison, we can split the set $S$ into two equal groups of outputs - those orderings that agree with this comparison, and those that do not.
We throw away the set that does not agree, and perform another comarison restricting only to the outputs that agreed with the first comparison.
We continue this process till the size of $S$ is reduced to 1, and there is only one answer left. 
The maximum number of comparisons we must do is given by $log n!$ (successive halving)
$
log n! &= log n + log (n-1) + dots + log 1 \
	&= Omega(n log n)
$
]
// \begin{proof}//
// \begin{align*}
// \end{align*}
//
// \end{proof}

See lecture notes by #citet(<avrim_lec_notes>) for an alternative view of this proof, and a more detailed explanation.

Now consider the Pigeonhole sorting algorithm, which does not use any comparisons, but instead leverages space as the measure of complexity.
The Pigeonhole sorting algorithm works as follows:

#theorem-box[
Given an input $[a_1, dots, a_n]$, the algorithms scans the list once and computes 

#math.equation(numbering:none, block:true)[
$ 
a^*= max_(i in [n]) a_i 
$
]
It then creates $a^*$ counters, initialised to zero. 
It scans the input again, and each time it encounters an element it increases the counter for the bin for that element by one. Finally, it can output the sorted output by clearing the bins lexicographically.

]

So how do you compare the complexity of Pigeonhole sort to the complexity of say, merge sort? We cannot do so using ``number of comparisons'' as the complexity measure. Thus, we need a more general model of computation.
The general model we consider in this course is the multi-tape Turing machine.

= General Model Of Computation

*Input Representation*: Different problems have different inputs, like integers, matrices or graphs.
As we want to be as general as possible to be able to compare diverse set of problems, we represent the input to a problem with strings over some alphabet $InputAlphabet$.

When $InputAlphabet = {0,1}$, the input alphabet consists of bit strings in ${0,1 }^*$.
We can represent any integer, graph, matrix or function with bit strings.
Thus, the string representation of the input can be considered a general representation that captures all the inputs we might care about.

*Multi-Tape Turing Machines (TM's)*
 Informally, a $NumTapes$-tape Turing Machine (TM) (illustrated by Figure *TODO* is meant to realise a scratch pad with a finite set of operations or rules. 

*Scratch Pad*: The scratch pad consisting of $NumTapes$ tapes that are a line of cells that infinite in one direction (semi-infinite). 
Each cell on a tape can hold a symbol from a finite set $TapeAlphabet$, called the tape alphabet.
Each tape $i$ is equipped with a tape head or pointer $Ptr_i$ that can potentially read or write symbols to the tape one cell at a time. 
Time is divided into discrete time steps, during which one unit of computation takes place.
The first tape of the machine is designated as the input tape and is read-only.
The $NumTapes - 1$ read-write tapes are called work tapes, and the last tape is often called the output tape.

*Operations/Rules*:  The machine has a finite set of states, denoted with set $States$. At any time step, the state of the machine is described by a single element $q in States$.
The state along with the contents of the $NumTapes$ tapes describes the next action of the machine.
A single action or unit of computation corresponds to doing the following:
	+  Read the symbols in the cells directly under the $NumTapes$ heads
	+  For the $NumTapes - 1$ read/write tapes replace each symbol with a new symbol (it has the option of not changing the tape by writing down the old symbol again)
	+  Change state from $q$ to $q' in States$ (it has the option not to change its state by choosing the old state again)
	+  move each head one cell to the left ($Left$), or to the right ($Right$). 

#definition(title: [Turing Machine])[
Formally a TM consists of the following tuple $(States, InputAlphabet, TapeAlphabet, TransitionFunction, InitialState, AcceptState, RejectState)$ where 

	+  $States$: Describes all the states a machine can be in. 
	+  $InputAlphabet$: Describes all the symbols that can be written on the cells of the input tape.
	+  $TapeAlphabet$ Describes all the symbols that can be written on the $NumTapes-1$ working tapes. $TapeAlphabet$ consists of a designated blank symbol denoted by $square$, and includes the symbols in $InputAlphabet$.
	+ $TransitionFunction : States times TapeAlphabet^(NumTapes) -> States times TapeAlphabet^(NumTapes-1)  times Moves^NumTapes$ is a transition function, that describes the next computational step given the current state of the Turing machine.
        
	+  $InitialState in States$ is the initial state of the TM.
	+  $AcceptState in States$ is a state at which the TM halts, and accepts the input.
	+  $RejectState in States$ is a state at which the TM halts, and rejects the input.
]

#definition(title: [Configuration of a TM])[The configuration of TM at any time step is given by the tuple $C = q, (Word_1, dots, Word_NumTapes), (Ptr_1, dots, Ptr_NumTapes)$ where 

+  $q in States$ is the state of the TM at that time step.
+  For any $i in [NumTapes]$, $Word_i$ refers to the contents of the tape $i$.
+  For any $i in [NumTapes]$, $Ptr_i in NN$ refers to the cell to which the pointer on tape $i$ is pointing to.
]

Given two configurations $C$ and $C'$, we say $C -> C'$ if we can get from $C$ to $C'$ by applying the transition function $TransitionFunction$ once.
We say $C xarrowSquiggly(*) C'$, if we can get from $C$ to $C'$ by applying the transition function $TransitionFunction$ finitely many times.

#proposition[
$InitialConfig$ be the initial configuration of the TM machine $M$, and $AcceptConfig$ be a configuration with state $AcceptState$. 
Given an input $x$,

#math.equation(numbering: none, block: true)[
  $ 
     M "accepts" x <=>  (InitialConfig xarrowSquiggly(*) AcceptConfig)
  $
  ]
]

#definition(title: [Language])[
Given a TM $M$, we define its language $Language(M)$ as the set of inputs $x in InputAlphabet^*$, such that $M$ accepts $x$.
#math.equation(block:true, numbering: none)[
$
Language(M) = {x in InputAlphabet^* :  M "accepts" x }
$
]
]

#remark[
From the above definition, it appears like all a TM can do is check if an input $x$ is in the language or not, i.e. it answers YES or NO questions.
Going back to the sorting example described above, we want the output to be the sorted array, and not a YES or a NO response.
In his case, one considers the last tape of the TM to be an output tape, and when the TM reaches an accepting state, we use the contents of the output tape as the final output of of the problem.
]

#definition(title: [Recursively Enumerable])[
We say a language $L subset.eq InputAlphabet^*$ is recursively enumerable (RE) if there is a Turing machine $M$ such that for all $x in InputAlphabet^*$, $M$ accepts $x$ iff $x in L$.
]


#definition(title: [Decideable Languages])[
We say a language $L subset.eq InputAlphabet^*$ is decidable if 

+  For all $x in L$, $M$ accepts $x$.
+  For all $x in.not L$, $M$ halts and rejects $x$.

]
= Exercises

1. Prove that there are recursively enumerable languages are not decidable. *Hint*: Use the diagonolisation argument.

#bibliography("complexity.bib",
             title: "References", 
             style: "association-for-computing-machinery"
           )


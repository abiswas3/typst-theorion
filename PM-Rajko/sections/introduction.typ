#import "/conf_templates/conf.typ": conf
#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *

// #show ref.where(
//   form: "normal"
// ): set ref(supplement: it => {
//   if it.func() == heading {
//     "Chapter"
//   } else {
//     "Thing"
//   }
// })
//

= Introduction 

Perhaps the most fundamental problem in computation is to provide an answer to the question asked by #citeauthor(<cook1979relative>) in their seminal paper~@cook1979relative - "_Given a true statement $A$, is there a short proof of the claim that $A$ is true_".
In trying to answer this question, we must first describe what constitutes a valid proof. That is, we must describe the language in which the proof is written (axioms), and the rules for checking it (the verifier).
Each set of rules for writing and checking a proof defines a proof system.
Therefore, a precise restatement of the question above is the following:  "_Given a true statement $A$ and a proof system $S$, what is the length of a shortest proof $#Proof in S$ that proves $A$_?"
If we could show that there exists a proof system $S$, such that for _any_ true statement $A$, the length of the shortest proof in $S$ is upper bounded by some polynomial in the length of $A$, it would imply that $CoNP = NP$ and consequently the polynomial hierarchy collapes to $NP$. 
Conversely, if we could show large proof size lower bounds for some true statement $A$ in _all_ proof systems, it would lead to a formal proof of the widely believed conjecture that $#P eq.not NP$.
Unfortunately, such lower  bounds for _arbitrary_ proof systems are out of reach.
As an intermediate step,
the research community has invested a significant effort in proving lower bounds for increasingly expressive proof systems (e.g.\, see @abascal2021strongly @alekhnovich2001lower @atserias2020Size @buss1999linear @conneryd2023graph@de2023clique @impagliazzo1999lower @kothari2017SumOfSquares @potechin:LIPIcs.CCC.2020.38 @raz2008elusive @razborov1998lower @schoenebeck2008linear). \

In this work, we focus on the algebraic and semi-algebraic proof systems#footnote[Similar to the work of #citet(<Austrin_2022>), our lower bounds also extend to bounded depth Frege proof systems. However, the key technical component in this work is the graph theoretic techniques proposed for embedding carefully chosen hard instances into the host graph.
As this applies broadly across proof systems, we restrict our preliminaries to PC and SoS for brevity.] of _polynomial calculus_ (PC) and _sum of squares_ (SoS). //\citep{boazCourse,parrilo2000structured}. 
In algebraic proof systems, we are given a set $Axioms ={ axiomSmall_(i) (arrow(x)) " " | " " i in [m] }$ of $m$ polynomial equations#footnote[Semi-algebraic proof systems also allow for inequalities but we will not deal with inequality constraints in this paper.] over $n$ variables $arrow(x) = {x_1, dots, x_n}$.
In PC, the equations can be over an arbitrary, but fixed field $Field$, and in the SoS the coefficients are  over the reals.
We say a proof $Proof$ is a refutation of $Axioms$, if it is a proof of the claim (in the specified language) that there exists no assignment of $arrow(x) in Field^n$ that satisfies _all_ the polynomial equations in $Axioms$.
In PC and SoS, the proof $Proof$ is itself expressed as a sequence of polynomials.
Two common measures of the complexity of a semi-algebraic proof are size (the number of monomials appearing in the proof) and the degree (the largest degree of the proof polynomials that refute $Axioms$).
Trade-offs between the two are well known; in particular, any degree $d$ proof has size at most $n^(O(d))$.
Therefore, in this work we focus on the former#footnote[Note that exponential size lower bounds only follow from degree lower bounds $d >> sqrt(n)$, as $d = O(sqrt(n))$ yields only subexponential size bounds $n^(O(sqrt(n))) = 2^(O(sqrt(n)log n))$.].
We denote the smallest maximum degree over all proofs that refute $Axioms$ in PC and SoS, with $Degree(Axioms PC bot)$ and $Degree(Axioms SOS bot)$, respectively.
One motivation for proving lower bounds for algebraic proof systems, as opposed to propositional proof systems, is that often they imply lower bounds for a broad family of related algorithms for solving combinatorial optimisation problems.
Similarly, upper bounding the proof length has led to the fruitful discovery of many efficient algorithms.
The SoS proof system is of particular interest because of its close connection to the sum-of-squares hierarchy of semi-definite programming.
We refer the reader to the survey by #citet(<fleming2019semialgebraic>) for more details about the connections between the semi-algebraic proof systems and combinatorial optimisation. 
In this work, we study the complexity of refuting _perfect matchings_ in PC and SoS. 
Apart from being a natural problem in its own right, perfect matchings are also related to the pigeon hole principle @maciel2000new @pitassi1993exponential @raz2004resolution@razbarov2002pgp @razborov2003resolution and Tseitin formula @filmus2013towards @galesi2019bounded @glinskih2017satisfiable @grigoriev2001linear, two well studied formulae in proof complexity.
Assuming at most one pigeon fits in a single hole, the pigeon hole principle says $m$ pigeons cannot fit in $n < m$ holes.
If we construct the complete bipartite graph with the left vertices as $m$ pigeons and the right vertices as $n < m$ holes, proving the pigeon hole principle amounts to proving that such a bipartite graph does not have a perfect matching.
There are other formulations of the pigeon hole principle (see the survey by #citet(<razbarov2002pgp>)), and almost all of them have short proofs in the sum of squares proof system.
In contrast, Tseitin formulae are known to require long proofs. The Tseitin formula over a graph claims that there is a spanning subgraph in which every vertex has odd degree.
If a graph has a perfect matching, then the subgraph described by the matching ensures that every vertex has odd degree.
However, formally refuting Tseitin formulae for expander graphs with an odd number of vertices, in the SoS proof system, requires degree linear in the number of vertices in the graph @grigoriev2001linear.
// The exact complexity of refuting the perfect matching principle for expander graphs, however, remains unknown.
Given its close connections to the pigeon-hole and Tseitin, and the different behaviour of the two formulae, it is natural to determine the complexity of refuting perfect matchings for non-bipartite graphs.\
To refute perfect matchings in an algebraic proof system, we first need to specify combinatorial constraints as algebraic equalities. Given an undirected graph $G=(V,E)$, $V = {1, dots, n}$, and a vector $arrow(b) = (b_1, dots, b_n) in Field^n$,
// % we denote with $arrow{b} = (b_1, \dots, b_{|V|})  \in \Field^{\Size{V}}$ the vector of all $b$'s vector with size $\Size{V}$.
we define $Card(G, arrow(b))$ as the following set of polynomial constraints over variables $x_e$ for $e in E$:

#set math.cases(gap: 1em)

#math.equation(block: true, numbering: none)[
$
Card(G, arrow(b)) := cases(
  x_e (1 - x_e) &= 0 & "for every" e in E,
  sum_(e ~ v) x_e &= b_v & "for every" v in V
)
$
]

where we use notation $e ~ v$ to denote the set of edges $e$ incident on node $v$.
For every $e in E$, the equation $x_e (1 - x_e) = 0$ restricts the domain of the above variables to bits.
In plain words, $Card(G, arrow(b))$ denotes the claim that there exists a spanning subgraph $G' subset.eq G$ such that a vertex $v in V(G)$ has $b_v$ edges incident to it in $G'$.
Note if there was an assignment of variables $(x_e)_(e in E)$ that satisfies all equations in $Card(G, arrow(1))$, where $arrow(1) = (1, dots, 1) in Field^n$, it would imply that the graph $G$ has a perfect matching (given by the edges corresponding to variables with assignment 1).
Therefore, we define $PM(G) := Card(G, arrow(1))$.
When $|V|$ is odd, $G$ trivially does not contain a perfect matching. How difficult is it to refute $PM(G)$ in this case? In recent work, #citet(<Austrin_2022>) showed that refuting $PM(G)$, in the Polynomial Calculus  and Sum-of-Squares system, in the case $G$ is a _random $d$-regular graphs_ with an odd number of vertices typically requires proofs with degree $Omega(n/(log n))$.
They conjecture that the hardness results should also apply to general expander graphs but leave showing so as an open problem @Austrin_2022[~see~Section 6].
In this work, we verify this by extending their result to all $d$-regular spectral expanders, that is, $d$-regular graphs with a mild condition on the spectral gap.
In fact, similar to Austrin and Risse, we reduce the hardness of refuting $Card(G, arrow(t))$, where $arrow(t) = (t, dots, t)$, for any odd value $t$, to the hardness of refuting $Card(G, arrow(1))$, where $arrow(1) = (1, dots, 1)$.
As another special case, this answers the _even-colouring_ case when $t = d/2$ is odd, a problem posed by Buss and Nordstr\u{00F6}m  #cite(<buss2021proof>, supplement: [~see Open Problem 7.7]), which asks, _"Are even colouring formulas over expander graphs hard for polynomial calculus over fields of characteristic distinct from 2 ?"_
Formally, we prove the following (for the definition of $(n, d, lambda)$-graphs see @sec:graph-theory-prelims[Section]).

#theorem(title: [Hardness Result For $Card(G, arrow(t))$])[
  There exist universal constants $epsilon, n_0, d_0 in NN$ such that for any odd $n >= n_0$ and even $d in [d_0, n]$, the following holds for *any* $(n, d, lambda)$-graph $G$ with $lambda < epsilon d$, and for any odd $1 <= t <= d$:
  #math.equation(block: true, numbering: none)[
  $
  Degree(Card(G, arrow(t)) PC bot = ) = Omega(n/(log n))  
  $
]

]<thm:general-hardness-result>


We follow the overall approach of #citet(<Austrin_2022>). 
Very briefly, the strategy is to obtain an affine restriction (see @def:affine-restriction[Definition]) $Card(G, arrow(t))|_rho equiv PM(H)$ where $H$ is some graph for which refuting $PM(H)$ requires large degree.
An example of such $H$ is given by Buss, Grigoriev, and Impagliazzo \cite{buss1999linear}. We now describe how to find such a restriction in more details: Using a result of #citet(<draganic22rolling>), we show that $H$ topologically embeds into a given expander graph $G$ with $lambda < epsilon d$ for some universal small constant $epsilon in (0,1)$, such that all paths corresponding to the embedding have odd length.
The main technical ingredient of Austrin and Risse is also a similar embedding theorem, albeit a significantly more complicated one.
Moreover, we show that one can find such an embedding so that the subgraph of $G$ induced by vertices which are not part of the embedding has a perfect matching.
This allows us to use the restriction argument to transfer the hardness of $PM(H)$ into the hardness of $PM(G)$.
To extend this to hardness of $Card(G, arrow(t))$ for an odd $3 <= t <= d$, it suffices to show that the graph $G'$ obtained from $G$ by removing all edges that participate in the embedding and the matching contains a $(t-1)$-regular spanning subgraph.
Austrin and Risse achieve this using the contiguity property of random regular graphs (and hence their hardness result for $Card(G, arrow(t))$ critically relies on randomness). 
Instead, we provide a significantly simpler and shorter argument based on Tutte's criterion.
 As a random $d$-regular graph is with high probability an $(n, d, lambda)$-graph with $lambda = Theta(sqrt(d))$ (see Theorem A by #citet(<tikhomirov2016spectralgapdenserandom>), our embedding theorem readily applies in the context of @Austrin_2022.

The rest of the document is structured as follows. 
In @sec:prelims[Section], we describe the requisite background from graph theory and proof complexity.
In @sec:embed-machinery[Section], we describe the machinery for finding a desired topological embedding.
In @sec:matching-machinery[Section], we prove conditions under which the residual graph has a perfect matching or, more generally, a $(t-1)$-regular spaning subgraph.
In @sec:main-proof[Section], we use the tools from the previous sections to prove Theorem \ref{thm:general-hardness-result}. 
In Section @sec:related-work[Section] we briefly discuss a few other lower bounds using embeddings in proof complexity, and conclude with some future directions.
//


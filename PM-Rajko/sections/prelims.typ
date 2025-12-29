#import "/conf_templates/conf.typ": conf
#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
// #import cosmos.simple: *


= Preliminaries <sec:prelims>

== Proof Complexity Preliminaries <sec:proof-system-prelims>

Let $Axioms = { p_1 = 0, dots, p_m = 0}$ be a set of polynomial equations #footnote[The sum of squares proof system is a semi-algebraic proof system where $Axioms$ may also contain inequalities of the form $p_i (x) >= 0$. 
However, we only need equality constraints to express the existence of Perfect Matchings over graphs. 
Therefore to simplify our exposition, we write all our definitions using equality constraints only.], which we refer to as axioms, over variables $arrow(X) = {x_1, dots, x_n, overline(x)_1, dots, overline(x)_n}$.

#definition(title: [Sum Of Squares Refutations])[
Given a set of $m$ polynomial equality constraints $Axioms$ over the reals, a Sum of Squares (SoS) refutation is a sequence of polynomials $Proof = (t_1, dots, t_m; s_1, dots, s_a)$ such that

#math.equation(block:true, numbering: none)[
$ 
h := sum_(i in [m]) t_i p_i + sum_(i in [a]) s_i^2 = -1
$
]
The degree of a proof $Proof$ is

#math.equation(block:true, numbering: none)[
  
$ Degree(Proof) := max{max_(i in [m]) Degree(t_i) + Degree(p_i), max_(i in [a]) 2 Degree(s_i) }
$
]
]<def:sum-of-squares>

Note that $s_i^2(x) >= 0$ for any $x$ by definition. 
Therefore, if there were to exist some $x^(*)$ such that $p_i (x^(*)) = 0$ for all $p_i in Axioms$, then $sum_(i in [m]) t_i (x^*) p_i ( x^* ) = 0$. 
This would imply that $h >=0$, but if proof $Proof$ shows that $h = -1$, then by the contrapositive, no such $x^*$ can exist. 
Therefore, the existence of the sequence of polynomials $Proof$ act as a formal proof of the claim that the set of polynomial equations in $Axioms$ is unsatisfiable.

#definition(title: [Complexity Of SoS Refutation])[
If we let $Pi$ denote the set of all valid SoS refutations for $Axioms$, then the complexity of refuting $Axioms$ in the SoS proof system is given by 

#math.equation(block:true, numbering:none)[
$ Degree(Axioms SOS bot) := min_(Proof in Pi)Degree(Proof)
$]
]<defn:degree>

Polynomial Calculus (PC) is a dynamic version of the static Nullstellensatz proof system @fleming2019semialgebraic[~see Section 1.3 for the defintion of Nullstellensatz proof systems] operating over an arbitrary but fixed field, based on the following inference rules.

1. From polynomial equations $f=0$ and $g=0$ where $f,g in Field[arrow(X)]$ we can derive $alpha f + beta g = 0$ for $alpha, beta in Field$.

2. From polynomial $f=0$ where $f in Field[arrow(X)]$, we can derive $x f=0$ where $x in arrow(X)$.


#definition(title: [Polynomial Calculus Refutations])[

A Polynomial Calculus (PC) refutation of $Axioms$ over $Field$ is a sequence of polynomials $Proof = (t_1, dots, t_ell)$  such that $t_ell = 1$, and for each $i eq.not l$, either (1) $t_i in Axioms$, or (2) $t_i$ is derived from $(t_j)_(j < i)$ using the above rules.
The degree of the proof is given by $Degree(Proof) = max_(i in l) Degree(t_i)$. 
If we let $Pi$ denote the set of all PC refutations of $Axioms$, then

  #math.equation(block:true, numbering: none)[
  $
  Degree(Axioms PC bot) := min_(Proof in Pi) Degree(Proof)
  $
  ]

]<def:poly-calc-refutations>

To ensure Boolean variables, we assume the axioms $Axioms$ always contain the equations $x_i^2 - x_i=0$ and $overline(x)^2_i - overline(x)_i = 0$ for all $i in [n]$. 
Equivalently, we can also just work in the ring $Field[x_1, dots, overline(x)_n]\/(x_1^2 - x_1, dots, overline(x)_n^2 - overline(x)_n)$ of multi-linear polynomials.
Multi-linearity implies that the degree of any proof can be at most $n$ i.e. a proof of degree $Omega(n)$ is the largest lower bound one can hope to achieve.
Additionally, we will also assume that $1 - x_i - overline(x)_i=0$ is also included in $Axioms$, for all $i in [n]$, which ensures that the bar elements are bit complements of the non-bar elements.
The following lemma is by #citet(<buss1999linear>) and gives an instance where perfect matching is hard to refute in the worst case. 
#lemma(title: [Worst Case Hard Instance For PC])[
Given any odd $n in NN$, there exists a graph $H$ with $n$ vertices and maximum degree $MaxDegree(H)= 5$ such that Polynomial Calculus over any field of characteristic different from 2 requires degree $Theta(n)$ to refute $Card(H, arrow(1))$.
]<lemma:worst-case-instance-PC>

A description of the  worst case hard instance for SoS can be found in @Austrin_2022[Theorem A.3] which is also derived from @buss1999linear.

#lemma(title: [Worst Case Hard Instance For SOS])[
Given any odd $n in NN$, there exists a graph $H$ with $n$ vertices and maximum degree $MaxDegree(H)= 5$ such that SoS refutations requires degree $Theta(n)$ to refute $Card(H, arrow(1))$.
]<lemma:worst-case-instance-sos>

An important lemma we will need is that given a set of axioms $Axioms$ over the ring $Field[x_1, dots, x_n]$, a partial assignment of variables can only make refuting $Axioms$ easier.
Given a set of $m$ polynomial equality constraints $Axioms$ over boolean variables ${x_1, dots, x_n}$, let the family of functions ${f_i: {0,1}^n -> {"True", "False"} }_(i in [m])$, denote predicates for satisfiability for each constraint.
For example, given $alpha in {0,1}^n$, $f_i (alpha) = "True"$ if the $i$'th polynomial constraint $axiomSmall_i in Axioms$ is satisfied i.e $q_i (alpha) = 0$.
We say $Axioms$ is satisfied if there exists $ alpha in {0,1}^n$ such that $f_i (alpha) = "True" <=> axiomSmall_i (alpha)=0$ for all $i in [m]$.
Given a map $rho: {x_1, dots, x_n } -> {x_1, dots, x_n, overline(x)_1, dots, overline(x)_n, 1, 0 }$, the restriction of a function $f: {0,1}^n -> {0,1}$, denoted by $f|_rho$, is defined as $f|_rho (x_1, dots, x_n) = f(rho(x_1), dots, rho(x_n))$.
Similarly, the restriction of formula $Axioms$ is defined as $Axioms|_rho = {f_{1}|_rho, dots, f_{m}|_rho }$.
Two formula $Axioms$ and $Axioms'$ are equivalent if they are element-wise equal, ignoring any functions that are constantly $"True"$.
For example, $Axioms = {f_a, f_b, "True" }$ and $Axioms' = {f_a, f_b}$ are equivalent, denoted as $Axioms equiv Axioms'$.


#definition(title: [Affine Restriction])[
We say that an axiom $Axioms'$ is an
affine restriction of $Axioms$ if there is a map $rho : {x_1,dots,x_n} -> {x_1, dots, x_n, overline(x)_1, dots, overline(x)_n, 1, 0 }$ such that $Axioms equiv Axioms|_(rho)$.

]<def:affine-restriction>

#lemma[Let $Axioms, Axioms'$ be axioms such that $Axioms'$ is an affine restriction of $Axioms$, and each axiom
#show heading: set block(below: 2em)
of $Axioms$ depends on a constant number of variables, then

- For any arbitrary but fixed $Field$ it holds that $Degree(Axioms PC bot) in Omega(Degree(Axioms' PC bot))$

- $Degree(Axioms SOS bot) in Omega(Degree(Axioms' SOS bot))$

]<lemma:affine-restriction>

The proof for @lemma:affine-restriction[Lemma] can be found in @Austrin_2022[~see Lemma 2.2].
What the above lemma says is that if we have a graph $G$ with odd vertices with constant degree, that has a perfect matching on a subset of even vertices on the graph, then the size of the proof to refute $PM(G)$ is at least as large as refuting a perfect matching in $G$ with the even vertices removed.


== Graph Theory Preliminaries<sec:graph-theory-prelims>

We use standard graph theoretic notation. For a graph $G$, we use $V(G)$ and $E(G)$ to denote the vertices and edges of $G$. 
For a vertex $v in V(G)$, we use $Neighbourhood(G, v) = { u in V(G) : (u,v) in E' }$ to denote the neighbourhood of $v$ in $G$, and $degree(G, v) := |Neighbourhood(G, v)|$.
Given two sets $S, T subset.eq V(G)}$, we  use $CutEdges(S, T, G)$ to denote the number of edges in $G$ with one endpoint in $S$ and one endpoint in $T$.  
Note that we do not require $S$ and $T$ to be disjoint; in case they are not disjoint, every edge with both endpoints in $S inter T$ is counted twice in $CutEdges(S, T, G)$. 
If the graph $G$ is clear from the context, we omit the subscript. 
Given two vertices $u$ and $v$, we use $u ~> v$ to denote the sequence of edges in the path from $u$ and $v$. 
Given $W subset.eq V(G)$, we denote with $G[W]$ the subgraph of $G$ induced by $W$. We say that a subgraph $G' subset.eq G$ is _spanning_ if $V(G') = V(G)$.
Next, we give a definition of pseudorandom graphs.

#definition(title: [$(n, d, lambda)$-graphs])[
Let $G$ be a $d$-regular graph on $n$ vertices, and, let $lambda_1 >= lambda_2 >= dots >= lambda_n$ denote eigenvalues of the adjacency matrix of $G$.
We say $G$ is an $(n, d, lambda)$-graph if $lambda(G) := max_( 2, dots, n) max |lambda_i| <= lambda $.

]<def:expander-graphs>

The following is a well known result of #citet(<alon88mixing>).

#lemma(title: [Expander Mixing Lemma])[
  Given an $(n, d, lambda)$-graph $G$, for any $S, T subset.eq V(G)$ we have

#math.equation(block: true, numbering: none)[
$
  abs(CutEdges(S, T, G) - d/n abs(S)abs(T)) <= lambda sqrt(abs(S)abs(T))
$
]

]<lemma:expanders-mixing-lemma>


We make use of the following two well known criteria of Tutte @tutte1952factors@tutte1947factorization. 
Note that both of the lemmata ask for properties which are stronger than what Tutte criteria requires#footnote[More specifically, in the Tutte criterion $q(G)$ denotes the number of _odd_ sized connected components.]; however, they are easier to state and verify in our application. We denote with $q(G)$ the number of connected components in a graph $G$.

#lemma(title: [Tutte's Criterion])[
If a graph $G$ has _even_ number of vertices and for every subset $S subset.eq V(G)$ we have $OddComponents(G without S) <= |S|$, then $G$ contains a perfect matching.
]
<lemma:tutte-criterion>

#lemma(title: [Tutte's Generalised Criterion])[
  Let $f in NN$ be even. Suppose $G$ is a graph such that for every pair of disjoint sets $S, T subset.eq V(G)$ the following holds:

#math.equation(block: true, numbering: none)[
  $
  OddComponents(G without (S union T)) <= abs(S)f - sum_(w in T) (f - abs(Neighbourhood(G, w) without S))
  $]
  Then $G$ contains a spanning subgraph $G' subset.eq G$ which if $f$-regular.
]<lemma:tutte-criterion-factor>


== Probabilistic Tools 

Next we introduce standard tools for randomised algorithms.
A dependency graph for a set of events $E_1, dots, E_n$ is a graph $G=(V, E)$ such that $V = {1 dots, n }$ and,  for $i= 1, dots, n$, event $E_i$ is mutually independent
of the events ${E_j | (i, j) in.not E}$. 
The degree of the dependency graph is the maximum degree of any vertex in the graph.

#lemma(title: [Lov#[á]sz Local Lemma])[
Let $E_1,...,E_n$ be a set of events over some probability space with probability $dist$, and assume that for some $beta in (0,1)$ the following hold:

- The degree of the dependency graph given by $(E_1, dots, E_n)$ is bounded by $d$.

- For all $i in [n]$, $PPr(E_i, E_i <-\$ dist) <= beta$.

- $beta <= 1/(4d) $. 

Then $Pr( inter_(i=1)^n E_i ) > 0$


]<lemma:lll>

#lemma(title: [Multiplicative Chernoff bound])[
Suppose $X_1, ..., X_n$ are identical independent random variables taking values in ${0, 1}$. Let $X$ denote their sum and let $mu = n Exp(X_1)$ denote the sum's expected value. Then, for any $0 < delta < 1$, we have

#math.equation(block: true, numbering: none)[
$
Pr(|X - mu| >= delta mu) <= 2 e^(- (delta^2 mu)\/3)
$]


]<lemma:mult-chernoff>

The proof of @lemma:mult-chernoff and @lemma:lll
can be found in any textbook on randomised algorithms (for example, see @mitzenmacher2017probability[~see Ch. 1 and 7]). 


@thm:partition is originally by @Austrin_2022[~see Lemma 4.3], re-derived here for completeness.

#lemma(title: [Partition Theoem])[
For every $0 < c < 1$ and $gamma> 0$, there exists $d_0$ such that the following holds. If $G$ is a $d$-regular graph, for some $d >= d_0$, then there exists a subset $A subset.eq V(G)$ such that
$
    c d - gamma d <= abs(Neighbourhood(G, v) inter A ) <= c d + gamma d 
$
for every $v in V(G)$.

]<thm:partition>
#proof[
We prove the existence of such a partition $A subset.eq V(G)$ using the probabilistic method.
For each $v in V(G)$, we toss an independent coin $X_i$ with bias $c$.
We include $v$ in $A$ if and only if $X_i = 1$. Thus, $arrow(X) := (X_1, dots, X_n) in {0,1}^n$ is a random variable that describes how we choose $A$. 
For any $v in V$, let $Y_v := abs(Neighbourhood(G, v) inter A)$ denote the random variable that counts the number of neighbours of $v$ in $A$.
Define $delta := gamma / c$, and for every $v in V$ let $E_v = bb(1)(abs(Y_v - d c ) >= delta c d)$ denote the bad event that $v$ has too many or too few neighbours in $A$.
Observe that the dependency graph of events ${ E_v }_{v in V}$ has maximum degree at most $d^2$ (only vertices at most two hops away from $v$ affect how many of $v$'s neighbours are in $A$; there at most $d^2$ such vertices).
As $G$ is $d$-regular, $EExp(Y_v, arrow(X)) = c d$. 
By the @lemma:mult-chernoff[Lemma], for any $v in V$ we have $PPr(E_v, arrow(X)) <= 2e^(-delta^2c d\/3) =: beta$.
For $d$ sufficiently large we have $beta <= 1/(4d^2)$, and so $beta d^2 <= 1/4$.
All the conditions of @lemma:lll[Lemma] are satisfied, from which we conclude that, with positive probability, none of the bad events happen. 
This implies the desired $A subset.eq V(G)$ exists.
]


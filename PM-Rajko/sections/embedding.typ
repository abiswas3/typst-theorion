#import "/conf_templates/conf.typ": conf
#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
// #import cosmos.simple: *


= Topological embedding <sec:embed-machinery>

In this section we describe the topological embedding result of #citet(<draganic22rolling>). 
We start with a necessary definition.

#definition(title: [Sub-divisions])[
Given a graph $H$ and a function $sigma: E(H) -> NN$, the $sigma$-subdivision of $H$, denoted by $H^sigma$, is the graph obtained by replacing each edge in $E(H)$ with a path of length $sigma(e)$ joining the end points of $e$ such that all these paths are mutually vertex disjoint, except at the end points.

]<def:subdivisions>

If a graph $G$ contains $H^{sigma}$ for some $sigma: E(H) -> NN$, then we say $G$ contains $H$ as a _topological minor_. 
In our application, it will be important that we can control the parity of $sigma(e)$. 
The following result follows directly from @draganic22rolling[~see Theorem 1]. 

#theorem(title: [Embedding Theorem])[
For every $D in NN$ there exist $alpha, xi, C > 0$, such that the following holds.
Suppose $G$ is a graph with $n$ vertices and $m >= C n$ edges such that for every pair of disjoint subsets $S, T subset.eq V(G)$ of size $|S|, |T| >= xi n$, we have

#math.equation(block: true, numbering: none)[
$
abs( e_{G}(S, T) - |S||T|p) <= xi |S||T| p 
$]


where $p = m \/ binom(n, 2)$. 
Then $G$ contains $H^(sigma)$, where $H$ is any graph with maximum degree at most $D$, $H^sigma$ has at most $alpha n$ vertices, and $sigma(e) >= log n$ for every $e in E(H)$.
]<thm:embedding_top>

When $G$ is an $(n, d, lambda)$ graph, we will we make use of @thm:embedding_top[Theorem] to show that $G$ satisfies the required properties, thereby contains $H$ as a topological minor.
This gives us the following corollary.

#corollary[
  For every $D in NN}$ there exist $d_0, n_0 in NN, epsilon, alpha in (0,1)$, such that the following holds. 
  Suppose $G$ is an $(n,d, lambda)$-graph where $d >= d_0$, and $lambda < epsilon d$, and $n >= n_0$. 
  Let $B subset.eq V(G)$ be a subset of size $|B| >= n/20$, and $H$ is any graph with maximum degree at most $D$ and at most $alpha n/(log n)$ vertices.
Then the induced sub-graph $G[B]$ contains $H^(sigma)$ such that $sigma(e)$ is odd for every $e in E(H)$.
]<cor:embedding-top>

#proof[
  Let $m$ denote the number of edges in the induced subgraph $G[B]$, which gives us $2m = CutEdges(B, B, G)$.
Denote $b := abs(B)$ and define $p = m \/ binom(b, 2)$. 
By the @lemma:expanders-mixing-lemma[Lemma], we have

$
abs(2m - d/n  b^2 ) <= lambda b #<eq:test>
$

Dividing both sides with $b(b-1)$, and observing that $(d b^2)/(n(b-1)b) = (d/n)(b/(b-1)) = d/n (1 + 1/(b-1))$, we further get
$
abs( (2m)/(b(b-1)) - d/n - d/(n(b-1)) ) <= (lambda)/(b-1)  #<eq:eml-post-process>
$
From this we have 
$
abs( p - d/n ) &= abs( p - d/n - d/(n(b-1)) + d/(n(b-1)) )   \
                                &<= abs( p - d/n - d/(n(b-1))) + 1/((b-1)) #<eq:triangle>\
                                &<= lambda/((b-1)) + 1/(b-1)  #<eq:final> \
  &<= (2lambda)/(b)
  
$ 


Let us briefly justify each step: @eq:triangle comes from the triangle inquality and  $d/n <= 1$;
Equation @eq:final comes from Equation @eq:eml-post-process;
the last inequality comes from the assumption that $b in Omega(n)$, so the inequality holds for $n$ large enough.\
Let $xi$ be as given by the @thm:embedding_top[Theorem].
Using the bound on the difference between $p$ and $d/n$, for every disjoint subsets $S, T subset.eq B$ of size $|S|,|T| >= xi n$, for $lambda < epsilon d$ where $epsilon$ is sufficiently small, we have

$
abs(CutEdges(S, T, G)  - p|S||T|)  &<= abs(CutEdges(S, T, G) - d/n|S||T|) + abs(d/n|S||T| - p|S||T|) \
                                    &<= lambda sqrt(|S||T|) + (2 lambda)/b |S||T| <= xi |S||T|p 
$

With the lower bounds on $S,T$ and $B$, we can make $epsilon$ sufficiently small with respect to $xi$ to get the upper bound in the last step.
Let $sigma: E(H) -> NN$ be the constant function where $sigma(e)$ is the smallest odd integer larger than $log n$. 
As $G[B]$ has at least $C n$ edges (by the @lemma:expanders-mixing-lemma[Lemma]), $sigma(e) <= 2 + log n$, and $H$ has at most $alpha n/(log n)$ vertices, we can invoke the @thm:embedding_top[Theorem] to conclude that $G[B]$ contains $H^sigma$.

]




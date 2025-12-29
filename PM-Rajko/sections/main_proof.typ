#import "/conf_templates/conf.typ": conf
#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *


= Proof of Theorem @thm:general-hardness-result <sec:main-proof>

In this section we prove @thm:general-hardness-result[Theorem].
As $Card(G, arrow(t)) equiv Card(G, arrow(d)-arrow(t)))$, without loss of generality we only prove the theorem for $t <= d\/2$. 
Let $G=(V,E)$ be an $EnDeeLambda$-graph on an odd number of vertices with $lambda < epsilon d$, where $epsilon < 1\/(100C^(3/2))$ and $C=6$. 
For sufficiently small constant $alpha in (0,1)$, let $HardInstance$ denote the graph on $h=alpha n/(log n)$ vertices as given by @lemma:worst-case-instance-sos (to show lower bounds for PC, we use $H$ from @lemma:worst-case-instance-PC). 
Recall that any SoS proof which refutes $PM(H)$ has degree $Omega(h)$. 
We now make use of $H$ to show the hardness of refuting $Card(G, arrow(t)))$.
The idea is to find a restriction $rho$ such that $Card(G, arrow(t))|_rho equiv PM(H)$.
We achieve this through the following steps.

- Invoke @thm:partition with parameters $c=0.925$ and $gamma = 0.025$ to get subsets $A subset.eq V(G)$ and $B = V(G) without A$, such that for every $u in V(G)$ we have

$
0.9d  &<=   abs(Neighbourhood(G, u) inter A) <= 0.95d #<eq:sizenbrA> \
0.05d  &<=   abs(Neighbourhood(G, u) inter B) <= 0.1d #<eq:sizenbrB>

$

- From equations @eq:sizenbrA and @eq:sizenbrB, $abs(B) > n/20$, with room to spare and $abs(E(G[B])) >= (n d)/20$. By Corollary @cor:embedding-top, $G[B]$ contains $H^(sigma)$ such that each $sigma(e)$ is odd. Let us denote a subgraph of $G[B]$ corresponding to $H^(sigma)$ by $G_(EmbeddingFunc)$. We can describe $G_EmbeddingFunc$ as a function $EmbeddingFunc: V(H) -> B$ together with a collection of pairwise vertex-disjoint (other than at the endpoints) paths  $Embedding(u) ~> Embedding(v)$ in $G[B]$, for $(u,v) in E(H)$. Observe that it is at least as hard to refute#footnote[Note that this by itself does not guarantee it is hard to refute $PM(G)$. We need item (3) and this to show hardness of refuting $PM(G)$.] $PM(G_(EmbeddingFunc))$ as it is to refute $PM(H)$. To see why, let $y_1, dots, y_(E(H))$ denote the variables for the $PM(H)$ formulae for each edge of $H$. We use as shorthand $cal(Y) = (y_e)_(e in E(H))$ and $overline(cal(Y)) = (overline(y)_e)_(e in E(H))$. Define a mapping $rho':E(G_EmbeddingFunc) -> {0,1, cal(Y), overline(cal(Y))}$ as follows.  For each $(u,v) in E(H)$, let $rho'(x_e) = y_((u,v))$ where $e$ is the first edge on the path $Embedding(u) ~> Embedding(v)$.
 Subsequently, map each variable $x_e$ for $e in Embedding(u) ~> Embedding(v)$ alternately to $y_(u,v)$ or $overline(y)_(u,v)$, such that the edges of the path adjacent to $Embedding(u)$ and $Embedding(v)$ are set to $y_((u,v))$.
 This is always possible as $u ~> v$ has odd length. 
 Observe that $PM(G_EmbeddingFunc)|_(rho') equiv PM(H)$. 

- As $n$ is odd and $abs(V(G_(EmbeddingFunc)))$ is odd, we have that $U = V(G) without V(G_EmbeddingFunc)$ has even size. From @eq:sizenbrA we have that $G[U]$ has minimum degree at least $(9d)/10$. 
 As $lambda < d/50$ (with room to spare), we can invoke @thm:perfect-matching to conclude $G[U]$ has a perfect matching $M$.

- Consider the subgraph $G' subset.eq G$ obtained by deleting all edges $e in E(G_(EmbeddingFunc)) union M$, where $M$ is the perfect matching from the step above. 
 As $MaxDegree(H) <= 5$, every vertex $u in G$ loses at most $5$ edges in this process.
 Thus, we have $MinimalDegree(G') >= d - 5$. As $lambda < epsilon d$, by the @lemma:f-factor we have that $G'$ contains a $(t-1)$-regular spanning subgraph $G''$.

We finally define $rho$ as follows:

#set math.cases(gap: 1em)

#math.equation(block: true, numbering: none)[
$
rho(x_e) := cases(
  rho'(e) & "if"  e in E(G_(EmbeddingFunc)),
  1 & "if" e in M union E(G''),
  0 & "otherwise"
)
$
]


Then $Card(G, arrow(t))|_rho equiv PM(H)$, thus our theorem follows from @lemma:affine-restriction.

// ]


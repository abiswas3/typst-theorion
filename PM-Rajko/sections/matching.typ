#import "/conf_templates/conf.typ": conf
#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 
#import cosmos.fancy: *

= Perfect matching and regular subgraphs <sec:matching-machinery>


As described earlier, the second ingredient in our hardness proof is showing that a certain residual graph contains a perfect matching or a spanning $(t-1)$-regular subgraph. In this section we state and prove these ingredients.

#lemma(title: [Perfect Matching Lemma])[
Let $G$ be an  $(n, d, lambda)$-graph with $lambda < d/50$, and suppose $G' subset.eq G$ satisfies $delta(G') >= 0.9d$. Then for all $S subset.eq V(G')$, $G'without S$ has at most $|S|$ connected components, that is, $OddComponents(G' without S) <= |S|$. Therefore, if $G'$ has an even number of vertices then it contains a perfect matching.
]<thm:perfect-matching>

#proof[
Let $U = V(G')$.  We aim to show that the graph $G' without S$ has at most $|S|$ connected components. If $|S| >= abs(U)\/2$ then $G' without S$ has at most $|S|$ vertices, so the the upper bound on connected components trivially holds. For the remainder of the proof we can assume $abs(S) < abs(U) \/ 2$.
We claim the following:

#note-box(title: [Claim])[$"For every partition" X union Y = U without S, "with" |X|,|Y| >= abs(S)/3$, we have 

   #math.equation(numbering:none, block: true)[
   $
     CutEdges(X, Y, G') >= 1 =>  q(G' without S) <= abs(S) 
   $
    ]
]

#proof(title: [Proof Of Claim])[
To see why, assume towards a contradiction that there exists an edge in $G'$ between _every_ partition $X union Y = U without S$, where $|X|, |Y| >= abs(S)/3$, _and_ $G' without S$ has more than $|S|$ connected components. 
Denote the  vertex sets of these components by $C_1, dots, C_k$, for some $k > |S|$.
Let $X^* := C_1 union dots union C_(s)$ and $Y^* := C_(s+1) union dots union C_(k)$, where $s = floor(|S|\/2)   >= |S|\/ 3$.
By construction, even if each component $C_i$ is a singleton set, we get that  $abs(X^*), abs(Y^*) >= abs(S)/3$.
Now as all $C_i$'s are disjoint connected components, there can be no edge between $X^*$ and $Y^*$.
Therefore, we have found a partition $X^* union Y^* = U without S$ with $|X^*|, |Y^*| >= |S|/3$ without an edge between them, which contradicts our assumption that all appropriately sized partitions have at least one edge between them.
]

To complete our main proof, it suffices to show $CutEdges(X, Y, G') >= 1$ for every partition $X union Y = U without S$ with $|X|, |Y| >= |S|/3$.

Consider some arbitrary partition $X union Y$ of $U without S$, with $|X|, |Y| >= |S|\/3$, and without loss of generality assume $|X| <= |Y|$. 
Then by a simple counting argument we get
$
|X| <= (|U| - |S|)/2 <= (n - |S|)/2  #<eq:upp-X>
$
We have: 
$
CutEdges(X, X, G') + CutEdges(X, S, G') &<= CutEdges(X, X, G) + CutEdges(X, S, G)  \
&<= d/n |X|^2 + lambda |X| + d/n |X||S| + lambda sqrt(|X||S|)        \
 &<= d/n |X| ((n-|S|))/2 + lambda |X| + d/n |X||S| + lambda sqrt(3) |X| #<eq:upper-bound-X>\
&< (d|X|)/ 2 + (d abs(X)abs(S))/(2n) + 3 lambda |X|\
&< d/2 |X| + d/4 |X| + 3 lambda |X| #<eq:smaller-than-one> \
&< tilde(c) |X|  #<eq:upper-bound-S>
$
These steps are justified as follows: 
The first equation follows from the @lemma:expanders-mixing-lemma; @eq:upper-bound-X comes from @eq:upp-X and $|X| >= |S|\/3$;
@eq:smaller-than-one comes from $abs(S) < n/2$; and  @eq:upper-bound-S comes the assumption $lambda < d/50$.
By the assumption $delta(G') > 0.9d$ we conclude that there is an edge in $G'$ with one vertex in $X$ and the other in $V(G') without (X union S) = Y$.

]
The next lemma shows that subgraphs of $(n, d, lambda)$-graphs with large minimum degree contain regular spanning subgraphs.

#lemma(title:[Regular Subgraph Lemma])[
  For every $C > 1$ there exists $d_0 = d_0(C)$ such that the following holds.
Suppose $G$ is an $EnDeeLambda$ graph with $lambda < epsilon d$ and $d >= d_0$, where $epsilon < 1\/(100C^(3/2))$.
If $G' subset.eq G$ has minimum degree $MinimalDegree(G') >= d - C$, then $G'$ contains a spanning $f$-regular subgraph for any even $2 <= f <= d/2$. 
]<lemma:f-factor>

#proof[
  We prove this lemma using  @lemma:tutte-criterion-factor.
  We need to show that for any pair of disjoint sets $S, T subset.eq V(G')$, we have
$
OddComponents(G' without (S union T)) & <= abs(S)f - sum_(w in T) (f - abs(Neighbourhood(G', w) without S)) #<eq:main-goal>
$
  As $epsilon < 1\/(100C^(3/2))$ and $C > 1$, we have that $epsilon < 1\/100$. 
This implies that $G$ is an $EnDeeLambda$ graph with $lambda < d/100$.
We set $d_0 := d_0(C)$ large enough such that for all $d >= d_0$, even after deleting at most $C$ edges incident on each vertex of the $d$-regular graph $G$ to get $G'$, we have the minimum degree of $G'$ to be $MinimalDegree(G') >=  d - C > 9d\/10$.
Therefore the conditions of @thm:perfect-matching are satisfied,
thus
$
OddComponents(G' without (S union T)) <= abs(S union T) = |S| + |T|
$
To prove @eq:main-goal, it suffices to show 
$
|S| + |T|  &<= abs(S) f - Size(T) f + Size(T) (d-C) - CutEdges(S, T, G')  #<eq:to-show> \ 
     &<= |S| f - sum_(w \in T) (f - Size( Neighbourhood(G', w) without S)) 
$
We distinguish a few cases.

#block(  fill: rgb("#eff1f5"),
  inset: 8pt,
  radius: 4pt,)[
*Case 1*: 
Suppose $Size(S) <= Size(T)$. As $f <= d\/2$, we have 
$
Size(S) f + Size(T) (d-C-f)  &>= ( Size(S) + Size(T))(d/2 -C) #<eq:to-show-1>
$

  The condition described by the inequality @eq:to-show is satisfied via the following analysis.
$
  |S| + |T| + CutEdges(S, T, G') &<=  |S| + |T| + |S||T| d/n + epsilon d sqrt(Size(S) Size(T)) #<eq:eml>\
                                 &<= |S| + |T| + d/4 (Size(S) + Size(T)) + epsilon d 1/2 (Size(S) + Size(T)) #<eq:algebra>\
                                &<= (Size(S) + Size(T))(d/4 + 1 + (epsilon d)/(2)) \
                                 &<  (Size(S) + Size(T)) (d/2-C) #<eq:eps-assumption> \
                                 &<= Size(S) f - Size(T)(d-C-f) #<eq:plug>
$
@eq:eml comes from the @lemma:expanders-mixing-lemma and $lambda < epsilon d$, together with an obvious upper bound $e_(G')(S, T) <= e_G(S, T)$.
Equation @eq:algebra comes from the fact that $Size(S) Size(T) <= ((Size(S)+Size(T))/2 )^2 <= n ((Size(S) + Size(T))) /4$.
@eq:eps-assumption comes from $epsilon < 1\/(100C^(3/2))$, $C >1$ and $d_0$ being sufficiently large. 
@eq:plug follows from @eq:to-show-1 which gives us what we want.



]

#block(fill: rgb("#eff1f5"),
  inset: 8pt,
  radius: 4pt,)[
*Case 2*: Suppose $Size(S) > Size(T)$. As $f >= 2$, we have
$

    Size(S) f +  Size(T)(d-C-f)  & >= 2 Size(S) + Size(T) (d-C-2) #<eq:to-show-2>
$
  To show @eq:to-show, it suffices to show that
$
CutEdges(S, T, G') <= Size(S) + Size(T)(d-C-3) #<eq:to-show-3>
$

Now we distinguish between two subcases.

-    If $Size(T) <= (Size(S))/(C+3)$, then @eq:to-show-3 follows from a trivial bound $CutEdges(S, T, G') <= Size(T) d$.

- $ (Size(S))/(C+3) < Size(T) < Size(S)$. As $Size(S) + Size(T) < n$ we have $Size(S) < n - (Size(S))/(C+3)$, thus $|S| < n<= (C+3)/(C+4) $.
Using the @lemma:expanders-mixing-lemma, we have
$
CutEdges(S, T, G) <= CutEdges(S, T, G') &<= d/n Size(S) Size(T) + epsilon d sqrt(Size(S) Size(T)) 	\
 &< d ((C+3))/((C+4)) Size(T) + epsilon d Size(T)sqrt((C+3)) \
&= |T|d <= ( (C+3)/ (C+4}) + epsilon sqrt(C+3)) \
&< |T|d <= ( (C+3)/(C+4) + 1/ (2(C+4)) )\
&= |T|d<= ( 1 - (1)/(2(C+4))) $
where the penultimate inequality follows from the upper bound on $epsilon$. For $d$ sufficiently large in terms of $C$ we obviously have
$
     |T|d <= (1 - 1/ (2(C+4)) ) < |T|d - |T|(C + 3) < |S| + |T|(d - C - 3)
$ 

hence @eq:to-show-3 is satisfied.

]


]




#import "/conf_templates/conf.typ": conf
#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
// #import cosmos.simple: *

= Related Work <sec:related-work>


In propositional#footnote[As opposed to algebraic proof complexity] proof complexity, there a few prior examples of the strategy of embedding a worst case instance into a host graph to show lower bounds for a larger class of objects @itsykson2021near @pitassi2016PolyLogFrege.
 #citet(<pitassi2016PolyLogFrege>) show Tseitin lower bounds for Frege proof systems  by relying on the embedding result by #citet(<kleinberg1996short>), which allows one to embed any bounded degree graph $H$ of size $O(n\/("poly"(log n)))$ into an expander graph on $n$ vertices as a minor (not necessarily a topological one). 
#citet(<krivelevich2021completeMinors>) simplify and improve the above embedding theorem to allow for embedding any graph $H$ with size $O(n\/log n)$ as an ordinary minor .
However, embedding a hard instance $H$ into $G$ as an ordinary minor does not guarantee that the hardness of $H$ is preserved in the setting considered in this paper. In particular, it is entirely possible that one of the edge contractions to obtain the minor results in $H$ now being easy to refute.
Thus, these embedding theorems cannot be directly applied.
Instead, as described in section @sec:main-proof[Section], one way to preserve hardness is to use  embedding theorems that allow for topological embeddings that allow for edge sub-divisions of odd size @draganic22rolling  @nenadov2023routing.
In order to get a topological embedding, Austrin and Risse modify the ordinary embedding theorem in @krivelevich2021completeMinors but critically rely on the host graph being random.
In this work, we use the embedding theorem by  #citet(<draganic22rolling>), which greatly simplifies the argument. 
Moreover, we avoid the use of the contiguity argument present in @Austrin_2022 by directly utilising Tutte's criterion and the Expander Mixing Lemma.

In summary, we show degree lower bounds for refuting $Card(G, arrow(t))$ for odd $t$ in $(n, d, lambda)$ graphs in the SoS and PC proof systems.
There is still a $log n$ gap between the largest possible proof in such systems, and our lower bounds (similar to @Austrin_2022).
It is not inherently clear that such a gap should exist.
The gap is an artefact of $d$ being constant, which makes the graphs sparse i.e we need $Theta(log n)$ edges to form a path between any two nodes.
This implies, that $Omega(n\/log n)$ is the largest hard instance we can topologically embed in any graph.
Thus, if the worst case lower for refuting perfect matchings was indeed $Omega(n)$, we would need a more direct proof of the statement without using a smaller hard instance.
We leave the issue of resolving the tightness of our lower bound as an open problem for future work.


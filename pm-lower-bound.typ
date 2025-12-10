#import "/conf_templates/conf.typ": conf, abstract
#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 
#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *

#show bibliography: it => {
  show link: set text(blue)
  show link: underline
  it
}
//------------------------------------------------------------
#show link: underline
#show link: set text(rgb("#006633"), weight: "semibold")
#show cite: set text(fill: rgb("#0055AA"), weight: "medium") // citation colour 
#show footnote.entry: set text(fill: rgb("#282828")) // footnote colours
#show ref: set text(fill: rgb("#006633"), weight: "bold") // equation refs colour 

// Equation settings:
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")
//-------------------------------------------------------------

#show: show-theorion

// DELETE
#set heading(numbering: "1.1.1.a")

// #show: conf.with(
//   doc_title : [Refuting Perfect Matchings in Spectral Expanders is Hard],
//   authors: (
//     (
//       name: "Ari Biswas",
//       affiliation: "University Of Warwick",
//       email: "tung@artos.edu",
//     ),
//     (
//       name: "Rajko Nenadov",
//       affiliation: "University Of Auckland",
//       email: "e.deklan@hstate.hn",
//     ),
//   ),
// )
//
#abstract[This work studies the complexity of refuting the existence of a perfect matching in spectral expanders with an odd number of vertices, in the Polynomial Calculus (PC) and Sum of Squares (SoS) proof system.
Austrin and Risse [SODA, 2021] showed that refuting perfect matchings in sparse $d$-regular _random_ graphs, requires with high probability, proofs with degree $Omega(n/(log n))$ in the above proof systems. 
We extend their result by showing the same lower bound holds for *all* $d$-regular graphs with a mild spectral gap.]

#include "/sections/introduction.typ"
#include "/sections/prelims.typ"
#include "/sections/embedding.typ"
#include "/sections/matching.typ"
#include "/sections/main_proof.typ"
#include "/sections/related_work.typ"

#bibliography("bibliography.bib",
             title: "References", 
             style: "association-for-computing-machinery"
             // style : "harvard-cite-them-right"
           )


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
//-------------------------COLOURS----------------------------
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

// Will be overidden in pdf with conf.wth
#set heading(numbering: "1.1.1.a")


#show: conf.with(
  doc_title : [Refuting Perfect Matchings in Spectral Expanders is Hard],
  short_title: "Refuting Perfect Matchings in Spectral Expanders is Hard",
  short_authors: "Ari Biswas and Rajko Nenadov",
  authors: (
    (
      name: "Ari Biswas",
      affiliation: "University Of Warwick",
      email: "tcs@randomwalks.xyz",
    ),
    (
      name: "Rajko Nenadov",
      affiliation: "University Of Auckland",
      email: "rajko.nenadov@auckland.ac.nz",
    ),
  ),
)

#abstract[This work studies the complexity of refuting the existence of a perfect matching in spectral expanders with an odd number of vertices, in the Polynomial Calculus (PC) and Sum of Squares (SoS) proof system.
Austrin and Risse [SODA, 2021] showed that refuting perfect matchings in sparse $d$-regular _random_ graphs, requires with high probability, proofs with degree $Omega(n/(log n))$ in the above proof systems. 
We extend their result by showing the same lower bound holds for *all* $d$-regular graphs with a mild spectral gap.
As a direct consequence, we also positively resolve the open problem posed by Buss and Nordstr\u{00F6}m, which asks, _"Are even colouring formulas over expander graphs hard for polynomial calculus over fields of characteristic distinct from 2 ?"_
]

#include "/PM-Rajko/sections/introduction.typ"
#include "/PM-Rajko/sections/prelims.typ"
#include "/PM-Rajko/sections/embedding.typ"
#include "/PM-Rajko/sections/matching.typ"
#include "/PM-Rajko/sections/main_proof.typ"
#include "/PM-Rajko/sections/related_work.typ"
//
#bibliography("pm-lower-bound.bib",
             title: "References", 
             style: "association-for-computing-machinery"
           )


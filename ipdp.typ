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
  doc_title : [Interactive Proofs For Distribution Testing With Conditional Oracles],
  short_title: "Interactive Proofs For Distribution Testing",
  short_authors: "Ari, Canonne, Bun, Sivakumar",
  authors: (
    (
      name: "Ari Biswas",
      affiliation: "University Of Warwick",
      email: "",
    ),
    (
      name: "Mark Bun",
      affiliation: "Boston University",
      email: "",
    ),
    (
      name: "Cle\u{300}ment Canonne",
      affiliation: "University Of Sydney",
      email: "",
    ),
    (
      name: "Satchit Sivakumar",
      affiliation: "Boston University",
      email: "",
    ),
  ),
)

#abstract[
We revisit the framework of interactive proofs for distribution testing, first introduced by Chiesa and Gur (ITCS 2018), which has recently experienced a surge in interest, accompanied by notable progress (e.g., Herman and Rothblum, STOC 2022, FOCS 2023; Herman, RANDOM~2024). 
In this model, a data-poor verifier  determines whether a probability distribution has a property of interest by interacting with an all-powerful, data-rich but untrusted prover bent on convincing them that it has the property. While prior work gave sample-, time-, and communication-efficient protocols for testing and estimating a range of distribution properties, they all suffer from an inherent issue: for most interesting properties of distributions over a domain of size $N$, the verifier must draw at least $Omega(sqrt(N))$ samples of its own. While sublinear in $N$, this is still prohibitive for large domains encountered in practice.

In this work, we circumvent this limitation by augmenting the verifier with the ability to perform an exponentially smaller number of more powerful (but reasonable) _pairwise conditional_ queries, effectively enabling them to perform "local comparison checks" of the prover's claims.
We systematically investigate the landscape of interactive proofs in this new setting, giving polylogarithmic query and sample protocols for (tolerantly) testing all _label-invariant_ properties, thus demonstrating exponential savings without compromising on communication, for this large and fundamental class of testing tasks.
]

// #include "/PM-Rajko/sections/introduction.typ"
// #include "/PM-Rajko/sections/prelims.typ"
// #include "/PM-Rajko/sections/embedding.typ"
// #include "/PM-Rajko/sections/matching.typ"
// #include "/PM-Rajko/sections/main_proof.typ"
// #include "/PM-Rajko/sections/related_work.typ"
//

#bibliography("ipdp.bib",
             title: "References", 
             style: "association-for-computing-machinery"
           )


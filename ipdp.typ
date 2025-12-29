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


// #show: conf.with(
//   doc_title : [Interactive Proofs For Differential Private Counting],
//   short_title: "IPDP",
//   short_authors: "Ari and Cormode",
//   authors: (
//     (
//       name: "Ari Biswas",
//       affiliation: "University Of Warwick",
//       email: "tcs@randomwalks.xyz",
//     ),
//     (
//       name: "Graham Cormode",
//       affiliation: "University Of Warwck/ Meta AI",
//       email: "g.cormode@warwick.ac.uk",
//     ),
//   ),
// )
//
#abstract[
Differential Privacy (DP) is often presented as a strong privacy-enhancing technology with broad applicability and advocated as a de facto standard for releasing aggregate statistics on sensitive data. 
However, in many embodiments, DP introduces a new attack surface: a malicious entity entrusted with releasing statistics could manipulate the results and use the randomness of DP as a convenient smokescreen to mask its nefariousness. 
Since revealing the random noise would obviate the purpose of introducing it, the miscreant may have a perfect alibi.  
To close this loophole, we introduce the idea of _Interactive Proofs For Differential Privacy_, which requires the publishing entity to output a zero knowledge proof that convinces an efficient verifier that the output is both DP and reliable.
Such a definition might seem unachievable, as a verifier must validate that DP randomness was generated faithfully without learning anything about the randomness itself. 
We resolve this paradox by carefully mixing private and public randomness to compute verifiable DP counting queries with theoretical guarantees and show that it is also practical for real-world deployment. 
We also demonstrate that computational assumptions are necessary by showing a separation between information-theoretic DP and computational DP under our definition of verifiability. 
]
= hello
#lorem(300)

= hello 
#lorem(500):w


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


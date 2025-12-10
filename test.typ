#import "/conf_templates/conf.typ": conf
#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 

#show bibliography: it => {
  show link: set text(blue)
  show link: underline
  it
}

#show link: underline
#show link: set text(blue)
#show cite: set text(fill: rgb("#85144b")) // citation colour 
#show footnote.entry: set text(fill: purple) // footnote colours
#show ref: set text(fill: red) // equation refs colour 

// Equation settings:
#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)")
  
// #import cosmos.fancy: *
// #import cosmos.rainbow: *
#import cosmos.clouds: *
#show: show-theorion

// #show: conf.with(
//   doc_title : [Perfect Matchings now],
//   authors: (
//     (
//       name: "Theresa Tungsten",
//       affiliation: "Artos Institute",
//       email: "tung@artos.edu",
//     ),
//     (
//       name: "Theresa Tungsten",
//       affiliation: "Artos Institute",
//       email: "tung@artos.edu",
//     ),
//
//     (
//       name: "Eugene Deklan",
//       affiliation: "Honduras State",
//       email: "e.deklan@hstate.hn",
//     ),
//   ),
//   abstract_string: lorem(80),
// )
//

= Introduction
== Intro

This is the introduction to your paper. You can write freely here and use all the theorem environments defined in the template.

Is this showing. Not sure why?

The dot product of two vectors $arrow(a)$ and $arrow(b)$ can
be calculated as shown in @dot-product.

$
  < a, b > &= arrow(a) dot arrow(b) \
                       &= a_1 b_1 + a_2 b_2 + ... a_n b_n \
                       &= sum_(i=1)^n a_i b_i. #<sum>
$ <dot-product>

The sum notation in @sum is a useful way to express the dot
product of two vectors.

$samples$ hello \
$getsr$ a lot \
\


#theorem(title: "Euclid's Theorem ")[
  There are infinitely many prime numbers. 
] <thm:euclid>

#theorem-box(title: "Theorem without numbering", outlined: false)[
  This theorem is not numbered.
]


It's really important that this works. It's not broken.
Use good tools. It's imporant. 


Writing an introduction is nice
What about this -- it's great but it's not live -- and i want it to be live.  
== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)


Potential directions for further research.
It was said in #cite(<Cooley65>, form:"year"), but the people that said things were #cite(<Cooley65>, form:"author"), and it was said here #cite(<Cooley65>, form:"normal"). 

#citet(<Cooley65>) did the most unbearable thing.


It was shown in here #citep(<biswas2025refutingperfectmatchingsspectral>).\ 

#citet(<biswas2025refutingperfectmatchingsspectral>) Show \
\
#citeauthor(<biswas2025refutingperfectmatchingsspectral>) showd that this works for any graph#footnote[What do we do when we get there]

https://example.com \

#link("https://example.com")
#link("https://example.com")

Hello this #cite(<biswas2025refutingperfectmatchingsspectral>)#cite(<Cooley65>)

@Cooley65@biswas2025refutingperfectmatchingsspectral 
#bibliography("bibliography.bib",title: "References", style: "chicago-author-date")


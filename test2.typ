#import "/lib.typ": *
#import "/commands.typ": *
#import "@preview/equate:0.3.2": equate // Referencing equations
#import "@preview/lovelace:0.3.0": * // Algorithms 
#import "@preview/cetz:0.4.0": *

#import cosmos.fancy: *
// #import cosmos.rainbow: *
// #import cosmos.clouds: *
#show: show-theorion

#let conf(
  doc_title: [],
  abstract_string: [],
  doc,
) = {
    set document(title: [
    #doc_title
    ])

    set page(
      paper: "us-letter",
      // header: align(right, context document.title),
      header: context {
          let page = counter(page).get().first()
          let body = if page == 1 [] 
                     else if calc.odd(page) [1safsf]
                     else [2ss]
          let alignment = if calc.odd(page) { right } 
                          else { left }
          align(alignment, body)
  },
      numbering: "1",
      columns: 1,    
      )


    set par(justify: true)
    set text(
      font: "Libertinus Serif",
      size: 12pt,
      )
    set heading(numbering: "1.1.1.1")

    show title: set text(size: 17pt)
    show title: set align(center)
    show title: set block(below: 1.2em)
    
    // Make a function
  title()
  // let count = authors.len()
  // let ncols = calc.min(count, 3)
  // grid(
  //   columns: (1fr,) * ncols,
  //   row-gutter: 24pt,
  //   ..authors.map(author => [
  //     #author.name \
  //     #author.affiliation \
  //     #link("mailto:" + author.email)
  //   ]),
  // )
  //
  // abstract(abstract_string)

  doc
}

#show: conf.with(doc_title: [HELLO], abstract_string: [Small abstarct]) 

== Intro

This is the introduction to your paper. You can write freely here and use all the theorem environments defined in the template.

$samples$ hello \
$getsr$ a lot \
\


#theorem(title: "Euclid's Theorem")[
  There are infinitely many prime numbers.
] <thm:euclid>

#theorem-box(title: "Theorem without numbering", outlined: false)[
  This theorem is not numbered.
]


It's really important that this works. It's not broken.
Use good tools. It's imporant. 

#lorem(5000)

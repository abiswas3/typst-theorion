// HELPERS
#let abstract(content) =  align(center)[
  #set par(justify: true)
  #align(center)[*ABSTRACT*] 
  #text(font: "Libertinus Serif", size: 0.9em)[#content]
]

#let conf(
  doc_title: [],
  authors: (),
  abstract_string: [],
  doc,
) = {

    set document(title: [
    #doc_title
    ])

    // show: equate.with(breakable: true, sub-numbering: true)
    // set math.equation(numbering: "(1.1.1)")
 
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
  let count = authors.len()
  let ncols = calc.min(count, 3)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 24pt,
    ..authors.map(author => [
      #author.name \
      #author.affiliation \
      #link("mailto:" + author.email)
    ]),
  )

  // abstract(abstract_string)

  doc
}

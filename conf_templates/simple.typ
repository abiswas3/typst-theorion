// HELPERS
#let abstract(content) =  align(left)[
  #set par(justify: true)
  #align(center)[*ABSTRACT*] 
  #content
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


    set page(
      paper: "us-letter",
      header: align(right, context document.title),
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
  
  abstract(abstract_string)

  doc
}

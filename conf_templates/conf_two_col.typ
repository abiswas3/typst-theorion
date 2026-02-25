/// Two-column conference paper template.
/// Usage: #show: conf-two-col.with(doc_title: [...], abstract: [...], authors: (...))
/// The abstract is passed as a parameter so it renders full-width before the 2-col body.

#let conf-two-col(
  doc_title: [],
  short_title: "",
  short_authors: "",
  authors: (),
  abstract: [],
  doc,
) = {
  set document(title: [#doc_title])

  set page(
    paper: "us-letter",
    header: context {
      let page = counter(page).get().first()
      let body = if page == 1 []
                 else if calc.odd(page) [#text(fill: rgb("#555555"), style: "italic", size: 0.8em)[#short_title]]
                 else [#text(fill: rgb("#555555"), style: "italic", size: 0.8em)[#short_authors]]
      let alignment = if calc.odd(page) { right } else { left }
      align(alignment, body)
    },
    numbering: "1",
  )

  set par(justify: true)
  set text(
    font: "New Computer Modern",
    // font: "Libertinus Serif",
    size: 10pt,
  )
  set heading(numbering: "1.1.1.1")
  show heading: set block(below: 0.8em)

  // ── Title (full width) ──
  align(center)[
    #text(size: 16pt, weight: "bold")[#doc_title]
    #v(0.6em)
    #grid(
      columns: (1fr,) * calc.min(authors.len(), 3),
      column-gutter: 1em,
      ..authors.map(author => align(center)[
        #author.name \
        #text(size: 0.85em, style: "italic")[#author.affiliation] \
        #text(size: 0.85em)[#link("mailto:" + author.email)]
      ])
    )
  ]

  v(1em)

  // ── Abstract (full width) ──
  if abstract != [] {
    align(left)[
      #set par(justify: true)
      #align(center)[*ABSTRACT*]
      #text(font: "New Computer Modern", size: 0.85em)[#abstract]
    ]
    v(1em)
  }

  // ── Body in two columns (no page break) ──
  columns(2, doc)
}

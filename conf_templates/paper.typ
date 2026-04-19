#let _navy = rgb("#1C4882")

// --- Abstract function ---
#let abstract(body) = {
  align(center, text(size: 10pt, weight: "bold")[Abstract])
  v(0.3em)
  pad(x: 3em)[
    #set text(size: 9.5pt)
    #set par(justify: true, leading: 0.5em, first-line-indent: 0pt)
    #body
  ]
  v(1em)
}

// --- Main template ---
#let paper(
  title: [],
  short-title: "",
  short-authors: "",
  authors: (),
  doc,
) = {
  // Page geometry
  set page(
    paper: "us-letter",
    margin: (x: 1in, top: 1in, bottom: 1in),
    header: context {
      let page = counter(page).get().first()
      let body = if page == 1 []
                 else if calc.odd(page) [#text(fill: rgb("#555555"), style: "italic", size: 0.8em)[#short-title]]
                 else [#text(fill: rgb("#555555"), style: "italic", size: 0.8em)[#short-authors]]
      let alignment = if calc.odd(page) { right } else { left }
      align(alignment, body)
    },
    numbering: "1",
  )

  // Fonts
  set text(font: "TeX Gyre Pagella", size: 10pt)
  set par(leading: 0.58em, justify: true)
  show math.equation: set text(font: "TeX Gyre Pagella Math")

  // Footnotes
  show footnote.entry: set text(size: 8pt)
  show footnote.entry: set par(leading: 0.45em)

  // Inline code
  show raw.where(block: false): box.with(
    fill: _navy.lighten(94%),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )
  show raw.where(block: false): set text(fill: _navy.darken(10%), size: 0.9em)

  // Block code
  show raw.where(block: true): it => block(
    fill: _navy.lighten(96%),
    inset: 1em,
    radius: 0.4em,
    width: 100%,
    text(size: 7.5pt, it),
  )

  // Figures
  show figure.caption: set text(size: 8.5pt, fill: rgb("#607D9B"))
  show figure.caption: pad.with(x: 10%)

  // Lists
  set list(marker: text(fill: _navy, size: 0.45em)[#sym.circle.filled])

  // Headings
  set heading(numbering: "1.1.1.1")
  show heading.where(level: 1): set text(size: 12pt, weight: "bold", fill: _navy)
  show heading.where(level: 1): set block(above: 4em, below: 2em)
  show heading.where(level: 2): set text(size: 10.5pt, weight: "bold", fill: _navy)
  show heading.where(level: 2): set block(above: 3.5em, below: 1.5em)
  show heading.where(level: 3): set text(size: 10pt, style: "italic", weight: "regular", fill: _navy)
  show heading.where(level: 3): set block(above: 3em, below: 1.2em)

  // === Title ===
  v(1em)
  align(center, text(font: "Inter", size: 14pt, weight: "bold", fill: _navy, title))
  v(1em)

  // === Authors ===
  pad(x: 0em)[
    #set text(size: 8.5pt)
    #for (i, author) in authors.enumerate() {
      [#text(font: "Inter", size: 8.5pt)[#author.name],
       #text(style: "italic")[#author.affiliations],
       #link("mailto:" + author.email)]
      if i < authors.len() - 1 { linebreak() }
    }
  ]
  v(0.8em)

  doc
}

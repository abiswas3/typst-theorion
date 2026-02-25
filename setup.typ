#import "@preview/equate:0.3.2": equate

/// Common show/set rules shared across all paper and notes projects.
///
/// Parameters:
///   heading-numbering: heading numbering format (default "1.1.1.a" for papers)
///   equation-numbering: equation numbering format (default "(1.1)")
#let paper-setup(
  heading-numbering: "1.1.1.a",
  equation-numbering: "(1.1)",
  doc,
) = {
  show bibliography: it => {
    show link: set text(blue)
    show link: underline
    it
  }

  // Accent colours — Badger Red: #C5050C
  // urls/links: blue (#1e66f5)
  // cites:      blue, slightly lighter
  // refs:       rose-pink from Badger Red family
  // footnotes:  near-black
  show link: underline
  show link: set text(rgb("#006FA6"), weight: "semibold")       // Pilot Iroshizuku Kon-peki
  show cite: set text(fill: rgb("#006FA6").lighten(10%), weight: "medium") // prev: rgb("#1e66f5")
  show footnote.entry: set text(fill: rgb("#282828"))
  show ref: set text(fill: rgb("#0369a1"), weight: "bold")
  // prev ref colour: rgb("#C5050C").lighten(18%) rose-pink, before that rgb("#006633") green

  show math.equation: set text(font: "New Computer Modern Math")
  // show math.equation: set text(font: "Garamond Math")       // beautiful, needs install
  // show math.equation: set text(font: "TeX Gyre Pagella Math") // palatino-style, needs install

  show: equate.with(breakable: true, sub-numbering: true)
  set math.equation(numbering: equation-numbering)

  set heading(numbering: heading-numbering)

  doc
}

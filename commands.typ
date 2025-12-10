// commands.typ - Custom macros and commands
// commands.typ - Custom macros and commands

// Samples arrow: ← with $ above it
#let samples = $arrow.l.long^("A😄")$

// True function: Script D with argument
#let True(x) = $cal(D)(#x)$

// Additional common cryptography/probability macros you might need:

// Random sampling
// #let getsr = $attach(arrow.l.long, br: #emoji.die)$  // ← with 🎲
#let getsr = $arrow.l.long #h(0.1em) "🎲"$
// Distributions
#let Dist(x) = $cal(D)(#x)$
#let dist = $cal(D)$
#let col(x) = text(fill: red, $cal(D)(#x)$)

// Negligible function
#let negl(x) = $sans("negl")(#x)$

// Polynomial
#let poly(x) = $sans("poly")(#x)$

// Advantage
#let Adv(x, ..args) = {
  if args.pos().len() > 0 {
    $sans("Adv")^(#x)_(#args.pos().join(","))$
  } else {
    $sans("Adv")^(#x)$
  }
}

// Probability
#let Pr(x) = $sans("Pr")[#x]$
#let PPr(x, y) = $sans("Pr")_(#y)[#x]$

// Expectation
#let Exp(x) = $bb(E)[#x]$
#let EExp(x, y) = $bb(E)_(#y)[#x]$

#let citet(label) = cite(label, form: "prose")
#let citeauthor(label) = cite(label, form: "author")
#let citeyear(label) = cite(label, form: "year")
#let citep(label) = cite(label, form: "normal")

// Security parameter
#let secpar = $lambda$
#let secparam = $1^lambda$

// Common sets
#let NN = $bb(N)$
#let ZZ = $bb(Z)$
#let QQ = $bb(Q)$
#let RR = $bb(R)$
#let CC = $bb(C)$

// Concatenation
#let concat = $||$

// XOR
#let xor = $xor$

// Computational indistinguishability
#let compind = $approx.eq^c$

// Statistical indistinguishability  
#let statind = $approx.eq^s$

// ----------------
#show bibliography: it => {
  show link: set text(blue)
  show link: underline
  it
}
#show label("b"): set text(red)
#show cite: set text(fill: rgb("#85144b"))
#show cite: it=>{
  show footnote.entry: set text(fill: red)
  it
}
#show ref: set text(fill: red) // Makes all refs red

// PM -matching specific 
#let Proof = $pi$
#let CoNP = text(font: "New Computer Modern Math")[CoNP]
#let NP = text(font: "New Computer Modern Math")[NP]
#let P = text(font: "New Computer Modern Math")[P]
#let Axioms = $cal(Q)$
#let axiomSmall = $q$
#let Field = $bb(F)$
#let Degree = text(font: "New Computer Modern Math")[Deg]
#let SOS = $tack.r_(sans(#text(size: 0.7em, "SOS")))$
#let PC = $tack.r_(sans(#text(size: 0.7em, [PC(#$bb(F)$)])))$
#let Card(G, b) = [Card(#G, #b)]
#let PM(G) = [PM(#G)]
#let MaxDegree(G) = $Delta_#G$
#let CutEdges(S, T, G) = $e_(#G)(#S, #T)$
#let Neighbourhood(G, v) = $Gamma_(#G)(#v)$
#let degree(G, v) = $"deg"_(#G)(#v)$
#let OddComponents(S) = $q(#S)$

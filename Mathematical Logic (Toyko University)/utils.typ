#import "@preview/curryst:0.6.0": rule, prooftree, rule-set
#import "@preview/ctheorems:1.1.3": *


#let myenv = thmenv(
  "question", // identifier
  none, // base - do not attach, count globally
  none, // base_level - use the base as-is
  (name, number, body, color: black) => [
    #box(
      inset: (x: 3pt, y: 3pt),
      stroke: 0.8pt,
      baseline: 20%,
      [#number]
    )
    #h(0.5em)
    #body
    #v(0.5em)
  ]
).with(numbering: "1")

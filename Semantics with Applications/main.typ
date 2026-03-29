#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}
#show heading: it => {
  if it.level >= 3{
    block(it.body, above: 1.5em)
  } 
  else {
    it
  }
}
#set heading(numbering: "1.1")
#set text(size: 14pt)

#let my-countor = counter("my-countor")
#show heading.where(level: 1): it => {
  my-countor.step(level: 1)
  it
}
#let mybox(title, body) = {
  my-countor.step(level: 2)
  block(
    width: 100%,
    spacing: 1em,
    // stroke: luma(150),
  )[
    #block(
        below: 1em,
        // stroke: luma(150),
      )[
      #text(
        size: 14pt, 
        font: "MS Gothic",
        // : 10pt,
      )[
        #title #context {
          my-countor.display()
        }
      ]
    ]
    #body
  ]
}
#let Eg(body) = mybox("Example", body)
#let Ex(body) = mybox("Exercise", body)
#let Fact(body) = mybox("Fact", body)
#let Lem(body) = mybox("Lemma", body)

= Inroduction
== Semantic Description Methods
=== Operational Semantics
=== Denotational Semantics
=== Axiomatic Semantics
=== The Complementary View
== The Example Language While
#Ex[
  a
]
#Ex[
  a
]
== Semantics of Expressions
#Eg[
  a
]

#Ex[
  a
]

#Fact[
  a
]

=== Semantic Functions

#Eg[
  a
]

#Eg[
  a
]

#Ex[
  a
]

#Ex[
  a
]

#Ex[
  a
]

#Ex[
  a
]

== Properties of the Semantics

=== Free Variables

#Lem[
  a
]

#Ex[
  a
]

=== Substitutions

#Ex[
  a
]

#Ex[
  a
]

= Operational Semantics
a
#Ex[
  a
]
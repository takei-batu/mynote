#import "@preview/curryst:0.6.0": rule, prooftree, rule-set
#import "@preview/ctheorems:1.1.3": *


#let myenv(
  identifier, // identifier
  head,
  base: "heading",
  base_level: none,
) = thmenv(
  identifier, // identifier
  base, // base - do not attach, count globally
  base_level, // base_level - use the base as-is
  (name, number, body, color: black) => [
    #if not name == none {
      name = [(#name)]
    } else {
      name = []
    }
    #v(0.5em) // 上スペース
    *#head#number*#name#h(0.5em)#body
    #v(0.5em) // 下スペース
  ]
)

#let myid = "mycounter"
#let Thm = myenv(myid, "定理")
#let Def = myenv(myid, "定義")
#let Prop = myenv(myid, "命題")
#let Cor = myenv(myid, "系")

#let Ex = thmenv(
  "ex", // identifier
  none, // base - do not attach, count globally
  none, // base_level - use the base as-is
  (name, number, body, color: black) => [
    #set enum(numbering: "1.")
    #v(0.5em) // 上スペース
    *練習問題 #context counter(heading).display()*#h(0.5em)#body
    #v(0.5em) // 下スペース
  ]
)

// 見本
#let theorem = thmbox(
"theorem", // identifier
"Theorem", // head
fill: rgb("#e8e8f8")
)

#let Proof = thmproof("proof", "証明")
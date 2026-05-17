#import "@preview/cjk-spacer:0.2.0": cjk-spacer

#let conf(doc) = {
  // 和洋混合文章の空白制御
  show: cjk-spacer
  
  // heading
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }
  set heading(numbering: "1.1.1")
  show heading.where(level: 1): set heading(numbering: "第1章")
  show heading: it => {
    it
  }

  // enumerate
  set enum(numbering: "(1) (i)")

  // math
  show math.equation.where(block: true): it => block(width: 100%, it)

  // font of body
  set text(
    lang: "ja",
    font: ("New Computer Modern", "Noto Serif CJK JP", "Noto Serif JP"),
  )
  set page(
    header: [],
    footer: context {
      align(center)[
        #counter(page).display()
      ]
    } 
  )

  // document
  doc
}

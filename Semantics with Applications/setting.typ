#import "@preview/cjk-spacer:0.2.0": cjk-spacer

// 自作カウンタ
#let my-countor = counter("my-countor")

#let conf(doc) = {
  // 和洋混合文章の空白制御
  show: cjk-spacer
  // 見出し
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    it
  }
  show heading: it => {
    if it.level >= 3{
      block(it.body, above: 1.5em)
    } 
    else {
      it
    }
  }
  set heading(numbering: "1.1")
  // 本文の設定
  set text(
    lang: "ja",
    font: ("New Computer Modern", "Noto Serif CJK JP", "Noto Serif JP"),
  )
  show heading.where(level: 1): it => {
    my-countor.step(level: 1)
    it
  }
  // 本文
  doc
}

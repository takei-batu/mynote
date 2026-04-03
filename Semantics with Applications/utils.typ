// 共通の環境
#import "setting.typ":my-countor
#let mybox(title, body) = {
  my-countor.step(level: 2)
  block(
    width: 100%,
    spacing: 1em,
    above: 1.5em,
    // stroke: luma(150),
  )[
    #block(
        below: 1em,
        // stroke: luma(150),
      )[
      #text(
        size: 12pt, 
        font: "MS Gothic",
      )[
        #title #context {
          my-countor.display()
        }
      ]
    ]
    #text(
      // size: 11pt, 
      // font: "Yu Mincho",
    )[
      #body
      #h(1fr) $square$
    ]
  ]
}
#let Eg(body) = mybox("Example", body)
#let Ex(body) = mybox("Exercise", body)
#let Fact(body) = mybox("Fact", body)
#let Lem(body) = mybox("Lemma", body)

// 証明環境
#let proof(box:false, body) = {
  block(
    width: 100%,
    spacing: 1em,
    above: 1.5em,
    
  )[
    #text(font: "Ms Gothic")[証明]：
    #body
    #if box [
      #h(1fr) $square$
    ]
  ]
}

// note環境
#let note(body) = {
  block(
    width: 100%,
    spacing: 1em,
    above: 1.5em,
    // stroke: red,
    fill: luma(230),
    inset: 8pt,
    radius: 4pt,
  )[
    #block(
        below: 1em,
        // stroke: luma(150),
      )[
      #text(
        size: 12pt, 
        font: "New Computer Modern",
        style: "italic",
      )[
        Note
      ]
    ]
    #text(
      // size: 11pt, 
      // font: "Yu Mincho",
    )[
      #body
    ]
  ]
}

// キーワード
#let While = math.bold("While")
#let Int = math.bold("Z")
#let Num = math.bold("Num")
#let Var = math.bold("Var")
#let Aexp = math.bold("Aexp")
#let Bexp = math.bold("Bexp")
#let Stm = math.bold("Stm")
#let State = math.bold("State")
#let zero = math.mono("0")
#let one = math.mono("1")
#let vx = math.mono("x")
#let vy = math.mono("y")
#let vz = math.mono("z")
#let vtrue = math.mono("true")
#let vfalse = math.mono("false")
#let truth = math.bold("T")
#let tt = math.bold("tt")
#let ff = math.bold("ff")
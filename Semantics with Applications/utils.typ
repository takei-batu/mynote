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

#let ass = $"ass"_"ns"$
#let skip = $"skip"_"ns"$
#let comp = $"comp"_"ns"$
#let iftt = $"if"_"ns"^(thin"tt")$
#let ifff = $"if"_"ns"^(thin"ff")$
#let whilett = $"while"_"ns"^(thin"tt")$
#let whileff = $"while"_"ns"^(thin"ff")$
#let cfg(S, s) = $lr(chevron.l #S, thick #s chevron.r)$
#let vskip = math.mono("skip")

#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

#let assT() = rule(
  $cfg(x := a, s) -> s[x |-> cal(A)[|a|]s]$
)

#let skipT() = rule(
  $cfg(vskip, s) -> s$
)

#let compT() = rule(
  [$cfg(S_1, s) -> s'$],
  [$cfg(S_2, s') -> s''$],
  [$cfg(S_1\;S_2, s) -> s''$],
)

#let ifttT(nameflag:false) = rule(
  name: [
    #if nameflag {
      $thick "if" cal(B)[|b|]s = tt$
    }
  ],
  [$cfg(S_1, s) -> s'$],
  [$cfg(mono("if") b mono("then") S_1 mono("else") S_2, s') -> s''$],
)

#let ifffT(nameflag:false) = rule(
  name: [
    #if nameflag {
      $thick "if" cal(B)[|b|]s = ff$
    }
  ],
  [$cfg(S_2, s) -> s'$],
  [$cfg(mono("if") b mono("then") S_1 mono("else") S_2, s') -> s''$],
)

#let whilettT(nameflag:false) = rule(
  name: [
    #if nameflag {
      $thick "if" cal(B)[|b|]s = tt$
    }
  ],
  [$cfg(S, s) -> s'$],
  [$cfg(mono("while") b mono("do") S, s') -> s''$],
  [$cfg(mono("while") b mono("do") S, s) -> s''$],
)

#let whileffT(nameflag:false) = rule(
  name: [
    #if nameflag {
      $thick "if" cal(B)[|b|]s = ff$
    }
  ],
  $cfg(mono("while") b mono("do") S, s) -> s$
)
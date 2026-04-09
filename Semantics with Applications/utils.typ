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
#let vzero = math.mono("0")
#let vone = math.mono("1")
#let zero = math.bold("0")
#let one = math.bold("1")
#let two = math.bold("2")
#let three = math.bold("3")
#let four = math.bold("4")
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
#let trans(S, s1, s2) = $cfg(#S, s1) -> s2$
#let vskip = math.mono("skip")
#let if-else(b, S1, S2) = $mono("if") #b mono("then") #S1 mono("else") #S2$

#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

#let anaryT(P, C) = rule(
  P1,
  C,
)

#let binaryT(P1, P2, C) = rule(
  P1,
  P2,
  C,
)

#let assT(arg, arith, state) = $cfg(arg := arith, state) -> s[arg |-> cal(A)[|arith|]state]$
// rule(
//   $cfg(x := a, s) -> s[x |-> cal(A)[|a|]s]$
// )

#let skipT(state) = $cfg(vskip, state) -> state$
// rule(
//   $cfg(vskip, s) -> s$
// )

#let compT(S1, state1, S2, state2, state3) = rule(
  [$cfg(S1, state1) -> state2$],
  [$cfg(S2, state2) -> state3$],
  [$cfg(S1\;S2, state1) -> state3$],
)

#let ifttT(nameflag:false, bool, S1, state1, S2, state2) = rule(
  name: [
    #if nameflag {
      $thick "if" cal(B)[|bool|]state1 = tt$
    }
  ],
  [$cfg(S1, state1) -> state2$],
  [$cfg(mono("if") bool mono("then") S1 mono("else") S2, state1) -> state2$],
)

#let ifffT(nameflag:false, bool, S1, S2, state1, state2) = rule(
  name: [
    #if nameflag {
      $thick "if" cal(B)[|bool|]state1 = ff$
    }
  ],
  [$cfg(S2, state1) -> state2$],
  [$cfg(mono("if") bool mono("then") S1 mono("else") S2, state1) -> state2$],
)

#let whilettT(nameflag:false, bool, S, state1, state2, state3) = rule(
  name: [
    #if nameflag {
      $thick "if" cal(B)[|bool|]state1 = tt$
    }
  ],
  [$cfg(#S, state1) -> state2$],
  [$cfg(mono("while") bool mono("do") #S, state2) -> state3$],
  [$cfg(mono("while") bool mono("do") #S, state1) -> state3$],
)

#let whileffT(nameflag:false, bool, S, state) = $cfg(mono("while") bool mono("do") #S, state) -> state$
// rule(
//   name: [
//     #if nameflag {
//       $thick "if" cal(B)[|b|]s = ff$
//     }
//   ],
//   $cfg(mono("while") b mono("do") S, s) -> s$
// )

#let five = math.bold("5")
#let seven = math.bold("7")
#let vwhile = math.mono("while")
#let vdo = math.mono("do")
#let vif = math.mono("if")
#let vthen = math.mono("then")
#let velse = math.mono("else")
#let vrepeat = math.mono("repeat")
#let vuntil = math.mono("until")
#let repeattt = $"repeat"_"ns"^(thin"tt")$
#let repeatff = $"repeat"_"ns"^(thin"ff")$
#let vfor = math.mono("for")
#let vto = math.mono("to")
#let fortt = $"for"_"ns"^(thin"tt")$
#let forff = $"for"_"ns"^(thin"ff")$
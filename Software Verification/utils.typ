#import "@preview/curryst:0.6.0": rule, prooftree, rule-set
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
      // #h(1fr) $square$
    ]
  ]
}
#let Eg(body) = mybox("Example", body)
#let Ex(body) = mybox("Exercise", body)
#let Asg(body) = mybox("Assignment", body)
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

#let vwhile = math.mono("while")
#let vdo = math.mono("do")
#let vskip = math.mono("skip")
#let vx = math.mono("x")
#let vy = math.mono("y")
#let vz = math.mono("z")
#let vd = math.mono("d")
#let vr = math.mono("r")
#let vs = math.mono("s")
#let vzero = math.mono("0")
#let vone = math.mono("1")
#let vtwo = math.mono("2")

#let cfg(S, s) = $lr(chevron.l #S, thick #s chevron.r)$
#let trans(S, s1, s2) = $cfg(#S, s1) -> s2$

#let asg = raw(":=")
#let neq = raw("!=")
#let leq = raw("<=")
#let req = raw(">=")
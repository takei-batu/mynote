#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

#let vwhile = math.mono("while")
#let vdo = math.mono("do")
#let vx = math.mono("x")
#let vy = math.mono("y")
#let vz = math.mono("z")
#let vzero = math.mono("0")
#let vone = math.mono("1")

#let cfg(S, s) = $lr(chevron.l #S, thick #s chevron.r)$
#let trans(S, s1, s2) = $cfg(#S, s1) -> s2$

$
  c = vz := vzero ; vwhile (vy <= vx) vdo (vz := vz + vone ; vx := vx - vy) \
  w = vwhile (vy <= vx) vdo (vz := vz + vone ; vx := vx - vy) \
  c' = vz := vz + vone ; vx := vx - vy \
  c'_1 = vz := vz + vone \
  c'_2 = vx := vx - vy \
  s = [7 slash x, 5 slash y] \
  s' = [7 slash x, 5 slash y, 1 slash z] \
  s'' = [2 slash x, 5 slash y, 1 slash z] \
$

$
  prooftree(
    rule(
      trans(vz := vzero, s, s),
      rule(
        rule(
          trans(c'_1, s, s'),
          trans(c'_2, s', s''),
          trans(c', s, s''),
        ),
        rule(
          cal(B)[|vy <= vx|]s'' = F,
          trans(w, s'', s''),
        ),
        trans(w, s, s''),
      ),
      trans(c, s, s''),
    ),
  )
$
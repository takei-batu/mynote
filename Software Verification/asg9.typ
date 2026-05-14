#import "utils.typ":*
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

=

#let node = node.with(radius: 1.5em)
#Asg[
  + ${w | inf(w) subset.eq {a, b}} = {w | w "contains finitely many" c}$
    
    #diagram(
      node-stroke: .1em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>, extrude: (-3, 0)),

      edge(<q0>, "l", "<{-"),

      edge(<q0>, <q0>, $a, b, c$, "-}>", bend: 120deg),
      edge(<q1>, <q1>, $a, b$, "-}>", bend: 120deg),

      edge(<q0>, <q1>, $a, b$, "-}>", bend: 0deg),
    )


  + ${w | {a, b} subset.eq inf(w)} = {w | w "contains infinitely many" a "and" b}$

    #diagram(
      node-stroke: .1em,
      node((0,0), $q_0$, name: <q0>),
      node((1,-.7), $q_1$, name: <q1>),
      node((1,.7), $q_2$, name: <q2>, extrude: (-3, 0)),

      edge(<q0>, "l", "<{-"),

      edge(<q0>, <q0>, $b, c$, "-}>", bend: 120deg),
      edge(<q1>, <q1>, $a, c$, "-}>", bend: 120deg),

      edge(<q0>, <q1>, $a$, "-}>", bend: 10deg),

      edge(<q1>, <q2>, $b$, "-}>", bend: 10deg),
      edge(<q2>, <q1>, $a$, "-}>", bend: 10deg),
      edge(<q2>, <q0>, $b, c$, "-}>", bend: 10deg),
    )

  + ${w | inf(w) = {a, b, c}} = {w | w "contains infinitely many" a, b, "and" c}$

    #diagram(
      node-stroke: .1em,
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $q_1$, name: <q1>),
      node((1,1), $q_2$, name: <q2>),
      node((0,1), $q_3$, name: <q3>, extrude: (-3, 0)),

      edge(<q0>, "l", "<{-"),

      edge(<q0>, <q0>, $b, c$, "-}>", bend: 120deg),
      edge(<q1>, <q1>, $a, c$, "-}>", bend: 120deg),
      edge(<q2>, <q2>, $a, b$, "-}>", bend: -120deg),

      edge(<q0>, <q1>, $a$, "-}>", bend: 10deg),

      edge(<q1>, <q2>, $b$, "-}>", bend: 10deg),

      edge(<q2>, <q3>, $c$, "-}>", bend: 10deg),

      edge(<q3>, <q1>, $a$, "-}>", bend: 0deg),
      edge(<q3>, <q0>, $b, c$, "-}>", bend: 10deg),
    )
]
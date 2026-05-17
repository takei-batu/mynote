#import "utils.typ":*
#import "@preview/cetz:0.5.2"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

=
#Asg[
  $phi = p and not (bold("XF") p) equiv p and not (bold("X") ("true" bold("U") p))$

  $A P = {"true", p}$

  $c l(phi) = {
    "true", 
    p, 
    upright(bold("F"))p, 
    upright(bold("XF"))p,
    phi, 
    not ("true"), 
    not p, 
    not (upright(bold("F")) p), 
    not (upright(bold("XF")) p),
    not phi
  }$
  
  $alpha in a t(phi)$に対して，
  $
    "true" in alpha\
    phi in alpha <=> p in alpha and not (bold("XF") p) in alpha\
    not phi in alpha <=> not p in alpha or bold("XF") p in alpha
  $
  であるので，
  $
    a t (phi) = {alpha_i | 0 <= i <= 7}
  $
  ここで，$alpha_i$の要素は以下の表で与えられる．
  subformulaが属する場合は1, そうではない場合（その否定が属する）場合は0で表す．

  #align(center)[
    #let t = table.cell(align: center)[1]
    #let f = table.cell(align: center)[0]
    #let n = 0
    #table(
      stroke: none,
      // rows: 5,
      columns: 9,
      table.hline(y: 1),
      table.vline(x: 1),
      table.header(
        [],
        [$alpha_0$], 
        [$alpha_1$],
        [$alpha_2$],
        [$alpha_3$],
        [$alpha_4$],
        [$alpha_5$],
        [$alpha_6$],
        [$alpha_7$],
      ),
      [true],
      t, t, t, t, t, t, t, t,
      [$phi$],
      t, t, f, f, f, f, f, f,
      [$p$],
      t, t, t, t, f, f, f, f,
      [$upright(bold(X)bold(F))p$],
      f, f, t, t, t, t, f, f,
      [$upright(bold(F))p$],
      t, f, t, f, t, f, t, f
    )
  ]
  
  $"NGA" A_phi = (Q, Sigma, ∆, q_0, cal(F))$は以下のように構成される．
  ただし，
  $
    Q = {q_0} union a t(phi), quad
    Sigma = 2^(A P), quad
    cal(F) = {F_(upright(bold("F"))p)}
  $
  であり，
  $
    F_(upright(bold("F"))p) = {alpha_0, alpha_2, alpha_7}.
  $

  初期状態$q_0$からの遷移は$alpha_0$のみである．
  $(alpha_i, hat(beta), beta) in Delta$ならば，
  + $upright(bold("XF"))p in alpha_i <=> upright(bold("F"))p in beta$
  + $not upright(bold("XF"))p in alpha_i <=> not (upright(bold("F"))p) in beta$
  + $upright(bold("F"))p in alpha_i <=> p in alpha_i or upright(bold("F"))p in beta$
  + $not (upright(bold("F"))p) in alpha_i <=> not p in alpha_i and not (upright(bold("F"))p) in beta$
  表と遷移条件から，$alpha_1, alpha_3, alpha_5, alpha_6$からの状態遷移は存在しない．

  以上より次の図を得る：
  #align(center)[
    #diagram(
      node-stroke: .05em,
      node-shape: circle,
      spacing: (3em,3em),
      node((0,0), $q_0$, name: <q0>),
      node((1,0), $alpha_0$, name: <a0>, extrude: (-3, 0)),
      node((2,0), $alpha_2$, name: <a2>, extrude: (-3, 0)),
      node((2,1), $alpha_4$, name: <a4>),
      node((1,1), $alpha_7$, name: <a7>, extrude: (-3, 0)),

      edge(<q0>, "l", "<{-"),

      edge(<q0>, <a0>, "-}>"),
      edge(<a0>, <a7>, "-}>"),
      
      edge(<a2>, <a0>, "-}>"),
      edge(<a2>, <a2>, "-}>", bend: 120deg),
      edge(<a2>, <a4>, "-}>"),

      edge(<a4>, <a0>, "-}>"),
      edge(<a4>, <a2>, "-}>"),
      edge(<a4>, <a4>, "-}>", bend: -120deg),

      edge(<a7>, <a7>, "-}>", bend: -120deg),
    )
  ]

]
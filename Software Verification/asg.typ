#import "setting.typ":*
#import "utils.typ":*
#import "@preview/curryst:0.6.0": rule, prooftree, rule-set
#show: conf

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  counter(page).update(1)
  it
}
#set page(
  header: align(right)[26M30015 筏井 俊介],
  footer: context {
    align(center)[
      #counter(page).display()
    ]
  } 
)

// 1
=

#Asg[
  $c = vz asg vz + vone ; vx asg vx - vy$とする．
  $
    &
    #cfg(
      $vz asg vzero ; vwhile (vy <= vx) vdo c$,
      $[12 slash x, 5 slash y]$
    ) \
    =>
    &
    #cfg(
      $vskip ; vwhile (vy <= vx) vdo c$,
      $[12 slash x, 5 slash y]$
    ) \
    =>
    &
    #cfg(
      $vwhile (vy <= vx) vdo c$,
      $[12 slash x, 5 slash y]$
    ) \
    =>
    &
    #cfg(
      $mono("if") (vy <= vx) mono("then") (c ; vwhile (vy <= vx) vdo c) mono("else") vskip$,
      $[12 slash x, 5 slash y]$
    ) \
    =>
    &
    #cfg(
      $c ; vwhile (vy <= vx) vdo c$,
      $[12 slash x, 5 slash y]$
    ) \
    =>
    &
    #cfg(
      $vskip ; vwhile (vy <= vx) vdo c$,
      $[7 slash x, 5 slash y, 1 slash z]$
    ) \
    =>
    &
    #cfg(
      $vwhile (vy <= vx) vdo c$,
      $[7 slash x, 5 slash y, 1 slash z]$
    ) \
    =>
    &
    #cfg(
      $mono("if") (vy <= vx) mono("then") (c ; vwhile (vy <= vx) vdo c) mono("else") vskip$,
      $[7 slash x, 5 slash y, 1 slash z]$
    ) \
    =>
    &
    #cfg(
      $c ; vwhile (vy <= vx) vdo c$,
      $[7 slash x, 5 slash y, 1 slash z]$
    ) \
    =>
    &
    #cfg(
      $vskip ; vwhile (vy <= vx) vdo c$,
      $[2 slash x, 5 slash y, 2 slash z]$
    ) \
    =>
    &
    #cfg(
      $vwhile (vy <= vx) vdo c$,
      $[2 slash x, 5 slash y, 2 slash z]$
    ) \
    =>
    &
    #cfg(
      $mono("if") (vy <= vx) mono("then") (c ; vwhile (vy <= vx) vdo c) mono("else") vskip$,
      $[2 slash x, 5 slash y, 2 slash z]$
    ) \
    =>
    &
    #cfg(
      $vskip$,
      $[2 slash x, 5 slash y, 2 slash z]$
    ) \
  $
]

#Asg[
  $c_1 = vy asg vx * vy, c_2 = vx asg vx - 1$とする．

  主張を少し拡張して，
  任意の自然数$n$と整数$m$に対して，
  $
    trans(c, [n slash x, m slash y], [0 slash x, m dot n! slash y])
  $
  を$n$についての数学的帰納法で示す(元の主張は$m = 1$の場合である)．

  以下$m$を任意の整数とする．
  + 基底ケース：
    $n = 0$のとき，
    $s = [0 slash x, m slash y]$とすると，
    // $n! = 0! = 1, m = m dot 1 = m dot n!$
    // より，
    $
      #prooftree(
        rule(
          $cal(B)[vx != vzero](s) = upright(F)$,
          $trans(c, s, s)$,
        )
      )
    $
    であり，
    $m = m dot 1 = m dot 0!$なので，
    $
      trans(c, [0 slash x, m slash y], [0 slash x, m dot 0! slash y]).
    $
  + 帰納ステップ：
    ある$n > 0$に対して，
    $
      trans(c, [n slash x, m slash y], [0 slash x, m dot n! slash y])
    $
    が成り立つと仮定する．
    このとき，
    $[n slash x, m slash y] != [0 slash x, m dot n! slash y]$であるから，
    $
      #prooftree(
        rule(
          $T_m$,
          $T'_m$,
          $trans(c, [n slash x, m slash y], [0 slash x, m dot n! slash y])$,
        )
      )
    $
    となる導出木$T_m, T'_m$が存在する．
    ここで，
    #math.equation(
      block: true,
      numbering: _ => $[Pi_1]$
    )[
      $trans(c_1, [n + 1 slash x, m slash y], [n + 1 slash x, m dot (n + 1) slash y])$
    ]
    #math.equation(
      block: true,
      numbering: _ => $[Pi_2]$
    )[
      $trans(c_2, [n + 1 slash x, m dot (n + 1) slash y], [0 slash x, m dot (n + 1) slash y])$
    ]
    より，
    #math.equation(
      block: true,
      numbering: _ => $[Pi_3]$
    )[
      $
        #prooftree(
          rule(
            $Pi_1$,
            $Pi_2$,
            $trans(c_1 ";" c_2, [n + 1 slash x, m slash y], [n slash x, m dot (n + 1) slash y])$,
          )
        )
      $
    ]
    $m dot (n + 1)$は整数であるから，
    帰納法の仮定より，
    #math.equation(
      block: true,
      numbering: _ => $[Pi_4]$
    )[
      $
        #prooftree(
          rule(
            $T_(m dot (n + 1))$,
            $T'_(m dot (n + 1))$,
            $trans(c, [n slash x, m dot (n + 1) slash y], [0 slash x, m dot (n + 1) dot n! slash y])$,
          )
        )
      $
    ]
    となる導出木が存在する．
    したがって，
    $
      #prooftree(
        rule(
          $Pi_3$,
          $Pi_4$,
          $trans(c, [n + 1 slash x, m slash y], [0 slash x, m dot (n + 1)! slash y])$,
        )
      )
    $
    という導出木が構成できるので，
    $
      trans(c, [n + 1 slash x, m slash y], [0 slash x, m dot (n + 1)! slash y]).
    $
  以上より主張は示された．
]

// 2
=

#Asg[
  $c' = vy asg vy -1$

  $c'' = vx asg 2 * vx$

  $c = vy asg vy -1 ; vx asg 2 * vx = c';c''$

  $w equiv vwhile vy neq vzero vdo (vy asg vy -1 ; vx asg 2 * vx) equiv vwhile vy neq vzero vdo c$

  $A equiv Y >= 0 and x = 1 and y = Y$

  $B equiv x = 2^Y$

  $
    A
    & => Y >= 0 and x = 2^0 and 0 = Y - y \
    & => x = 2^(Y - y)
  $

  $I equiv x = 2^(Y - y)$

  $
    I and not (y != 0) => I and (y = 0) => B
  $

  $I' equiv I[2 * x slash x][y - 1 slash y]$

  $I'' equiv I[2 * x slash x]$
  
  これより
  $
    #prooftree(
        rule(
          $A => I$,
          rule(
            rule(
              $I and y != 0 => I'$,
              rule(
                ${I'} c' {I''}$,
                ${I''} c'' {I}$,
                ${I'} c {I}$,
              ),
              $I => I$,
              ${I and y != 0} c {I}$,
            ),
            ${I} w {I and not (y != 0)}$,
          ),
          $I and not (y != 0) => B$,
          ${A} w {B}$,
        ),
    ) 
    $
]

#Asg[
  $c_r = vr asg vzero$

  $c_s = vs asg vone$

  $c_(r s) = c_r ; c_s$

  $c'_r = vr asg vr + vone$

  $c'_s = vs asg vs + vtwo * vr + vone$

  $c'_(r s) = c_r ; c_s$

  $w = vwhile vs leq vx vdo c'_(r s)$

  $c = c_(r s) ; w$

  $A equiv x >= 0$

  $B equiv r^2 <= x and x < (r + 1)^2$

  $
    A 
    & => A and 1 = 1 and 0 = 0 \
    & equiv (A and s = 1 and r = 0)[1 slash s][0 slash r]
  $

  $P equiv A and s = 1 and r = 0$

  #math.equation(
    block: true,
    numbering: _ => $[T_1]$,
  )[
    $
      #prooftree(
        rule(
                $A => P[1 slash s][0 slash r]$,
                rule(
                  ${P[1 slash s][0 slash r]} c_r {P[1 slash s]}$,
                  ${P[1 slash s]} c_s {P}$,
                  ${P[1 slash s][0 slash r]} c_(r s) {P}$,
                ),
                $P => P$,
                ${A} c_(r s) {P}$,
            ),
      )
    $
  ]

    ここで，
  $
    P
    & => 0 <= x and s = 1 and r = 0 \
    & => 0 <= x and s = 1 and 1 = (r + 1)^2 and 0 = r^2 \
    & => r^2 <= x and s = 1 and 1 = (r + 1)^2 and 0 = r^2 \
    & => r^2 <= x and s = (r + 1)^2
  $

  $I equiv r^2 <= x and s = (r + 1)^2$

  $
    I and not (s <= x) 
    & => r^2 <= x and s = (r + 1)^2 and not (s <= x)) \
    & => r^2 <= x and s = (r + 1)^2 and x < s \
    & => B
  $

  $
    s = (r + 1)^2 and s <= x => (r + 1)^2 <= x
  $
  および
  $
    s = (r + 1)^2 
    &=> s + 2(r + 1) + 1 \
    &= (r + 1)^2 + 2(r + 1) + 1 \
    &= r^2 + 2r + 1 + 2r + 2 + 1 \
    &= r^2 + 4r + 4 \
    &= (r + 2)^2 \
    &= (r + 1 + 1)^2 \
  $
  より，
  $
    I and s <= x 
    & => s = (r + 1)^2 and s <= x \
    & => (r + 1)^2 <= x and s + 2 times (r + 1) + 1 = (r + 1 + 1)^2 \
    &=> (r^2 <= x and s + 2r + 1 = (r + 1)^2) [r + 1 slash r] \
    &=> I[s + 2r + 1 slash s][r + 1 slash r] \
  $

  $I_(s r) equiv I[s + 2r + 1 slash s][r + 1 slash r]$

  $I_s equiv [s + 2r + 1 slash s]$

  #math.equation(
    block: true,
    numbering: _ => $[T_2]$,
  )[
    $
    #prooftree(
        rule(
          $P => I$,
          rule(
            rule(
              $I and s <= x => I_(s r)$,
              rule(
                ${I_(s r)} c'_r {I_s}$,
                ${I_s} c'_s {I}$,
                ${I_(s r)} c'_(r s) {I}$,
              ),
              $I => I$,
              ${I and s <= x} c'_(r s) {I}$,
            ),
            ${I} w {I and not (s <= x)}$,
          ),
          $I and not (s <= x) => B$,
          ${P} w {B}$,
        ),
    ) 
    $
  ]

  以上で得られた$T_1, T_2$から
  $
    #prooftree(
        rule(
          $T_1$,
          $T_2$,
          ${A} c {B}$,
        ),
    )
  $
  を得る．
]
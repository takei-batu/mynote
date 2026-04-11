#import "utils.typ":*

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
#import "setting.typ":*
#import "utils.typ":*
#import "@preview/curryst:0.6.0": rule, prooftree, rule-set
#show: conf

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}

=

#Asg[
  $c = vz := vz + vone ; vx := vx - vy$とする．
  $
    &
    #cfg(
      $vz := vzero ; vwhile (vy <= vx) vdo c$,
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
  $n$についての数学的帰納法による．
  + 基底ケース：
    $n = 0$のとき，
    $n! = 0! = 1$より明らかに，
    #h(1fr)
    $
      #prooftree(
        rule(
          $cal(B)[vx != vzero] = upright(F)$,
          trans(
            $vwhile (vx != vzero) vdo c$,
            $[0 slash x, 1 slash y]$,
            $[0 slash x, 1 slash y]$,
          ),
        )
      )
    $
  + 帰納ケース：
]

=

#Asg[
  
]
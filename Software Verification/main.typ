#import "setting.typ":*
#import "utils.typ":*
#import "@preview/curryst:0.6.0": rule, prooftree, rule-set
#show: conf

=

#Ex[
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
  とすると，
  $
    #prooftree(
      rule(
        $trans(vz := vzero, s, s)$,
        rule(
          rule(
            $trans(c'_1, s, s')$,
            $trans(c'_2, s', s'')$,
            $trans(c', s, s'')$,
          ),
          rule(
            $cal(B)[|vy <= vx |]s'' = F$,
            $trans(w, s'', s'')$,
          ),
          $trans(w, s, s'')$,
        ),
        $trans(c, s, s'')$,
      ),
    )
  $
]

=

#Ex[
  $c equiv vz := vzero ; vd := 0 ; vwhile vd < vy vdo (vz := vz + vx; vd := vd + vone)$

  $c' equiv vz := vz + vx; vd := vd + vone$

  $w = vwhile vd < vy vdo (vz := vz + vx; vd := vd + vone) = vwhile vd < vy vdo c$

  $A equiv 0 <= y$

  $
    A 
    & => 0 <= y and 0 = 0 and 0 = 0 \
    & equiv (0 <= y and z = 0 and d = 0)[0 slash z][0 slash d]
  $

  $P equiv 0 <= y and z = 0 and d = 0$

  // $therefore A => P[0 slash z][0 slash d].$

  #math.equation(
    block: true,
    numbering: _ => $[T_1]$,
  )[
    $
      #prooftree(
        rule(
                $A => P[0 slash z][0 slash d]$,
                ${P[0 slash z][0 slash d]} vz := vzero ; vd := vzero {P}$,
                $P => P$,
                ${A} vz := vzero ; vd := vzero {P}$,
            ),
      )
    $
  ]
  
  ここで，
  $
    P
    & => z = 0  and d = 0 and d = 0 and 0 <= y \
    & => z = 0 and x times d = 0 and d <= y \
    & => z = x times d and d <= y
  $

  $I equiv z = x times d and d <= y$

  // $therefore P => I.$

  $B equiv z = x times y$

  $
    I and not (d <= y) 
    & => z = x times d and ((d = y or d < y) and not (d < y)) \
    & => z = x times d and d = y \
    & => B
  $

  $
    z = x times d 
    & => z + x = x times d + x \
    & => z + x = x times (d + 1) \ 
    & equiv (z = x times d )[z + x slash z][d + 1 slash d]
  $
  および
  $
    d < y 
    & => exists n [1 <= n and d + n = y] \
    & => exists n [1 <= n and d + 1 <= y] \
    & => exists n [1 <= n] and d + 1 <= y \
    & => d + 1 <= y \
    & equiv (d <= y)[z + x slash z][d + 1 slash d]
  $
  より，
  $
    I and d < y => z = x times d and d < y => I[z + x slash z][d + 1 slash d]
  $

  $I' = I[z + x slash z][d + 1 slash d]$

  #math.equation(
    block: true,
    numbering: _ => $[T_2]$,
  )[
    $
      // T_2 :
    #prooftree(
        rule(
          $P => I$,
          rule(
            rule(
              $I and d < y => I'$,
              ${I'} c' {I}$,
              $I => I$,
              ${I and d < y} c' {I}$,
            ),
            ${I} w {I and not (d < y)}$,
          ),
          $I and not (d < y) => B$,
          ${P} w {B}$,
        ),
    ) 
    $
  ]

  以上で得られた$T_1, T_2$から
  $
    #prooftree(
        rule(
          // rule(
          //     $A => P[0 slash z][0 slash d]$,
          //     ${P[0 slash z][0 slash d]} vz := vzero ; vd := vzero {P}$,
          //     $P => P$,
          //     ${A} vz := vzero ; vd := vzero {P}$,
          // ),
          $T_1$,
          $T_2$,
          ${A} c {B}$,
        ),
      // rule(
      //   $tack.double A => A_1$,
      //   $tack.double B => B$,
      //   ${A} c {B}$
      // ),
    )
  $
  を得る．
]
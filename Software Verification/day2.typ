#import "utils.typ":*

=

#Ex[
  $c equiv vz := vzero ; vd := 0 ; vwhile vd < vy vdo (vz := vz + vx; vd := vd + vone)$

  $c_0 equiv vz := vz + vx ; vd := vd + vone$

  $c_1 equiv vz := vz + vx$

  $c_2 equiv vd := vd + vone$

  $w equiv vwhile vd < vy vdo (vz := vz + vx; vd := vd + vone)$

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
                rule(
                  ${P[0 slash d][0 slash z]} vz := vzero {P[0 slash d]}$,
                  ${P[0 slash d]} vd := vzero {P}$,
                  ${P[0 slash z][0 slash d]} vz := vzero ; vd := vzero {P}$,
                ),
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

  $I_1 equiv I[d + 1 slash d][z + x slash z]$

  $I_2 equiv I[d + 1 slash d]$

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
              $I and d < y => I_1$,
              rule(
                ${I_1} c_1 {I_2}$,
                ${I_2} c_2 {I}$,
                ${I_1} c {I}$,
              ),
              $I => I$,
              ${I and d < y} c_0 {I}$,
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
          $T_1$,
          $T_2$,
          ${A} c {B}$,
        ),
    )
  $
  を得る．
]
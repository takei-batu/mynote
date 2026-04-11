#import "utils.typ":*

=

#Asg[
  $c' = vy asg vy -1$

  $c'' = vx asg 2 * vx$

  $c = c';c''$

  $w = vwhile vy neq vzero vdo c$

  $A equiv Y >= 0 and x = 1 and y = Y$,
  $B equiv x = 2^Y$

  $
    A
    & => Y >= 0 and x = 2^0 and 0 = Y - y \
    & => x = 2^(Y - y)
  $

  $I equiv x = 2^(Y - y)$とすると，

  $
    I and not (y != 0) => I and (y = 0) => B
  $

  $I' equiv I[2 * x slash x][y - 1 slash y]$,
  $I'' equiv I[2 * x slash x]$とすると，
  
  $
    #prooftree(
        rule(
          $tack.r.double A => I$,
          rule(
            rule(
              $tack.r.double I and y != 0 => I'$,
              rule(
                ${I'} c' {I''}$,
                ${I''} c'' {I}$,
                ${I'} c {I}$,
              ),
              $tack.r.double I => I$,
              ${I and y != 0} c {I}$,
            ),
            ${I} w {I and not (y != 0)}$,
          ),
          $tack.r.double I and not (y != 0) => B$,
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

  $c'_(r s) = c'_r ; c'_s$

  $w = vwhile vs leq vx vdo c'_(r s)$

  $c = c_(r s) ; w$

  $A equiv x >= 0$,
  $B equiv r^2 <= x and x < (r + 1)^2$

  $
    A 
    & => A and 1 = 1 and 0 = 0 \
    & equiv (A and s = 1 and r = 0)[1 slash s][0 slash r]
  $

  $P equiv A and s = 1 and r = 0$とすると，

  #math.equation(
    block: true,
    numbering: _ => $[Pi_1]$,
  )[
    $
      #prooftree(
        rule(
                $tack.r.double A => P[1 slash s][0 slash r]$,
                rule(
                  ${P[1 slash s][0 slash r]} c_r {P[1 slash s]}$,
                  ${P[1 slash s]} c_s {P}$,
                  ${P[1 slash s][0 slash r]} c_(r s) {P}$,
                ),
                $tack.r.double P => P$,
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

  $I equiv r^2 <= x and s = (r + 1)^2$とすると，

  $
    I and not (s <= x) 
    & => r^2 <= x and s = (r + 1)^2 and not (s <= x)) \
    & => r^2 <= x and s = (r + 1)^2 and x < s \
    & => B
  $

  さらに，
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
    & => (r + 1)^2 <= x and s + 2 (r + 1) + 1 = (r + 1 + 1)^2 \
    &=> (r^2 <= x and s + 2r + 1 = (r + 1)^2) [r + 1 slash r] \
    &=> I[s + 2r + 1 slash s][r + 1 slash r] \
  $

  $I_(s r) equiv I[s + 2r + 1 slash s][r + 1 slash r]$,
  $I_s equiv I[s + 2r + 1 slash s]$とすると，

  #math.equation(
    block: true,
    numbering: _ => $[Pi_2]$,
  )[
    $
    #prooftree(
        rule(
          $tack.r.double P => I$,
          rule(
            rule(
              $tack.r.double I and s <= x => I_(s r)$,
              rule(
                ${I_(s r)} c'_r {I_s}$,
                ${I_s} c'_s {I}$,
                ${I_(s r)} c'_(r s) {I}$,
              ),
              $tack.r.double I => I$,
              ${I and s <= x} c'_(r s) {I}$,
            ),
            ${I} w {I and not (s <= x)}$,
          ),
          $tack.r.double I and not (s <= x) => B$,
          ${P} w {B}$,
        ),
    ) 
    $
  ]

  以上で得られた$Pi_1, Pi_2$から
  $
    #prooftree(
        rule(
          $Pi_1$,
          $Pi_2$,
          ${A} c {B}$,
        ),
    )
  $
  を得る．
]
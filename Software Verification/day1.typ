#import "utils.typ":*


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
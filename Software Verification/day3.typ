#import "utils.typ":*

=

#Ex[
  - $f(y, x) = x accent(-, dot) y$
    $
      f (0, x) &= P_0^1 (x) \
      f (y + 1, x) &= h ( f(y, x), y, x) \
      h (a, b, c) &= p ( P_0^3 (a, b, c) )
    $
  - $g(x, y) = max(x, y)$
    $
      g(x, y) &= h (f(x, y), P_0^2(x, y)) \
      h (a, b) &= a + b quad ("Example" 3.3)
    $
]
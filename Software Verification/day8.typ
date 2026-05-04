#import "utils.typ":*

=

#Ex[
  ${P or Q, not P or Q, P or not Q, not P or not Q}$
]

#Ex[
  - $E = {P(a, x, f(g(y))) =^? P(z, f(z), f(u))}$
    $
      (E, [])
      &=> ({a =^? z, x =^? f(z), f(g(y)) =^? f(u)}, []) \
      &=> ({a =^? a, x =^? f(a), f(g(y)) =^? f(u)}, [a \/ z]) \
      &=> ({x =^? f(a), f(g(y)) =^? f(u)}, [a \/ z]) \
      &=> ({f(a) =^? f(a), f(g(y)) =^? f(u)}, [a \/ z, f(a) \/ x]) \
      &=> ({f(g(y)) =^? f(u)}, [a \/ z, f(a) \/ x]) \
      &=> ({f(g(y)) =^? f(g(y))}, [a \/ z, f(a) \/ x, g(y) \/ u]) \
      &=> (emptyset, [a \/ z, f(a) \/ x, g(y) \/ u]) \
    $ 
  - ${f(x, x, g(x)) =^? f(h(y), h(g(z)), g(h(u)))}$

  - ${p(a, f(a)) =^? p(x, x)}$

  - ${f(g(x), y) =^? f(y, x)}$
]

#Ex[
  ${not p(x) or q(g(x)) or r(x, f(x)), s(g(a)), p(a), not r(a, u), not s(v) or not q(v)}$
]

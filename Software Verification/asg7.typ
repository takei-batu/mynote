#import "utils.typ":*

=

#Asg[
  ${P(x), Q(x,f(x)) or not P(x), not Q(g(y), f(z))}$

  $H_0 = {a}$

  $H_1 = {a, f(a), g(a)}$

  $S_0 = {P(a), Q(a,f(a)) or not P(a),  not Q(g(a), f(a))}$

  $S_1 = S_1^0 union S_1^1 union S_1^2$

  $S_1^0 = {P(a), P(f(a)), P(g(a))}$

  $S_1^1 = {Q(a,f(a)) or not P(a), Q(f(a),f(f(a))) or not P(f(a)), Q(g(a),f(g(a))) or not P(g(a))}$

  $S_1^2 = {not Q(g(a), f(a)), not Q(g(f(a)), f(f(a))), not Q(g(g(a)), f(g(a)))}$
]

#Asg[
]
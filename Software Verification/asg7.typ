#import "utils.typ":*

=

#let redl(body) = text(fill: red, math.underline(text(fill: black, body)))


#Asg[
  $S = {P(x), Q(x,f(x)) or not P(x), not Q(g(y), f(z))}$

  $H_0 = {a} $

  $S_0 = {P(a), Q(a,f(a)) or not P(a),  not Q(g(a), f(a))}$

  $H_1 = {a, f(a), g(a)}$

  $S_1 = S_1^0 union S_1^1 union S_1^2$
  
  $S_1^0 = {P(a), P(f(a)), redl(P(g(a)))}$

  $S_1^1 = {Q(a,f(a)) or not P(a), thick Q(f(a),f(f(a))) or not P(f(a)), thick redl(Q(g(a),f(g(a))) or not P(g(a)))}$

  $S_1^2 = {not Q(g(a), f(a)), thick not Q(g(a), f(f(a))), thick redl(not Q(g(a), f(g(a)))), thick dots.c}$

  このとき，赤下線部についての集合
  $
    {P(g(a)), Q(g(a),f(g(a))) or not P(g(a)), not Q(g(a), f(g(a)))}
  $
  は充足不能である．
  したがって，$S$は充足不能である．
]

#Asg[
  $P equiv exists x. exists y. forall z. forall w. ((P(x) -> Q(z)) or (Q(y) -> P(w)))$の充足可能性を判定するために，
  $not P equiv not(exists x. exists y. forall z. forall w. ((P(x) -> Q(z)) or (Q(y) -> P(w))))$が充足不能であることを示す．
  $
    not P
    <=>&
    forall x. forall y. exists z. exists w. not((P(x) -> Q(z)) or (Q(y) -> P(w))) \
    <=>&
    forall x. forall y. exists z. exists w. not(P(x) -> Q(z)) and not(Q(y) -> P(w)) \
    <=>&
    forall x. forall y. exists z. exists w. (P(x) and not Q(z) and Q(y) and not P(w)) \
    // ~&
    // forall x. forall y. (P(x) and not Q(f(x,y)) and Q(y) and not P(g(x,y))) \
  $
  より，
  $not P$の冠頭標準形は以下のようになる：
  $
    forall x. forall y. (P(x) and not Q(f(x,y)) and Q(y) and not P(g(x,y)))
  $
  ここで，
  $f, g$はarityが2の関数記号である．

  よって，
  $S = {P(x), thick not Q(f(x,y)), thick Q(y), thick not P(g(x,y))}$が充足不能であることを示せばよい．

  $H_0 = {a} $

  $S_0 = {P(a), thick not Q(f(a,a)), thick Q(a), thick not P(g(a,a))}$

  $H_1 = {a, f(a, a), g(a, a)}$

  $S_1 = S_1^0 union S_1^1 union S_1^2 union S_1^3$

  $S_1^0 = {P(a), P(f(a,a)), redl(P(g(a,a)))}$

  $S_1^1 = {redl(not Q(f(a,a))), not Q(f(a,f(a,a))), not Q(f(a,g(a,a))), dots.c}$

  $S_1^2 = {Q(a), redl(Q(f(a,a))), Q(g(a,a))}$

  $S_1^3 = {redl(not P(g(a,a))), not P(g(a,f(a,a))), not P(g(a,g(a,a))), dots.c}$

  このとき，赤下線部についての集合
  $
    {P(g(a,a)), not Q(f(a,a)), Q(f(a,a)), not P(g(a,a))}
  $
  は充足不能である．
  したがって，$S$は充足不能である．
]
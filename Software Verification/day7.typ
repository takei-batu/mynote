#import "utils.typ":*

=

#Ex[
  - $(forall x. exists y. P(x, y)) or exists x R(x)$ 
    $
      (forall x. exists y. P(x, y)) or exists x R(x)
      &~ forall x. P(x, f(x)) or R(c) \
      &~ forall x. (P(x, f(x)) or R(c))
    $
  - $forall x. not ((forall y. P(x, y)) or exists z. forall u. Q(x, z, u))$
    $
      forall x . not ((forall y. P(x, y)) or exists z. forall u. Q(x, z, u))
      &~ forall x. (exists y. not P(x, y) and forall z. exists u. not Q(x, z, u)) \
      &~ forall x. exists y. not P(x, y) and forall x. forall z. exists u. not Q(x, z, u)) \
      &~ forall x. not P(x, f(x)) and forall x. forall z. not Q(x, z, g(x, z))) \
      &~ forall x. (not P(x, f(x)) and forall z. not Q(x, z, g(x, z))) \
      &~ forall x. forall z. (not P(x, f(x)) and not Q(x, z, g(x, z)))
    $
]

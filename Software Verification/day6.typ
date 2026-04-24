#import "utils.typ":*

=

#Ex[
  $(p or not q) -> r <=> not (p or not q) or r <=> (not p and not not q) or r <=> (not p and q) or r <=> (not p or r) and (q or r)$

  [別解]
  $(p or not q) -> r <=> (p -> r) and (not q -> r) <=> (not p or r) and (q or r)$
]

#Ex[
  $(p and (q -> r)) or s$に対して，
  $
    A &equiv B or s, &quad x_A &<-> x_B or s \
    B &equiv p and C, & x_B &<-> p and x_C \
    C &equiv q -> r, & x_C &<-> (q -> r)
  $
  とすると，
  $
    x_A <-> x_B or s
    &<=> (x_A -> x_B or s) and (x_B or s -> x_A) \
    // &<=> (not x_A or x_B or s) and (x_B -> x_A) and (s -> x_A) \
    &<=> (not x_A or x_B or s) and (not x_B or x_A) and (not s or x_A) \
    & equiv phi_1
  $
  $
    x_B <-> p and x_C
    &<=> (x_B -> p and x_C) and (p and x_C -> x_B) \
    // &<=> (x_B -> p) and (x_B -> x_C) and (not x_B -> not (p and x_C)) \
    &<=> (not x_B or p) and (not x_B or x_C) and (x_B or not p or not x_C) \
    & equiv phi_2
  $
  $
    x_C <-> q -> r
    &<=> (x_C -> (q -> r)) and ((q -> r) -> x_C) \
    // &<=> (x_C -> not q or r) and (not q or r -> x_C) \
    &<=> (not x_C or not q or r) and (not q or not r or x_C) \
    &equiv phi_3
  $
  したがって，求めるCNFは
  $
    phi_1 and phi_2 and phi_3 and x_A
  $
]

※以下の同値性を利用すると簡単
$
  A and B -> C &<=> (A -> B) -> C <=> not A or not B or C \
  A or B -> C &<=> (A -> C) and (B -> C) <=> (not A or C) and (not B or C) \
  A -> B and C &<=> (A -> B) and (A -> C) <=> (not A or B) and (not A or C) \
  A -> B or C &<=> not A or B or C \
  A -> (B -> C) &<=> A -> not B or C <=> not A or not B or C
$

#Ex[
  $
    (p or not q) and (q or r) and (not p or not r) and (not p or not q or r) and (p or q or not r) \
    (top or not q) and (q or r) and (bot or not r) and (bot or not q or r) and (top or q or not r) \
    (q or r) and not r and (not q or r) \
    (top or r) and not r and (bot or r) \
    not r and r
  $
  $
    (p or not q) and (q or r) and (not p or not r) and (not p or not q or r) and (p or q or not r) \
    (bot or not q) and (q or r) and (top or not r) and (top or not q or r) and (bot or q or not r) \
    not q and (q or r) and (q or not r) \
    not q and (q or top) and (q or bot) \
    not q and q
  $
]
#import "utils.typ":*

=
=

= Denotational Semantics

== Direct Style Semantics: Specification
#Eg[]
#Ex[]
#Ex[]

=== Requirements on the Fixed Point
#Ex[]
#Ex[]

== Fixed Point Theory
#Eg[]
#Ex[]
#Ex[]
#Fact[]
#Eg[]
#Ex[]
#Ex[]
#Lem[]
#Ex[]
#Ex[]

=== Complete Partially Ordered Sets
#Ex[]
#Ex[]
#Ex[]
#Ex[]
#Eg[]
#Ex[]
#Ex[]
#Eg[]
#Fact[]
#Lem[]

=== Continuous Functions
ccpo (各chainが最小上界を持つようなposet) $(D, subset.eq.sq), (D', subset.eq.sq')$と
全関数$f : D -> D'$が
$
  forall d_1, d_2 in D thin [d_1  subset.eq.sq d_2 => f(d_1)  subset.eq.sq f(d_2)]
$
を満たすとき，
$f$は_monotone_ (*単調*)という．

#Eg[]
#Ex[]
#Ex[
    - $g_1 subset.eq.sq g_2$とする．
      $g_1 s = F_0 g_1 s$より，$g_2 s = F_0 g_1 s.$
      $F g_2 s = g_2 s$でもあるので，
      $F g_1 = F g_2.$
      反射律より$F g_2 subset.eq.sq F g_2$であるから，
      $F g_1 subset.eq.sq F g_2.$
      よって，
      $F_0$はmonotone.
    - $g_1 subset.neq.sq g_2$とする．
      このとき，
      $F_1 g_1 = g_2 supset.neq.sq g_1 = F_1 g_2$であるから，
      $F_1$はmonotoneではない．
    - $g_1 subset.eq.sq g_2$とする．
      $s x eq.not 0$の場合は，
      $F' g_1 subset.eq.sq F' g_2$（$F_0$の場合と同様）．
      $s x = 0$の場合は，
      $F' g_1 = s = F' g_2 subset.eq.sq F' g_2.$
      よって，
      $F_1$はmonotone.
]

#Fact[
  monotoneの合成関数もmonotone.
]
#Lem[]
#Eg[]

poset $(D, subset.eq.sq), (D', subset.eq.sq')$上の関数$f :D -> D'$がmonotoneかつ，
$D$の空ではないすべてのchain $Y$に対して，
$
  or' {f(d) | d in Y} = f (or Y)
$
が成り立つとき，
$f$は_continuous_ (*連続*)という．
さらに，
chain $emptyset$に対しても上記の等式が成り立つとき（つまり$bot = or' emptyset = f(or emptyset) = f(bot)$のとき），
$f$は_strict_ (*厳密*)という．

#Eg[]
#Ex[]
#Ex[
  $d_1, d_2 in D$を$d_1 subset.eq.sq d_2$となるように任意に選ぶ．
  このとき，$Y := {d_1, d_2}$は空ではない$D$のchainである．
  このとき，
  $
    f(or Y) &= f(d_2) \
    or' {f(d) | d in Y} &= or' {f(d_1), f(d_2)}
  $
  仮定より，
  $
    or' {f(d_1), f(d_2)} = f(d_2)
  $
  （最小）上界の定義より，
  $f(d_1) subset.eq.sq' f(d_2).$
  よって，$f$はmonotoneである．
]

#Lem[
  continuousの合成関数もcontinuous.
]

#Ex[
  strictの合成関数もstrict.
]

不動点演算子$"FIX"$の定義をする．

#Thm[
  最小元$bot$を持つccpo$(D, subset.eq.sq)$上のcontinuous $f : D -> D$に対して，
  $
    "FIX" f = or {f^n (bot) | n >= 0}.
  $
  ここで，
  $f^0 = id, thick f^(n + 1) = f circle.tiny f^n thick (n > 0).$
  #proof[
    まず，$"FIX" f$がwell-defined (任意の$f$に対して，$"FIX" f$が存在すること)を示す．
    任意の$d in D$に対して，
    $f^0 (bot) = bot subset.eq.sq d = f^0(d)$である．
    $f$がmonotoneであるから，
    $n$に関する帰納法より，$f^(n)(bot) subset.eq.sq f^(n) (d)$を得る．
    さらに，
    $n <= m$に対して，$f^n (bot) subset.eq.sq f^m (bot)$
    （$d = f(bot)$を繰り返し適用．厳密には帰納法と推移律より従う）．
    したがって，
    ${f^n (bot) | n >= n}$は空ではない$D$のchainである．
    $D$はccpoであるからその最小上界$"FIX" f$が存在する．

    次に，$"FIX" f$が$f$の不動点であること，すなわち$f("FIX" f) = "FIX" f$を示す．
    $
      f("FIX" f)
      &= f (or {f^n (bot) | n >= 0}) &quad& "difinition of" "FIX" f \
      &= or {f(f^n (bot)) | n >= 0} && "continuity of" f \
      &= or {f^n (bot) | n >= 1} \
      &= or ({f^n (bot) | n >= 1} union {bot}) && or (Y union {bot}) = or Y "for all chains" Y \
      &= or {f^n (bot) | n >= 0} && f^0(bot) = bot \
      &= "FIX" f && "difinition of" "FIX" f \
    $
    最後に，
    $"FIX" f$が$f$の最小不動点であることを示す．
    つまり，$d in D$を$f$の不動点とし，$"FIX" f subset.eq.sq d$を示す．
    明らかに，
    $bot subset.eq.sq d$であり，$f^(n)(bot) subset.eq.sq f^(n) (d) = d thick (n >= 0).$
    したがって，$d$は${f^n (bot) | n >= 0}$の上界である．
    ここで，
    $"FIX" f$は最小上界であるから，$"FIX" f subset.eq.sq d.$
  ]
]

#Eg[]
#Ex[]
#Ex[
  $f^n (bot) subset.eq.sq d thick (n >= 0)$が以下のように$n$についての帰納法を用いて示される．
  $
    & f^0(bot) = bot subset.eq.sq d. &quad& ("base case")\
    & f^(n)(bot) subset.eq.sq d => f^(n+1)(bot) subset.eq.sq f(d) subset.eq.sq d . && ("induction step &" f "is monotone &" f(d) subset.eq.sq d)\
  $
  よって，$d$は${f^n (bot) | n >= 0}$の上界である．
  $"FIX" f$は最小上界であるから，$"FIX" f subset.eq.sq d.$
]

#Ex[
  $(D, subset.eq.sq)$をccpoとし，
  $D -> D$上の二項関係$subset.eq.sq'$を次のように定義する：
  $
    f_1 subset.eq.sq' f_2 <=> forall d in D thin [f_1 (d) subset.eq.sq f_2 (d)]
  $
  $(D -> D, subset.eq.sq')$がccpoであること，
  および
  $"FIX"$がcontinuousであること，
  すなわち
  $
    "FIX" (or' cal(F)) = or {"FIX" f | f in cal(F)}
  $
  を示す．

  まず，$(D -> D, subset.eq.sq)$がposetであることが以下のようにして示せる．

  $f, f_1, f_2, f_3 in D -> D$を任意とする．
  - 任意の$d in D$に対して，
    $subset.eq.sq$の反射性より，
    $f(d) subset.eq.sq f(d).$
    よって，
    $f subset.eq.sq' f$
  - $subset.eq.sq$の推移性より，
    $
      f_1 subset.eq.sq' f_2 and f_2 subset.eq.sq' f_3
      & <=> forall d in D thin [f_1 (d) subset.eq.sq f_2 (d)] and forall d in D thin [f_2 (d) subset.eq.sq f_3 (d)] \
      & <=> forall d in D thin [f_1 (d) subset.eq.sq f_2 (d) and f_2 (d) subset.eq.sq f_3 (d)] \
      & => forall d in D thin [f_1 (d) subset.eq.sq f_3 (d)] \
      & <=> f_1 subset.eq.sq' f_3
    $
  - $subset.eq.sq$の反対象性より，
    $
      f_1 subset.eq.sq' f_2 and f_2 subset.eq.sq' f_1
      & <=> forall d in D thin [f_1 (d) subset.eq.sq f_2 (d)] and forall d in D thin [f_2 (d) subset.eq.sq f_1 (d)] \
      & <=> forall d in D thin [f_1 (d) subset.eq.sq f_2 (d) and f_2 (d) subset.eq.sq f_1 (d)] \
      & => forall d in D thin [f_1 (d) = f_2 (d)] \
      & <=> f_1 = f_2
    $
  
  次に$(D -> D, subset.eq.sq')$であることを示すために，
  任意の鎖$cal(F) subset D -> D$を考える．
  // continuous $f in D-> D$に対して，
  // ${f(d) | d in D}$は$D$の鎖である．
  // $D$はccpoであるから，${f(d) | f "is continuous"}$の最小上界が存在する．
  // $cal(F)$を次のように定める．
]
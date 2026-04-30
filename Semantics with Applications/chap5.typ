#import "utils.typ":*

=
=

= Denotational Semantics

== Direct Style Semantics: Specification
#Eg[]
#Ex[
  #set math.cases(gap: 1em)
  $
    (F g)s = cases(
      g (s[x |-> s x - 1]) quad& "if" s x eq.not 0,
      s & "if" s x eq 0
    )
  $
]
#Ex[
  #set math.cases(gap: 1em)
  $
    (F g)s = cases(
      g (s[y |-> s y * s x][x |-> s x - 1]) quad& "if" s x eq.not 1,
      s & "if" s x eq 1
    )
  $
]

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
  forall d_1, d_2 in D thin [d_1  subset.eq.sq d_2 => f(d_1)  subset.eq.sq' f(d_2)]
$
を満たすとき，
$f$は_monotone_ (*単調*)という．

#Eg[
  $f_1$は$a, b$を$d$に，
  $c$を$e$に変えるだけなので，
  包含関係がそのまま保たれる．

  $f_2$は$a in X$となる$X$に対して，$f_2(X) = {d}$であり，
  $a in.not X$となる$X$に対して，$f_2(X) = {e}$である．
  よって，
  $a in.not X, a in X', X subset.eq X'$に対して，$f_2(X) = {e} subset.eq.not {d} = f_2(X')$となる．
  例えば，$X = {b, c}, X' = {a, b, c}$などで包含関係が保たれない．
  $a in.not X$となる$X$に対して，$f_2(X) = emptyset$とすれば，
  $f_2$は単調になる．
]

#Ex[
  + $X_1 subset.eq X_2 <=> f_1(X_1) = N \\ X_1 supset.eq N \\ X_2 = f(X_2)$より単調ではない．
  それ以外の関数は単調．
]

#Ex[
    - $g_1 subset.eq.sq g_2$とする．
      $g_1 s = F_0 g_1 s$より，$g_2 s = F_0 g_1 s.$
      $F g_2 s = g_2 s$でもあるので，
      $F g_1 = F g_2.$
      反射律より$F g_2 subset.eq.sq F g_2$であるから，
      $F g_1 subset.eq.sq F g_2.$
      よって，
      $F_0$はmonotone.
    - $g_1 eq.not g_2$より，
      $g_1 subset.neq.sq g_2 or g_2 subset.neq.sq g_1$である．
      $g_1 subset.neq.sq g_2$のとき，
      $F_1 g_1 = g_2 supset.neq.sq g_1 = F_1 g_2.$
      $g_2 subset.neq.sq g_1$のときも同様に，
      $F_1 g_2 = g_1 supset.neq.sq g_2 = F_1 g_1$であるから，
      $F_1$はmonotoneではない．
      ちなみに，
      $g_1, g_3 eq.not g_2, g_1 subset.eq g_3$に対して，
      $F_1(g_1) = g_2 subset.eq g_2 = F_1(g_3).$
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

  #proof[
    $f,f'$の単調性の定義より
    $
      d_1 subset.eq.sq d_2 => f(d_1) subset.eq.sq' f(d_2) => f'(f(d_1)) subset.eq.sq'' f'(f(d_2))
    $
    が成り立つことから従う．
  ]
]

#Lem[
  $(D, subset.eq.sq), (D', subset.eq.sq')$がccpoであり，
  $f : D -> D'$が単調であるとする．
  // $Y$が$D$のchaiならば，
  // $f(Y) = {f(d) | d in Y}$も$D'$のchainである．
  このとき，
  $
    Y "is a chain in" D => {f(d) | d in Y} "is a chain in" D'
  $
  さらに，
  $
    union.sq.big' {f(d) | d in Y} subset.eq.sq' f(union.sq.big Y)
  $
  #proof[
    $Y = emptyset$のときは$bot' subset.eq.sq' f(bot)$より直ちに従う．
    $Y eq.not emptyset$の場合，
    まず$Y$が$D$のchainと仮定して，
    $f(Y) = {f(d) | d in Y}$が$D'$のchainであることを示す．
    $d'_1, d'_2 in f(Y)$とすると，
    ある$d_1, d_2 in Y$が存在して，
    $
      d'_1 = f(d_1) and d'_2 = f(d_2)
    $
    と表せる．
    $Y$が$D$のchainであるから，
    $
      d_1 subset.eq.sq d_2 or d_2 subset.eq.sq d_1
    $
    である．
    $f$の単調性より，
    $d_1 subset.eq.sq d_2$の場合は
    $
      d'_1 = f(d_1) subset.eq.sq f(d_2) = d'_2
    $
    であり，
    $d_2 subset.eq.sq d_1$の場合は
    $
      d'_2 = f(d_2) subset.eq.sq f(d_1) = d'_1
    $
    であるから，
    どちらの場合からも
    $
      d'_1 subset.eq.sq' d'_2 or d'_2 subset.eq.sq' d'_1
    $
    がわかる．
    次に，
    任意の$d in Y$に対して，
    $d subset.eq.sq union.sq.big Y$であるから，
    $f$の単調性より，
    $
      f(d) subset.eq.sq' f(union.sq.big Y)
    $
    したがって，
    $f(union.sq.big Y)$は$f(Y)$の上界である．
    また，
    $union.sq.big f(Y)$は$f(Y)$の最小上界であるから，
    $
      union.sq.big' {f(d) | d in Y} subset.eq.sq' f(union.sq.big Y).
    $
  ]
]

一般に，
$
  union.sq.big' {f(d) | d in Y} = f(union.sq.big Y)
$
は成り立たない．

#Eg[
  #set math.cases(gap: 1em)
  Example 5.23より，
  $cal(P)(bold("N") union {a})$はccpoである．
  関数$f : cal(P)(bold("N") union {a}) -> cal(P)(bold("N") union {a})$を
  $
    f(X) = 
    cases(
      X & X "is finite",
      X union {a} quad& X "is finite",
    )
  $
  と定めると，
  明らかに$f$は単調である．
  ここで，
  $
    Y = {{0, 1, dots.c, n} | n >= 0}
  $
  とすると，
  $
    union.sq.big f(Y) = union.sq.big {X | X in Y} = union.sq.big Y = bold("N")
  $
  しかし，
  $
    f(union.sq.big Y) = f(bold("N")) = bold("N") union {a}
  $
  であるから，$a in.not bold("N")$であれば，
  $
    union.sq.big f(Y) supset.eq.not f(union.sq.big Y).
  $
]

poset $(D, subset.eq.sq), (D', subset.eq.sq')$上の関数$f :D -> D'$がmonotoneかつ，
$D$の空ではないすべてのchain $Y$に対して，
$
  union.sq.big' {f(d) | d in Y} = f (union.sq.big Y)
$
が成り立つとき，
$f$は_continuous_ (*連続*)という．
さらに，
chain $emptyset$に対しても上記の等式が成り立つとき（つまり$bot = union.sq.big' emptyset = f(union.sq.big emptyset) = f(bot)$のとき），
$f$は_strict_ (*正格*)という．

#Eg[
  Example 5.26 の$f_1$は連続でもある．
  $cal(P)({a, b, c})$の空ではないchain Yを考える．
  $Y$の最小上界は$Y$の最大元$X_0$である．
  したがって，
  $
    f(union.sq.big Y) = f(X_0) subset.eq union.sq.big f(Y).
  $
  $f_1$が単調であるので，
  Lemma 5.30から
  $
    union.sq.big f(Y) subset.eq f(union.sq.big Y).
  $
  以上より$f_1$は連続である．
  さらに，
  $f_1(emptyset) = emptyset$より，
  $f_1$は正格でもある．

  Example 5.31 の$f$は連続ではない．
]

#Ex[]
#Ex[
  $d_1, d_2 in D$を$d_1 subset.eq.sq d_2$となるように任意に選ぶ．
  このとき，$Y := {d_1, d_2}$は空ではない$D$のchainである．
  このとき，
  $
    f(union.sq.big Y) &= f(d_2) \
    union.sq.big' {f(d) | d in Y} &= union.sq.big' {f(d_1), f(d_2)}
  $
  仮定より，
  $
    union.sq.big' {f(d_1), f(d_2)} = f(d_2)
  $
  （最小）上界の定義より，
  $f(d_1) subset.eq.sq' f(d_2).$
  よって，$f$は単調である．
]

#Lem[
  連続関数の合成関数も連続.
  #proof[
    Fact 5.29より$f' circle.tiny f$は単調である．
    $Y$を空ではない$D$のchainとすると，
    $f$の連続性より，
    $
      union.sq.big' f(Y) = f(union.sq.big Y).
    $
    $f(Y)$は空ではない$D'$のchainであるから，
    $f'$の連続性より，
    $
      union.sq.big'' f'(f(Y)) = f'(union.sq.big' f(Y)).
    $
    したがって，
    $
      union.sq.big'' (f' circle.tiny f)(Y) = (f' circle.tiny f)(union.sq.big Y).
    $
    ゆえに，
    $f' circle.tiny f$は連続である．
  ]
]

#Ex[
  正格な関数の合成関数も正格.
  連続関数の合成関数が連続であることは上記で示した．
  $f, f'$が正格より，
  $
    f(emptyset) &= emptyset \
    f'(f(emptyset)) &= f'(emptyset) = emptyset
  $
  したがって，
  $(f' circle.tiny f) (emptyset) = emptyset.$
]

不動点演算子$"FIX"$の定義をする．

#Thm[
  最小元$bot$を持つccpo$(D, subset.eq.sq)$上のcontinuous $f : D -> D$に対して，
  $
    "FIX" f = union.sq.big {f^n (bot) | n >= 0}.
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
      &= f (union.sq.big {f^n (bot) | n >= 0}) &quad& "difinition of" "FIX" f \
      &= union.sq.big {f(f^n (bot)) | n >= 0} && "continuity of" f \
      &= union.sq.big {f^n (bot) | n >= 1} \
      &= union.sq.big ({f^n (bot) | n >= 1} union {bot}) && union.sq.big (Y union {bot}) = union.sq.big Y "for all chains" Y \
      &= union.sq.big {f^n (bot) | n >= 0} && f^0(bot) = bot \
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

#Eg[
  #set math.cases(gap: 1em)
  上記の方法でExample 5.1の$F'$:
  $
    (F' g)s = cases(
      g s quad& "if" s x eq.not 0,
      s & "if" s x eq 0
    )
  $
  の最小不動点をもとめる．
  最小元$bot in State arrow.r.hook State$は
  任意の$s$に対して$bot (s) = "undef"$を満たす（Lemma 5.13）．
  次に，
  ${F'^n bot | n >= 0}$を以下のように計算する．
  $
    (F'^0 bot) s 
    &= (id bot) s \
    // &= bot s \
    &= "undef" \
    (F'^1 bot) s &= (F' bot) s \
    &= cases(
        bot s quad& "if" s x eq.not 0 ,
        s & "if" s x = 0
    ) \
    &= cases(
      "undef" quad& "if" s x eq.not 0 ,
      s & "if" s x = 0
    ) \
    (F'^2 bot) s &= (F'(F'^1 bot)) s \
    &= cases(
        (F'^1 bot) s quad& "if" s x eq.not 0 ,
        s & "if" s x = 0
    ) \
    &= cases(
      "undef" quad& "if" s x eq.not 0 ,
      s & "if" s x = 0
    ) \
  $
  $
    dots.v
  $
  一般に，
  $n > 0$に対して
  $F'^n bot = F'^(n+1) bot$である．
  したがって，
  $
    union.sq.big {F'^n bot | n >= 0} = union.sq.big {F'^0 bot, F'^1 bot} = union.sq.big {bot, F'^1 bot} = F'^1 bot.
  $
  ゆえに，
  $F'$の最小不動点$"FIX" F'$は
  $
    g_1 s 
    = cases(
        "undef" quad& "if" s x eq.not 0 ,
        s & "if" s x = 0
    )
  $
  となる$g_1 (= F'^1 bot)$である．
]

#Ex[
  #set math.cases(gap: 1em)
  - From Example 5.2
  $
    (F g)s = cases(
      g (s[x |-> s x - 1]) quad& "if" s x eq.not 0,
      s & "if" s x eq 0
    )
  $
  $
    (F^0 bot) s 
    &= (id bot) s
    = "undef" \
    (F^1 bot) s 
    &= (F bot) s
    = cases(
        bot (s[x |-> s x - 1]) quad& "if" s x eq.not 0 ,
        s & "if" s x = 0
    )
    = cases(
      "undef" quad& "if" s x eq.not 0 ,
      s[x |-> 0] & "if" s x = 0
    ) \
    (F^2 bot) s
    &= (F(F^1 bot)) s
    = cases(
        (F^1 bot) (s[x |-> s x - 1]) quad& "if" s x eq.not 0 ,
        s & "if" s x = 0
    )
    = cases(
      "undef" & "if" s x < 0 or s x >= 2 ,
      s[x |-> 0] quad& "if" 0 <= s x < 2
    ) \
  $
  $ dots.v $
  $
    (F^n bot) s
    = cases(
      "undef" & "if" s x < 0 or s x >= n ,
      s[x |-> 0] quad& "if" 0 <= s x < n
    ) \
  $
  $n > 0$に対して，
  $0 <= s x < n => 0 <= s x < n+1$なので，
  $s' = s[x |-> 0]$とすると，
  $
    (F^n bot) s = s' => (F^(n+1) bot) s = s'
  $
  よって，
  $(F^n bot) subset.eq.sq (F^(n+1) bot).$
  
  したがって，
  $
    "FIX" F =
    union.sq.big {F^n bot | n >= 0} =
    cases(
      "undef" & "if" s x < 0 ,
      s[x |-> 0] quad& "if" s x >= 0
    ) \
  $
  - From Example 5.3
  $
    (F g)s = cases(
      g (s[y |-> s y * s x][x |-> s x - 1]) quad& "if" s x eq.not 1,
      s & "if" s x eq 1
    )
  $
  $
    (F^0 bot) s 
    = (id bot) s
    &= "undef" \
    (F^1 bot) s 
    = (F bot) s
    &= cases(
        bot (s[y |-> s y * s x][x |-> s x - 1]) quad& "if" s x eq.not 1 ,
        s & "if" s x = 1
    ) \
    &= cases(
      "undef" quad& "if" s x eq.not 1 ,
      s[y |-> s y][x |-> 1] & "if" s x = 1
    ) \
    (F^2 bot) s
    = (F(F^1 bot)) s
    &= cases(
        (F^1 bot) (s[y |-> s y * s x][x |-> s x - 1]) quad& "if" s x eq.not 1 ,
        s & "if" s x = 1
    ) \
    &= cases(
      "undef" & "if" s x <= 0 or s x > 2 ,
      s[y |-> s y * (s x)!][x |-> s x - 1] quad& "if" 0 < s x <= 2
    ) \
  $
  $ dots.v $
  $
    (F^n bot) s
    = cases(
      "undef" & "if" s x <= 0 or s x > n ,
      s[y |-> s y * (s x)!][x |-> s x - 1] quad& "if" 0 < s x <= n
    ) \
  $
  $n > 0$に対して，
  $0 < s x <= n => 0 < s x <= n+1$なので，
  $s' = s[y |-> s y * (s x)!][x |-> s x - 1]$とすると，
  $
    (F^n bot) s = s' => (F^(n+1) bot) s = s'.
  $
  よって，
  $(F^n bot) subset.eq.sq (F^(n+1) bot).$

  したがって，
  $
    "FIX" F =
    union.sq.big {F^n bot | n >= 0} =
    cases(
      "undef" & "if" s x <= 0 ,
      s[y |-> s y * (s x)!][x |-> s x - 1] quad& "if" s x > 0
    ) \
  $
]

#Ex[
  $f^n (bot) subset.eq.sq d thick (n >= 0)$が以下のように$n$についての帰納法を用いて示される．
  $
    & f^0(bot) = bot subset.eq.sq d. &quad& ("base case")\
    & f^(n)(bot) subset.eq.sq d => f^(n+1)(bot) subset.eq.sq f(d) subset.eq.sq d . && ("induction step &" f "is monotone &" f(d) subset.eq.sq d)\
  $
  よって，$d$は${f^n (bot) | n >= 0}$の上界である．
  $"FIX" f$は最小上界であるから，$"FIX" f subset.eq.sq d.$
]

最小不動点の存在を示すための流れは以下のようにまとめられる：
+ ccpo (_chain complete partially ordered sets_)に制限する．
+ ccpo上の連続関数に制限する．
+ ccpo上の連続関数は常に最小不動点を持つことを示す．

#Ex[
  $(D, subset.eq.sq)$をccpoとし，
  $D -> D$上の二項関係$subset.eq.sq'$を次のように定義する：
  $
    f_1 subset.eq.sq' f_2 <=> forall d in D thin [f_1 (d) subset.eq.sq f_2 (d)]
  $
  $(D -> D, subset.eq.sq')$がccpoであること，
  および
  $"FIX"$が連続であること，
  すなわち
  $
    "FIX" (union.sq.big' cal(F)) = union.sq.big {"FIX" f | f in cal(F)}
  $
  を示す．

  + 【$(D -> D, subset.eq.sq)$がccpoであること】

    まず，
    $(D -> D, subset.eq.sq)$がposetであることが以下のようにして示せる．

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
    
    次に$(D -> D, subset.eq.sq')$がccpoであることを示すために，
    連続関数からなる任意のchain $cal(F) subset.eq D -> D$を考える．
    各$d in D$に対して，
    $
      (union.sq.big' cal(F))(d) := union.sq.big {f(d) | f in cal(F)}
    $
    と定める．
    このとき，
    $union.sq.big' cal(F) in D -> D$が$cal(F)$の最小上界であることを示す．
    
    まず，上記がwell-definedであることを示す．
    $d in D$を任意とする．
    $cal(F)$がchainなので，
    各$f_1, f_2 in cal(F)$に対して，
    $
    f_1 subset.eq.sq' f_2 or f_2 subset.eq.sq' f_1 <=>
    f_1(d) subset.eq.sq' f_2(d) or f_2(d) subset.eq.sq' f_1(d)
    $
    であるから．
    各$d in D$に対して，
    ${f(d) | f in cal(F)}$は$D$のchainである．
    $D$がccpoであるので，
    最小上界$union.sq.big {f(d) | f in cal(F)}$が存在する．
    また，
    明らかに$d_1 = d_2$ならば，
    任意の$f in cal(F)$に対して，
    $f(d_1) = f(d_2)$なので，
    ${f(d_1) | f in cal(F)} = {f(d_2) | f in cal(F)}.$
    ゆえに，
    $union.sq.big' cal(F)(d_1) = union.sq.big' cal(F)(d_2).$

    次に，
    $union.sq.big' cal(F) in cal(F)$，
    つまり$union.sq.big' cal(F)$が連続：
    $D$の空ではないすべてのchain $Y$に対して，
    $
      // union.sq.big {(union.sq.big' cal(F))(d) | d in Y} = (union.sq.big' cal(F))(union.sq.big Y)
      union.sq.big ((union.sq.big' cal(F))(Y)) = (union.sq.big' cal(F))(union.sq.big Y)
    $
    を示せばよい．
    そのために，まず
    $
      union.sq.big {union.sq.big f(Y) | f in cal(F)}
      subset.eq.sq
      union.sq.big ((union.sq.big' cal(F))(Y))
    $
    および
    $
      union.sq.big ((union.sq.big' cal(F))(Y))
      subset.eq.sq
      union.sq.big {union.sq.big f(Y) | f in cal(F)}
    $
    を示す．
    - $f in cal(F)$を任意とする．
      $g = union.sq.big' cal(F)$の定義より，
      $f subset.eq.sq' g$
      であるから，
      特に，
      $
        forall d in Y [f(d) subset.eq.sq g(d)].
      $
      また，
      $
        forall d in Y [g(d) subset.eq.sq union.sq.big g(Y)]
      $
      より，
      $
        forall d in Y [f(d) subset.eq.sq union.sq.big g(Y)].
      $
      つまり，
      $union.sq.big g(Y)$は$f(Y) = {f(d) | d in Y}$の上界である．
      $union.sq.big f(Y)$の最小性より，
      $
        union.sq.big f(Y) subset.eq.sq union.sq.big g(Y).
      $
      $f in cal(F)$は任意なので，
      $union.sq.big g(Y)$は${union.sq.big f(Y) | f in cal(F)}$の上界でもある．
      $union.sq.big {union.sq.big f(Y) | f in cal(F)}$の最小性より前者が従う．
    - $d in Y$を任意とする．
      $union.sq.big f(Y)$は$f(Y)$の上界であるので，
      $
        forall f in cal(F) [f(d) subset.eq.sq union.sq.big f(Y)].
      $
      同様に，
      $cal(A) = {union.sq.big f(Y) | f in cal(F)}$とすると，
      $
        forall f in cal(F) [union.sq.big f(Y) subset.eq.sq union.sq.big cal(A)]
      $
      より，
      $
        forall f in cal(F) [f(d) subset.eq.sq union.sq.big cal(A)].
      $
      つまり，
      $union.sq.big cal(A)$は${f(d) | f in cal(F)}$の上界である．
      $(union.sq.big' F)(d) = union.sq.big {f(d) | f in cal(F)}$の最小性より，
      $
        (union.sq.big' F)(d) subset.eq.sq union.sq.big cal(A).
      $
      $d in Y$は任意であるから，
      $union.sq.big cal(A)$は$(union.sq.big' cal(F))(Y)$の上界でもある．
      $union.sq.big ((union.sq.big' cal(F))(Y))$の最小性より後者が従う．
    $subset.eq.sq$の反対称律より，
    $
      union.sq.big {union.sq.big f(Y) | f in cal(F)}
      =
      union.sq.big ((union.sq.big' cal(F))(Y)).
    $
    さらに，
    $f in cal(F)$の連続性を用いて以下のように計算できる：
    $
      (union.sq.big' cal(F))(union.sq.big Y)
      &= union.sq.big {f(union.sq.big Y) | f in cal(F)} \
      // &= union.sq.big {union.sq.big {f(d) | d in Y} | f in cal(F)} \
      &= union.sq.big {union.sq.big f(Y) | f in cal(F)} \
      // &= union.sq.big {union.sq.big {f(d) | f in cal(F)} | d in Y} \
      // &= union.sq.big {(union.sq.big' cal(F))(d) | d in Y}.
      &= union.sq.big ((union.sq.big' cal(F))(Y)).
    $
    // ここで，
    最後に$union.sq.big' cal(F)$が$cal(F)$の最小上界であることは定義より明らか．
  + 【$"FIX"$が連続であること】

    $cal(F)$を連続関数からなる空ではない任意の$D$の鎖とする．
    - $union.sq.big {"FIX"(f) | f in cal(F)} subset.eq.sq' "FIX"(union.sq.big' cal(F))$について．

      $"FIX"$が単調であることを示せばよい．
      $f_1, f_2 in cal(F)$を$f_1 subset.eq.sq' f_2$となるように任意に選ぶ．
      このとき，
      $n$に関する帰納法から
      $f_1^n (bot) subset.eq.sq f_2^n (bot)$である：
      - 基底ケース：$n = 0$のとき，
        $
          f^0_1(bot) = bot subset.eq.sq bot = f^0_2(bot).
        $
      - 帰納ステップ：
        $f_1^n (bot) subset.eq.sq f_2^n (bot)$を仮定すると，
        $f_1$の単調性と$f_1 subset.eq.sq' f_2$より，
        $
          f_1^(n+1)(bot) = f_1(f_1^n (bot)) subset.eq.sq f_1(f_2^n (bot)) subset.eq.sq f_2(f_2^n (bot)) = f_2^(n+1) (bot).
        $
      よって，
      $
        "FIX"(f_1) = 
        union.sq.big {f_1^n (bot) | n >= 0} subset.eq.sq 
        union.sq.big {f_2^n (bot) | n >= 0} = 
        "FIX"(f_2).
      $
    - $"FIX"(union.sq.big' cal(F)) subset.eq.sq' union.sq.big {"FIX"(f) | f in cal(F)}$について．

      簡単のために$g = union.sq.big' cal(F)$とする．
      このとき，任意の$n >= 0$に対して，
      $
        g^n (bot) subset.eq.sq union.sq.big {"FIX"(f) | f in cal(F)}
      $
      を$n$に関する帰納法で示す．
      - 基底ケース：
        $n = 0$のとき，
        $
          g^n (bot) = bot subset.eq.sq union.sq.big {"FIX"(f) | f in cal(F)}.
        $
      - 帰納ステップ：
        $g^n (bot) subset.eq.sq union.sq.big {"FIX"(f) | f in cal(F)}$を仮定する．
        $
          g^(n+1) (bot)
          &= g(g^(n) (bot)) \
          &= union.sq.big {g(g^(n) (bot)) | g in cal(F)} \
          & subset.eq.sq union.sq.big {g(union.sq.big {"FIX"(f) | f in cal(F)}) | g in cal(F)} \
          &= union.sq.big {union.sq.big {g("FIX"(f)) | f in cal(F)} | g in cal(F)}
        $
        $g("FIX"(f)) subset.eq.sq h("FIX"(h)) = "FIX"(h) subset.eq.sq union.sq.big {"FIX"(f) | f in cal(F)}$より，
        $
          union.sq.big {g("FIX"(f)) | f in cal(F)} subset.eq.sq union.sq.big {"FIX"(f) | f in cal(F)}
        $
  
]

#Ex[
  スコット位相
]

==
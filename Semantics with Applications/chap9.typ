#import "utils.typ":*

= Axiomatic Program Verification

これまで見てきたプログラミング言語の意味論は，
与えられたプログラムがもつ性質を証明することにも使われる．
性質はいくつかの種類に分けられる．
_partial correctness properties_（*部分正当性*）は
「与えられたプログラムが終了する*ならば*，初期状態と最終状態の間に関係が存在する」ことを表す．
したがって，
プログラムの部分正当性はプログラムが終了することを保証しない．
対照的に，
_total correctness properties_（*完全正当性*）は「与えられたプログラムが終了し，*かつ*初期状態と最終状態の間に関係が存在する」ことを表す．

他にも，
プログラムを実行するときに使われる_resources_（*リソース*）（プログラムを特定の計算機で実行するための*時間*など）に関係した性質もある．
本章では部分正当性に焦点を当て，
次章ではリソースも考慮する．

== Direct Proofs of Program Correctness

この節では，
操作的意味論と表示的意味論で
以下の文の部分正当性を示す例を与える．
$
  vy := vone; thick vwhile not (vx = vone)  vdo (vy := vy * vx; thick vx := vx - vone)
  $

=== Natural Semantics

2.1節の自然意味論を用いると，
この文の部分正当性は以下のように形式化される：

任意の状態$s, s'$に対して，
$
  cfg(vy := vone\; thick vwhile not (vx = vone) vdo (vy := vy * vx\; thick vx := vx - vone), s) -> s'
$
ならば，
$s' vy = (s vx)!$かつ$s vx > 0$.

$vx$の値$s vx$が正ではないとき終了しないので，
これは部分正当性である．

証明は3つの段階で進む．
+ $vwhile$ループの本体が以下を満たすことを示す：
  #math.equation(
    block: true,
    numbering: _ => $(*)$
  )[
    $
      & "if" cfg(vy := vy * vx\; thick vx := vx - vone, s) -> s'' "and" s vx > 0\
      & "then" (s vy) * (s vx)! = (s'' vy) * (s'' vx)! "and" s vx > 0
    $
  ]
+ $vwhile$ループが以下を満たすことを示す：
  #math.equation(
    block: true,
    numbering: _ => $(**)$
  )[
    $
      & "if" cfg(vwhile not (vx = vone) vdo (vy := vy * vx\; thick vx := vx - vone), s) -> s''\
      & "then" (s vy) * (s vx)! = s'' vy "and" s'' vx = 1 "and" s vx > 0
    $
  ]
+ 全体が以下を満たすことを示す：
  #math.equation(
    block: true,
    numbering: _ => $(***)$
  )[
    $
    & "if" cfg(vy := vone\; thick vwhile not (vx = vone) vdo (vy := vy * vx\; thick vx := vx - vone), s) -> s'\
    & "then" s' vy = (s vx)! "and" s vx > 0
    $
  ]


どのステージでも，
性質を証明するために，
与えられた遷移関係の導出木が検査される．

第1ステージでは
$
  cfg(vy := vy * vx\; thick vx := vx - vone, s) -> s''
$
を考える．
$[comp]$より，
$
  #prooftree(
    rule(
      $cfg(vy := vy * vx, s) -> s'$,
      $cfg(vx := vx - vone, s') -> s''$,
      $cfg(S, s) -> s''$,
    )
  )
$
という形の導出木が得られる（ここで$S equiv vy := vy * vx\; thick vx := vx - vone$）．
さらに，
$[ass]$より，
$
  s' &= s[vy |-> cal(A)[|vy * vx|]s] = s[vy |-> (s vy) * (s vx)] \
  s'' &= s'[vx |-> cal(A)[|vx - vone|]s'] = s'[vx |-> (s' vx ) - 1]
$
$s' x = s x$であるので，
上の結果を組み合わせると，
$
  s'' 
  &= s[vy |-> (s vy) * (s vx)][vx |-> (s' vx ) - 1]\
  &= s[vy |-> (s vy) * (s vx)][vx |-> (s vx ) - 1]
$
wを得る．

$s'' vx > 0$を仮定すると，
$
  (s'' vy) * (s'' vx)!
  = ((s vy) * (s vx)) * ((s vx ) - 1)!
  = (s vy) * (s vx)!
$
であり，
$s vx = s'' vx + 1 > 0$なので，
$(*)$が成り立つ．

第2ステージでは，
$
  cfg(vwhile not (vx = vone) vdo (vy := vy * vx\; thick vx := vx - vone), s) -> s'
$
の導出木の帰納法により示す．

$[whileff]$が適用された場合，
$s' = s$であり，$cal(B)[|not (vx = 1)|]s = ff.$
つまり，
$s' vx = s vx = 1 > 0.$
さらに，
$1! = 1$なので，
$(s vy) * (s vx)! = (s vy) * 1 = s vy = s' vy$
となり，
$(**)$を満たす．

// 次に，
$[whilett]$が適用された場合，
$cal(B)[not (vx = 1)]s = tt$であり，
さらに，
ある$s''$が存在して，
$
  #prooftree(
    rule(
      $cfg(S, s) -> s''$,
      $cfg(vwhile not (vx = vone) vdo S, s'') -> s'$,
      $cfg(vwhile not (vx = vone) vdo S, s) -> s'$
    )
  )
$
とならなければならない（ただし，$S equiv vy := vy * vx\; thick vx := vx$）．
$cfg(vwhile not (vx = vone) vdo S, s'') -> s'$に帰納法の仮定を適用すると，
$
  (s'' vy) * (s'' vx)! = s' vy "and" s' vx = 1 "and" s'' vx > 0
$
$(*)$より，
$
  (s vy) * (s vx)! = (s'' vy) * (s'' vx)! "and" s vx > 0
$
これらより，
$
  (s vy) * (s vx)! = s' vy "and" s' vx = 1 "and" s vx > 0
$
これで$(**)$が完全に示された．

最後に，
第3ステージでは
$
  cfg(vy := vone\; thick vwhile not (vx = vone) vdo (vy := vy * vx\; thick vx := vx - vone), s) -> s'
$
の導出木を考える．
$[comp]$より，
$
  #prooftree(
    rule(
      $cfg(vy := vone, s) -> s''$,
      $cfg(vwhile not (vx = vone) vdo S, s'') -> s'$,
      $cfg(vy := vone\; thick vwhile not (vx = vone) vdo S, s) -> s'$,
    )
  )
$
という形の導出木が得られる．
$[ass]$より，
$s'' = s[vy |-> 1]$である．
$(**)$より，
$
  (s'' vy) * (s'' vx)! = s' vy "and" s' vx = 1 "and" s'' vx > 0
$を得る．
したがって，
$
  (s vx)! = (s'' vx)! = (s'' vy) * (s'' vx)! = s' vy \
  s x = s'' x > 0.
$
となり，
$(***)$，
つまり部分正当性が示された．

#Ex[]
#Ex[]

=== Structural Operational Semantics
この文の部分正当性は2.2節の構造的操作意味論でも確かめられる．
部分正当性は以下のように形式化される：

任意の状態$s, s'$に対して，
$
  cfg(vy := vone\; thick vwhile not (vx = vone) vdo (vy := vy * vx\; thick vx := vx - vone), s) =>^* s'
$
ならば，
$s' vy = (s vx)!$かつ$s vx > 0$.

ここでも，
証明を2段階に分ける．

+ 導出列の長さについての帰納法より以下を示す：
  $
    & "if" cfg(vwhile not (vx = vone) vdo (vy := vy * vx\; thick vx := vx - vone), s) =>^k s'\
    & "then" s' vy = (s vy) * (s vx)! "and" s' vx = 1 "and" s vx > 0
  $
+ 以下を示す：
  $
    & "if" cfg(vy := vone\; thick vwhile not (vx = vone) vdo (vy := vy * vx\; thick vx := vx - vone), s) =>^* s' \
    & "then" s' vy = (s vx)! "and" s vx > 0
  $

#Ex[
  $S equiv vy := vy * vx\; thick vx := vx - vone$とする．
  + 長さ$k$についての帰納法
   - 基底ケース：
    $k = 0$のとき，
    $cfg(vwhile not (vx = vone) vdo S, s)$は状態ではないので，
    空虚な真である．
   - 帰納ステップ：
    $k <= k_0$なる任意の$k$に対して題意が成り立つこと，
    そして
    $
      cfg(vwhile not (vx = vone) vdo S, s) =>^(k_0 + 1) s'
    $
    を仮定する．
    このとき，
    $[while2]$より，
    $
      cfg(vwhile not (vx = vone) vdo S, s) => gamma =>^(k_0) s', \
      gamma = cfg(vif not (vx = vone) vthen (S\; vwhile not (vx = vone) vdo S) velse vskip, s)
    $
    である．

    まず，$cal(B)[|not (vx = vone)|]s = tt$の場合．
    $
      gamma => cfg(S\;vwhile not (vx = vone) vdo S, s) =>^(k_0 - 1) s
    $
    となる．
    このときLemma 2.19 より，
    状態$s''$と自然数$n$が存在して，
    $
      cfg(S, s) =>^n s''\
      cfg(vwhile not (vx = vone) vdo S, s'') =>^(k_0 - 1 - n) s'
    $
    となる．
    $[ass2]$より，
    $
      cfg(vy := vy * vx, s) => s[vy |-> s vy * s vx] \
      cfg(vx := vx - vone, s[vy |-> s vy * s vx]) => s[vy |-> s vy * s vx][vx |-> s vx - 1]
    $
    である．
    $[comp22]$より，
    $
      cfg(S, s) => cfg(vx := vx - vone, s[vy |-> s vy * s vx]) => s[vy |-> s vy * s vx][vx |-> s vx - 1]
    $
    となる．
    よって，
    $s'' = s[vy |-> s vy * s vx][vx |-> s vx - 1]$および$n = 2$でなければならない．
    $k_0 - 3 <= k_0$なので，
    帰納法の仮定を適用して，
    $
      s' vy = (s'' vy) * (s'' vx)! "and" s' vx = 1 "and" s'' vx > 0
    $
    を得る．
    したがって，
    $
      s' vy = (s'' vy) * (s'' vx)! = (s vy * s vx) * (s vx - 1)! = (s vy) * (s vx)! \
      s vx = s'' vx + 1 > s'' vx > 0
    $
    となり所望の結果が得られた．

    次に，$cal(B)[|not (vx = vone)|]s = ff$の場合．
    $s vx = 1 > 0$であり，
    $
      gamma => cfg(vskip, s) => s
    $
    となる．
    つまり，
    // $k_0 = 2$であり，
    $s' = s$
    なので，
    $
      s' vy = s vy = (s vy) * 1! = (s vy) * (s vx)! \
      s' vx = s vx = 1
    $
    となり所望の結果が得られる．
  + $cfg(vy := vone\; thick vwhile not (vx = vone) vdo S, s) =>^* s'$仮定する．
  このとき，
  ある自然数$k$が存在して，
  $
    cfg(vy := vone\; thick vwhile not (vx = vone) vdo S, s) =>^k s'
  $
  となる．
  Lemma 2.19 より，
  状態$s''$と自然数$n$が存在して，
  $
    cfg(vy := vone, s) =>^n s''\
    cfg(vwhile not (vx = vone) vdo S, s'') =>^(k - 1 - n) s'
  $
  となる．
  $[ass2]$より，
  $
    cfg(vy := vone, s) => s[vy |-> 1]
  $
  なので，
  $s'' = s[vy |-> 1]$および$n = 1$でなければならない．
  また1. より，
  $
    s' vy = (s'' vy) * (s'' vx)! "and" s' vx = 1 "and" s'' vx > 0
  $
  を得る．
  以上より，
  $
    s' vy = (s'' vy) * (s'' vx)! = 1 * (s'' vx)! = (s'' vx)! \
    s vx = (s[vy |-> 1]) vx = vx = s'' vx > 0
  $
  となり所望の結果が得られる．
]

=== Denotational Semantics
5章の表示的意味論を用いて部分正当性を示す．
ccpo$(State arrow.hook State, subset.eq.sq)$上の述語$psi$として性質を形式化することを考える．
例えば，
先の文は以下のように表せる：
$
  psi_(f a c)(cal(S)_"ds" [| vy := vone\; vwhile not (vx = vone) vdo (vy := vy * vx; vx := vx - vone) |]) = tt
$
ここで，
$
  psi_(f a c)(g) = tt <=> forall s, s' in State [g s = s' => s' vy = (s vx)! and s vx > 0].
$

$D$の任意のchain$Y$に対して，
$
  forall d in Y [psi (d)  = tt => psi (union.sq.big Y) = tt]
$
となるとき，
ccpo$(D, subset.eq.sq)$上の述語$psi$を_admissible predicate_（*許容述語*）という．

#Eg[
  $State arrow.hook State$上の述語$psi'_(f a c)$を
  $
    psi'_(f a c)(g) = tt <=> forall s, s' in State [g s = s' => s' vy = (s vy) * (s vx)! and s vx > 0].
  $
  と定めると，
  $psi'_(f a c)$は許容述語である．
  これを確認するために，
  $Y$を$State arrow.hook State$のchainとし，
  任意の$g in Y$に対して$psi'_(f a c)(g) = tt$を仮定して，
  $psi'_(f a c)(union.big.sq Y) = tt$
  すなわち
  $
    forall s, s' in State [(union.big.sq Y) s = s' => s' vy = (s vy) * (s vx)! and s vx > 0]
  $
  を示す．
  Lemma 5.29 より，
  $"graph"(union.sq.big Y) = union.big {"graph"(g) | g in Y}.$
  $(union.sq.big Y)s = s'$を仮定すると，
  $Y$は空ではなく，
  ある$g in Y$に対して，
  $chevron.l s, s' chevron.r in "graph"(g).$
  そのとき，
  $psi'_(f a c)(g) = tt$なので，
  $
    s' vy = (s vx)! and s vx > 0.
  $
]

許容述語に対して，
以下の帰納法の原理が成立する．
これを，
_fixed point induction_（*不動点帰納法*）という．

#Thm[
  $(D, subset.eq.sq)$をccpo,
  $f : D -> D$を連続関数，
  $psi$を$D$の許容述語とする．
  // 任意の$d in D$に対して，
  $
    forall d in D [psi (d) = tt => psi (f (d)) = tt] => psi("FIX" f) = tt
  $
  #proof[
    まず，
    $
      psi (bot) = tt
    $
    が許容述語$psi$に対して成立する（chain $Y = emptyset$に適用）．
    $n$に関する帰納法より，
    $
      psi (f^n (bot)) = tt
    $
    を示せる．
    許容述語$psi$をchain $Y = {f^n (bot) | n >= 0}$に適用すると，
    任意の$d in Y$に対して$psi (d) = tt$なので，
    $
      psi ("FIX" f) = psi (union.sq.big Y) = tt.
    $
  ]
]

階乗をもとめるプログラムの部分正当性を示す．
まず，
$
  cal(S)_"ds" [|vy := vone\; vwhile not (vx = vone) vdo (vy := vy * vx; vx := vx - vone)|]s = s'
$
は
$
  cal(S)_"ds" [|vwhile not (vx = vone) vdo (vy := vy * vx; vx := vx - vone)|](s[vy |-> 1]) = s'
$
と同値である．
// したがって，
#math.equation(
  block: true,
  numbering: _ => $(*)$
)[
  $psi'_(f a c)(cal(S)_"ds" [|vwhile not (vx = vone) vdo (vy := vy * vx; vx := vx - vone)|]) = tt$
]
ならば，
$
  psi_(f a c)(cal(S)_"ds" [|vy := vone\; vwhile not (vx = vone) vdo (vy := vy * vx; vx := vx - vone)|]) = tt
$
であるから$(*)$を示せばよい．
不動点帰納法を使えるようにするために
少し変形する．
$cal(S)_"ds"$の定義より，
$
  cal(S)_"ds" [|vwhile not (vx = vone) vdo (vy := vy * vx; vx := vx - vone)|] = "FIX" F
$
ここで，
$
  F g = cond (cal(B)[|not (x = 1)|], g circle.tiny cal(S)_"ds" [|vy := vy * vx; vx := vx - vone|], id)
$
つまり，
$
  (F g)s =
  cases(
    s & "if" s vx = 1,
    g(s[vy := s vy * s vx][vx := s vx - vone]) quad& "otherwise"
  )
$
既に$F$が連続関数であること（Proposition 5.47）と
$psi'_(f a c)$が許容述語であること（Example 9.4）を見た．
したがって，
Theorem 9.5より，
$
  psi'_(f a c) g = tt => psi'_(f a c)(F g) = tt
$
が示せれば，
$(*)$が示せる．
この含意を示すには，
$psi'_(f a c) g = tt$,
すなわち
$
  forall s, s' in State [g s = s' => s' vy = (s vy) * (s vx)! and s vx > 0]
$
を仮定して，
$
  forall s, s' in State [(F g) s = s' => s' vy = (s vy) * (s vx)! and s vx > 0]
$
を示す．
$F$の定義より，
二つの場合が考えられる．
最初のケースは$s vx = 1$である．
このとき$s' = s$であるから，
明らかに
$
  s' vy = s' vy = (s vy) * 1! = (s vy) * (s vx)! \
  s vx = 1 > 0
$
次のケースは$s vx != 1$である．
このとき，
$
  (F g)s = g(s[vy := vy * vx][vx := vx - vone]) = s'
$
であるから，
仮定を適用すると，
$
  s' vy 
  &= (s[vy := (s vy) * (s vx)][vx := s vx - vone] vy) * (s[vy := (s vy) * (s vx)][vx := s vx - vone] vx)! \
  &= ((s vy) * (s vx)) * (s vx - 1)! \
  &= (s vy) * (s vx)!
$
かつ
$
  s[vy := (s vy) * (s vx)][vx := s vx - vone] vx = s vx - 1 > 0
$
したがって，
$
  s' vy = (s vy) * (s vx)! and s vx > 0
$

#Ex[
  簡単のため、$a = x mod b$, $z = x "div" y$をそれぞれ$a equiv x$, $z = x / y$と記す．
  また，
  $g in State arrow.hook State$を任意とする．

  まず，
  $psi_(d i v)(g) = tt$を以下のように定義する：
  $
    forall s, s' in State [g s = s' and s vx > 0 and s vy > 0 => s' vz = (s vx) / (s vy) and s' vx equiv s vx].
  $
  このとき，
  $g_0 = cal(S)_"ds" [|vz := vzero\; thick vwhile vy <= vx vdo vz := vz + 1\; vx := vx - vy|]$とし，
  $
    psi_(d i v)(g_0) = tt
  $
  を示す．
  $g' = cal(S)_"ds" [|vwhile vy <= vx vdo vz := vz + 1\; vx := vx - vy|]$とすると，
  $
    forall s, s' [g s = s' <=> g'(s[vz |-> 0]) = s'].
  $
  次に，
  $psi'_(d i v)(g) = tt$を以下のように定義する：
  #math.equation(
  block: true,
  numbering: _ => $(*)$
  )[
    $
      forall s, s' in State [g s = s' and s vx > 0 and s vy > 0 => s' vz - s vz = (s vx) / (s vy) and s' vx equiv s vx].
    $
  ]
  このとき，
  $psi'_(d i v)$は許容述語である（Example 9.4と同様）．

  $g_1 = cal(S)_"ds" [|vwhile vy <= vx vdo vz := vz + 1\; vx := vx - vy|]$とすると，
  $
    g_0 s = s' <=> g_1 (s[vz |-> 0]) = s'
  $
  より，
  $
    psi'_(d i v)(g_1) = tt => psi_(d i v)(g_0) = tt
  $
  となるから，
  $
    psi_(d i v)(g_1) = tt
  $
  を示す．
  そのために，
  $
    g_1 = "FIX" F\
    (F g)s =
    cases(
      s & "if" s vy > s vx,
      g(s[vz := s vz + 1][vx := s vx - s vy]) quad& "if" s vy <= s vx
    )
  $
  とし，
  不動点帰納法を適用するために次を示せばよい．
  $
    // forall g in State arrow.hook State 
    psi_(d i v)(g) = tt => psi_(d i v)(F g) = tt
  $

  $(*)$および任意の$s, s' in State$に対して$(F g) s = s' and s vx > 0 and s vy > 0$を仮定する．
  - $s vy > s vx$の場合：
    $s = s'$であり，
    明らかに，
    $
      s' vz - s vz = (s vx) / (s vy) and s' vx equiv s vx
    $
  - $s vy <= s vx$の場合：$g(s[vz := s vz + 1][vx := s vx - s vy]) = s'$である．
    簡単のため$s_0 = (s[vz := s vz + 1][vx := s vx - s vy])$とすると，
    $(*)$より，
    $
      s' vz - s_0 vz = (s_0 vx) / (s_0 vy) and s' vx equiv s_0 vx
    $
    を得る．
    ここで，
    $
      s_0 vx &= s vx - s vy \
      s_0 vy &= s vy \
      s_0 vz &= s vz + 1 \
    $
    より，
    $
      s' vz - s_0 vz = s' vz - s vz - 1 \
      (s_0 vx) / (s_0 vy) = (s vx) / (s vy) - 1 \
      s_0 vx equiv s vx
    $
    したがって，
    $
      s' vz - s vz = (s vx) / (s vy) and s' vx equiv s vx.
    $
]

== Partial Correctness Assertions

#import "@preview/curryst:0.6.0": rule, prooftree, rule-set
#import "utils.typ":*

= Operational Semantics

$While$における文の役割は状態を変化させることである．
算術式とブール式の意味論は式の値を決定するために状態を記述するだけなの対して，
文の意味論は同様にして状態を変更する．

操作的意味論では，
実行の結果だけでなく，
どのようにしてプログラムが実行されるかにも関心がある．
より正確には，
文の実行中にどのように状態が変化されるかに興味がある．
操作的意味論には異なる二つのアプローチがある．

- *自然意味論*：
  どのようにして全体の実行結果を手に入れるかを記述することが目的．
  big-step 操作的意味論ともいう．
- *構造的操作意味論*：
  どのようにして個々の計算が生じるかを記述することが目的．
  small-step 操作的意味論ともいう．

両社の意味論は簡単に記述できて，
それらは後述の意味で「同値」である．
しかし，
次章では一方のアプローチが他方より優れているようなプログラミングの構成の例を与える．

どちらの操作的意味論もその文の意味論は*遷移系*で記述される．
遷移系には二つの計算状況（コンフィグレーション）がある：
  #table(
    columns: 2,
    align: (left, left),
    inset : (x: 5pt, y: .5em),
    stroke: none,
    [$cfg(S, s)$], [状態$s$から文$S$が実行されることを表す],
    [$s$], [最終状態を表す],
  )

*最終計算状況*は後者の形式になる．
*遷移関係*はどのようにして実行が生じるかを記述する．
二つの操作的意味論のアプローチの違いとは遷移関係を記述する方法の違いに相当する．

== Natural Semantics

自然意味論では，
実行の初期状態と最終状態の関係に関心がある．
したがって，
遷移関係は各文の初期状態と最終状態の関係を記述する．
遷移関係を次のように記す：
$
  cfg(S, s) -> s
$
直感的には状態$s$で文$S$の実行が終了し，その結果の状態が$s'$になるという意味になる．
$->$の定義は以下の規則で与えられる．

#align(center)[
  #table(
    columns: 2,
    align: (left, left),
    inset : (x: 20pt, y: 1.5em),
    stroke: none,
    [[$ass$]], [$assT(x,a,s)$],
    [[$skip$]], [$skipT(s)$],
    [[$comp$]], [$prooftree(compT(S_1, s, S_2, s', s''))$],
    [[$iftt$]], [$prooftree(ifttT(nameflag: #true, b, S_1, s, S_2, s'))$],
    [[$ifff$]], [$prooftree(ifffT(nameflag: #true, b, S_1, S_2, s, s'))$],
    [[$whilett$]], [$prooftree(whilettT(nameflag: #true, b, S, s, s', s''))$],
    [[$whileff$]], [$whileffT(b, S, s)$ $"if" cal(B)[|b|]s = ff$],
  )
]

*規則*は一般的に次の形をしている：
$
  prooftree(
    rule(
      name: thick"if ...",
      trans(S_1, s_1, s'_1),
      dots,
      trans(S_n, s_n, s'_n),
      trans(S, s, s'),
    )
  )
$
ここで，
$S_1, ..., S_n$は$S$の*直接の構成要素*または$S$の直接の構成要素から構成された文である．
規則はいくつかの*前提*（実線の上に書かれる）と一つの*帰結*（実線の下に書かれる）もつ．
またルールを適用するときはいつでも満たされる*条件*（実線の右に書かれる）を持つこともある．
前提が無い規則を*公理*といい，
このとき実線は省略される．

公理[$ass$]は状態$s$において$x := a$が実行され，最終状態$s[x |-> cal(A)[|a|]s]$が得られることを表す．
実際はこれは公理図式である（$x, a, s$はそれぞれ任意の変数，算術式，状態を表すメタ変数であるため）．

#note[
  厳密には公理図式の変数を具体的に指定することで，
  その*インスタンス*として*公理*が手に入る．
  本書では公理図式のことを単に公理と呼ぶことにしている．
]

公理[$skip$]は状態$s$を変化させないことを表す．

規則[$comp$]は状態$s$で$S_1;S_2$を実行，
すなわち最初に$s$で$S_1$を実行し，
その最終状態が$s'$ならば次に$s'$で$S_2$を実行することを表す．

$vif$構文には二つの規則がある．
規則[$iftt$]は
$#if-else($b$, $S_1$, $S_2$)$を実行するためには
$b$が$tt$に評価されるという条件の下で
単に$S_1$を実行することを表す．
規則[$ifff$]は
$#if-else($b$, $S_1$, $S_2$)$を実行するためには
$b$が$ff$に評価されるという条件の下で
単に$S_2$を実行することを表す．

最後に，
$mono("while")$構文を実行方法を表現する規則と公理が一つずつある．
直感的には，
状態$s$で$mono("while") b mono("do") S$の意味は以下のように説明される：
- 状態$s$において$b$が真になるとき，
  まずループの部分を実行し，
  次にそのようにして得られた状態でループ自体の継続をする．
- 状態$s$において$b$が偽になるとき，
  ループの実行が終了する．
規則[$whilett$]は一つ目のケースを形式化している．
つまり，
$b$が$tt$に評価されるとき，
$S$を実行し，
続いて再び$mono("while") b mono("do") S$を実行する．
公理[$whileff$]は二つ目のケースを形式化している．
つまり，
$b$が$ff$に評価されるならば，
その状態を変えないまま$mono("while")$構文の実行を終了する．

#note[
  規則[$whilett$]は$mono("while")$構文の意味論を全く同じ構文の意味論という側面から記述しているため，
  文の構成的定義は得られない．
]

公理と規則を使って遷移関係$cfg(S, s) -> s'$を導出するとき，
*導出木*を得る．
導出木の*根*は$cfg(S, s) -> s'$であり，
*葉*は公理である．
*内部ノード*は規則の帰結であり，
対応する前提をそれら直接の子ノードとしてもつ．
公理と規則のすべてのインスタンス化された条件が満たされていることを要請する．
導出木を示すとき，
根は上ではなく下に記すのが普通である．
そのため，
子は親よりも上に来る．
導出が公理のとき*シンプルな*導出木といい，
それ以外の導出木を*複合的な*導出木という．

#note[
  We *request that* all the instantiated conditions of axioms and rules *be* satisfied.

  は仮定法現在．
  提案・要求・命令・必要などを表す動詞や形容詞の後のthat節内で、主語にかかわらず (should $+$) 動詞の原形を用いる．
  仮定法現在はこれから実現してほしいルールを提案しているために使う．
]


#Eg[
  #let S1 = $vz := vx$
  #let S2 = $vx := vy$
  #let S3 = $S1 ; S2$
  #let S4 = $vy := vz$
  #let S = $(S3) ; S4$
  #let s1 = $s_0[vz -> five]$
  #let s2 = $s_0[vx -> seven]$
  #let s3 = $s_0[vy -> five]$

  以下の文を考える．
  $
    #S
  $
  $s_0$を$vx$と$vy$以外の変数は$zero$に割り当てる状態とし，
  $s_0 vx = five, s_0 vy = seven$とする．
  このとき，
  導出木は以下のようになる：
  $
    prooftree(
      rule(
        rule(
          trans(S1, s_0, s_1),
          trans(S2, s_1, s_2),
          trans(S3, s_0, s_2),
        ),
        trans(S4, s_2, s_3),
        trans(S, s_0, s_3),
      )
    )
  $
  ここで，
  $
    s_1 = s1 \
    s_2 = s2 \
    s_2 = s3 \
  $
  である．
]

与えられた文$S$と状態$s$に対する導出木を構成するための最良の方法は，
根から上に向かって木を構成してみることである．
そこで，
左側の計算状況に合致する公理または結論をもつ規則を見つけることにする．
このとき二つのケースがある．
- 条件を満たす*公理*の場合：
  最終状態を決定できて，
  導出木を構成が完了する．
- *規則*の場合：
  次のステップはこの規則の前提を構成してみることである．
  完了したら，
  この規則の条件が満たされているかを確認しなければならない．
  そうでなければ，
  $cfg(S, s)$に対応する最終状態を決定することができない．

たまに，
与えれた計算状況に合致する公理と規則が一つよりも多く存在することがある．
そのときは導出木を見つけるために様々な可能性を検査しなければならない．
後に分かるように，
$While$には
各遷移関係$trans(S, s, s')$に対して，
ただ一つの導出木が存在する．
ただし$While$の拡張ではそうである必要はない．

#Eg[
  
]

#Ex[
  $vz$に$vx$と$vy$の商（の整数部分）を返すプログラム．
  // `z:= 0; while y <= x do (z:=z+1; x:=x-y)`
  $
    #prooftree(
      rule(
        $trans(vz := vzero, s, s)$,
        rule(
          rule(
            $trans(c_1, s, s')$,
            $trans(c_2, s', s'')$,
            $trans(c_1\;c_2, s, s'')$,
          ),
          rule(
            $cal(B)[|vy <= vx |]s'' = F$,
            $trans(vwhile (vy <= vx) vdo (c_1;c_2), s'', s'')$,
          ),
          $trans(vwhile (vy <= vx) vdo (c_1;c_2), s, s'')$,
        ),
        $trans(c, s, s'')$,
      ),
    )
  $
  ここで，
  $
    c = vz := vzero ; vwhile (vy <= vx) vdo (vz := vz + vone ; vx := vx - vy) \
    c_1 = vz := vz + vone \
    c_2 = vx := vx - vy \
    s = [7 slash x, 5 slash y] \
    s' = [7 slash x, 5 slash y, 1 slash z] \
    s'' = [2 slash x, 5 slash y, 1 slash z] \
  $
]

状態$s$での実行$S$が
- *終了する*$<=> trans(S, s, s')$となる状態$s$が存在する．
- *ループする*$<=> trans(S, s, s')$となる状態$s$が存在しない．
- *常に終了する*$<=>$ 任意の$s$に対して$trans(S, s, s')$となる状態$s$が存在する．
- *常にループする*$<=>$ 任意の$s$に対して$trans(S, s, s')$となる状態$s$が存在しない．

#Ex[
  - 常に終了するわけでも、常にループするわけでもない．
    - 常に終了しないことは，例えば$s vx = 0$となる$s$を選べばよい（厳密な反証は省略）．
    - 常にループしないことは$s vx = vone$となる$s$をとれば明らか．
  - 常に終了する(常にループしない)．\
    $s vx < 0$となる$s$に対しては$s$を，$s vx >= 1$となる$s$に対しては$s[0 |-> x, (cal(A)[|vx|]s)! |-> y]$を選べばよい．
  - 常にループする(常に終了しない)．\
    厳密な反証は省略．
]

=== Properties of the Semantics

// 遷移系は文についての主張する方法とそれらの性質を与える．
// 例えば，
二つの文$S_1$と$S_2$が*意味的に同値*であるとは，
任意の状態$s, s'$に対して，
$
  trans(S_1, s, s') <=> trans(S_2, s, s')
$
となることである．

#Lem[
  $vwhile b vdo S$と$vif b vthen (S;vwhile b vdo S) velse vskip$は意味的に同値である．
  #proof[
    まず任意の状態$s, s'$に対して
    $
      (*) : trans(vwhile b vdo S, s, s'') => (**) : trans(vif b vthen (S;vwhile b vdo S) velse vskip, s, s'')
    $
    を示す．
    $(*)$が成り立つとき，
    導出木$T$が存在する．
    $T$は$[whilett]$か$[whileff]$のどちらかの適用により構成される．
    - $[whilett]$の場合：
      $T$は以下の形になっている．
      $
        #prooftree(
          rule(
            $T_1$,
            $T_2$,
            $trans(vwhile b vdo S, s, s'')$,
          )
        )
      $
      ここで，
      $T_1$は$trans(S, s, s')$を根にもつ導出木，
      $T_2$は$trans(vwhile b vdo S, s', s'')$を根にもつ導出木である．
      さらに，
      $cal(B)[|b|] = tt$である．
      $T_1, T_2$に対して$[comp]$を適用すると，
      $
        #prooftree(
          rule(
            $T_1$,
            $T_2$,
            $trans(S\;vwhile b vdo S, s, s'')$,
          )
        )
      $
      $cal(B)[|b|] = tt$より，
      $[iftt]$を適用すると，
      $
        #prooftree(
          rule(
            rule(
              $T_1$,
              $T_2$,
              $trans(S\;vwhile b vdo S, s, s'')$,
            ),
            $trans(vif b vthen (S;vwhile b vdo S) velse vskip, s, s'')$
          )
        )
      $
      したがって，$(**)$が成り立つ．
    - $[whileff]$の場合：
      $cal(B)[|b|] = ff$であり，
      $s = s''$でなければならない．
      よって$T$は以下の形になっている．
      $
        trans(vwhile b vdo S, s, s)
      $
      公理$[skip]$（と$s = s''$）より導出木
      $
        trans(vskip, s, s'')
      $
      を得る．
      これに$[ifff]$を適用すると，
      $
        #prooftree(
          rule(
            $trans(vskip, s, s'')$,
            $trans(vif b vthen (S;vwhile b vdo S) velse vskip, s, s'')$
          )
        )
      $
    これで$(*) => (**)$が示せた．

    次に任意の状態$s, s'$に対して$(**) => (*)$を示す．
    $(**)$が成り立つとき，
    導出木$T$が存在する．
    $T$は$[iftt]$か$[ifff]$のどちらかの適用により構成される．
    - $[iftt]$の場合：
      $T$の構成から$cal(B)[|b|] = tt$であり，
      $
        trans(S\;vwhile b vdo S, s, s'')
      $
      を根にもつ導出木が得られる．
      これは$S_1;S_2$の形であり，
      これを構成するただ一つの規則は$[comp]$である．
      したがって，
      ある状態$s'$に対して
      $
        trans(S, s, s')
      $
      および
      $
        trans(vwhile b vdo S, s', s'')
      $
      を根にもつ
      導出木$T_2$および$T_3$が存在する．
      $T_2$と$T_3$に$whilett$を適用することで$(*)$に対応する導出木を得る．
    - $[ifff]$の場合：
      $cal(B)[|b|] = ff$であり，
      導出木
      $
        trans(vskip, s, s'')
      $
      が得られ，
      公理$[skip]$により$s = s''$でなければならない．
      そこで公理$[whileff]$を適用して，
      $(*)$に対応する導出木を得られる．
    これで証明は完了した．
  ]
]

#Ex[
  $[comp]$の適用および分解を繰り返すだけである
  （命題論理における$A and (B and C) <-> (A and B) and C$の証明に相当）．
]

#Ex[
  $While$の$Stm$カテゴリーを以下のように拡張する：
  $
    S ::= x := a | vskip | S_1;S_2 | vif b vthen S_1 velse S_2 | vwhile b vdo S | vrepeat S vuntil b
  $
  次に$vrepeat S vuntil b$に関する遷移関係を以下のように定める：
  #math.equation(
    block: true,
    numbering: _ => [[$repeattt$]]
  )[
    $
      trans(vrepeat S vuntil b, s, s)
      quad
      "if" cal(B)[|b|]s = tt
    $
  ]
  #math.equation(
    block: true,
    numbering: _ => [[$repeatff$]]
  )[
    $
      #prooftree(
        rule(
          name : [if $cal(B)[|b|]s = ff$],
          $trans(S, s, s')$,
          $trans(vrepeat S vuntil b, s', s'')$,
          $trans(vrepeat S vuntil b, s, s'')$,
        )
      )
    $
  ]
  最後に$vrepeat S vuntil b$と$vif b vthen vskip velse  (S;vrepeat S vuntil b)$は意味的に同値であることを示す（$vwhile b vdo S$と双対？証明の構造は2.5とほぼ同じ）．
   #proof[
    - 任意の状態$s, s'$に対して
      $
        (*) : trans(vrepeat S vuntil b, s, s'') => (**) : trans(vif b vthen vskip velse  (S;vrepeat S vuntil b), s, s'')
      $
      を示す．
      $(*)$が成り立つとき，
      導出木$T$が存在する．
      $T$は$[repeatff]$か$[repeattt]$のどちらかの適用により構成される．
      - $[repeattt]$の場合：
        $cal(B)[|b|] = tt$であり，
        $s = s''$でなければならない．
        よって$T$は以下の形になっている．
        $
          trans(vrepeat S vuntil b, s, s)
        $
        公理$[skip]$（と$s = s''$）より導出木
        $
          trans(vskip, s, s'')
        $
        を得る．
        これに$[ifff]$を適用すると，
        $
          #prooftree(
            rule(
              $trans(vskip, s, s'')$,
              $trans(vif b vthen vskip velse  (S;vrepeat S vuntil b), s, s'')$
            )
          )
        $
      - $[repeatff]$の場合：
        $T$は以下の形になっている．
        $
          #prooftree(
            rule(
              $T_1$,
              $T_2$,
              $trans(vrepeat S vuntil b, s, s'')$,
            )
          )
        $
        ここで，
        $T_1$は$trans(S, s, s')$を根にもつ導出木，
        $T_2$は$trans(vrepeat S vuntil b, s', s'')$を根にもつ導出木である．
        さらに，
        $cal(B)[|b|] = ff$である．
        $T_1, T_2$に対して$[comp]$を適用すると，
        $
          #prooftree(
            rule(
              $T_1$,
              $T_2$,
              $trans(S\;vrepeat S vuntil b, s, s'')$,
            )
          )
        $
        $cal(B)[|b|] = ff$より，
        $[iftt]$を適用すると，
        $
          #prooftree(
            rule(
              rule(
                $T_1$,
                $T_2$,
                $trans(S\;vrepeat S vuntil b, s, s'')$,
              ),
              $trans(vif b vthen vskip velse  (S;vrepeat S vuntil b), s, s'')$
            )
          )
        $

    - 次に任意の状態$s, s'$に対して$(**) => (*)$を示す．
      $(**)$が成り立つとき，
      導出木$T$が存在する．
      $T$は$[iftt]$か$[ifff]$のどちらかの適用により構成される．
      - $[iftt]$の場合：
        $cal(B)[|b|] = tt$であり，
        導出木
        $
          trans(vskip, s, s'')
        $
        が得られ，
        公理$[skip]$により$s = s''$でなければならない．
        そこで公理$[repeattt]$を適用して，
        $(*)$に対応する導出木を得られる．
      - $[ifff]$の場合：
        $T$の構成から$cal(B)[|b|] = ff$であり，
        $
          trans(S\;vrepeat S vuntil b, s, s'')
        $
        を根にもつ導出木が得られる．
        これは$S_1;S_2$の形であり，
        これを構成するただ一つの規則は$[comp]$である．
        したがって，
        ある状態$s'$に対して
        $
          trans(S, s, s')
        $
        および
        $
          trans(vrepeat S vuntil b, s', s'')
        $
        を根にもつ
        導出木$T_2$および$T_3$が存在する．
        $T_2$と$T_3$に$repeatff$を適用することで$(*)$に対応する導出木を得る．
      これで証明は完了した．
  ]
]
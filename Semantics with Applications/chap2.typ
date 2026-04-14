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
  階乗を求めるプログラムの導出木を構成している．
  一度に全体を構成するのではなく，主張したい遷移関係を根にもつ導出木から順に規則の適用を丁寧に追いながら構成している．
]

#Ex[
  $s vx = seven$と$s vy = five$の場合で考える．
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
    s = [seven slash x, five slash y] \
    s' = [seven slash x, five slash y, one slash z] \
    s'' = [two slash x, five slash y, one slash z] \
  $
]

状態$s$での実行$S$が
- *終了する*$<=> trans(S, s, s')$となる状態$s'$が存在する．
- *ループする*$<=> trans(S, s, s')$となる状態$s'$が存在しない．
- *常に終了する*$<=>$ 任意の$s$に対して$trans(S, s, s')$となる状態$s'$が存在する．
- *常にループする*$<=>$ 任意の$s$に対して$trans(S, s, s')$となる状態$s'$が存在しない．

#Ex[
  各文を$S$とする．
  - 常に終了するわけでも、常にループするわけでもない．
    - $s vx = zero$となる$s$に対して$trans(S, s, s')$となる状態$s'$が存在しないので，常に終了しない（厳密な反証は省略）．
    - $s vx = one$となる$s$に対して$trans(S, s, s)$となるので（$[whileff]$），常にループしない．
  - 常に終了する(常にループしない)．\
    $s vx < zero$となる$s$に対しては$s$を，$s vx >= one$となる$s$に対しては$s[vx |-> zero, vy |-> (cal(A)[|vx|]s)!]$を選べばよい．
  - 常にループする(常に終了しない)．
    以下の導出木の繰り返しになる（厳密な反証は略）：
    $
      #prooftree(
        rule(
          $trans(vskip, s, s)$,
          $trans(S, s, s)$,
          $trans(S, s, s)$,
        )
      )
    $
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
      #prooftree(
        rule(
          name : [if $cal(B)[|b|]s' = tt$],
          $trans(S, s, s')$,
          $trans(vrepeat S vuntil b, s, s')$,
        )
      )
    $
  ]
  #math.equation(
    block: true,
    numbering: _ => [[$repeatff$]]
  )[
    $
      #prooftree(
        rule(
          name : [if $cal(B)[|b|]s' = ff$],
          $trans(S, s, s')$,
          $trans(vrepeat S vuntil b, s', s'')$,
          $trans(vrepeat S vuntil b, s, s'')$,
        )
      )
    $
  ]
  最後に$vrepeat S vuntil b$と$S\;vif b vthen vskip velse  (S;vrepeat S vuntil b)$は意味的に同値であることを示す．
   #proof[
    $s, s'$を任意の状態とする．
    - まず
      $
        (*) : trans(vrepeat S vuntil b, s, s'') => (**) : trans(S\;vif b vthen vskip velse  (vrepeat S vuntil b), s, s'')
      $
      を示す．
      $(*)$を仮定すると，
      $(*)$を根にもつ導出木$T$が存在する．
      $T$は$[repeatff]$か$[repeattt]$のどちらかの適用により構成される．
      - $[repeattt]$の場合：
        $T$は以下の形になっている．
        $
          #prooftree(
            rule(
              // $trans(S, s, s')$,
              $T'$,
              $trans(vrepeat S vuntil b, s, s'')$,
            )
          )
        $
        ここで$T'$は
        $
          trans(S, s, s'')
        $
        を根に持たなければならない．
        次に公理$[skip]$より導出木
        $
          trans(vskip, s'', s'')
        $
        を得る．
        ここで，$cal(B)[|b|]s'' = tt$であり，
        これに$[iftt]$を適用すると，
        $
          #prooftree(
            rule(
              $trans(vskip, s'', s'')$,
              $trans(vif b vthen vskip velse  (vrepeat S vuntil b), s'', s'')$
            )
          )
        $
        この導出木と$T'$に$[comp]$を適用すると，
        $
          #prooftree(
            rule(
              $T'$,
              rule(
                $trans(vskip, s', s'')$,
                $trans(vif b vthen vskip velse  (vrepeat S vuntil b), s', s'')$
              ),
              $trans(S\;vif b vthen vskip velse  (vrepeat S vuntil b), s, s'')$
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
        $T_1$は$trans(S, s, s')$を，
        $T_2$は$trans(vrepeat S vuntil b, s', s'')$を根にもつ導出木である．
        さらに，
        $cal(B)[|b|]s' = ff$であるから，
        $T_2$に$[iftt]$を適用すると，
        $
          #prooftree(
            rule(
              $T_2$,
              $trans(vif b vthen vskip velse  (vrepeat S vuntil b), s', s'')$
            )
          )
        $
        $T_1$とこの導出木に対して$[comp]$を適用すると，
        $
          #prooftree(
            rule(
              $T  _1$,
              rule(
                $T_2$,
                $trans(vif b vthen vskip velse  (vrepeat S vuntil b), s', s'')$
              ),
              $trans(S\;vif b vthen vskip velse  (vrepeat S vuntil b), s, s'')$
            )
          )
        $

    - 逆に$(**) => (*)$を示す．
      $(**)$を仮定すると，
      $(**)$を根にもつ
      導出木
      $
        #prooftree(
          rule(
            $T$,
            $T'$,
            $trans(S\;vif b vthen vskip velse  (vrepeat S vuntil b), s, s'')$
          )
        )
      $
      が存在する．
      ここで，
      ある$s'$を用いて
      $T$は$trans(S, s, s')$を，
      $T'$は$trans(vif b vthen vskip velse  (vrepeat S vuntil b), s', s'')$を根にもつ導出木である．
      さらに，$T'$は$[iftt]$か$[ifff]$のどちらかの適用により構成される．
      - $[iftt]$の場合：
        $cal(B)[|b|]s' = tt$であり，
        // 導出木
        // $
        //   trans(vskip, s, s'')
        // $
        // が得られ，
        // 公理$[skip]$により$s = s''$でなければならない．
        $T$に$[repeattt]$を適用して，
        $
        #prooftree(
          rule(
            $T$,
            $trans(vrepeat S vuntil b, s, s')$
          )
        )
      $
        が得られる．
      - $[ifff]$の場合：
        $T'$の構成から$cal(B)[|b|]s' = ff$であり，
        $
          trans(vrepeat S vuntil b, s', s'')
        $
        を根にもつ導出木$T''$が得られる．
        // これは$S_1;S_2$の形であり，
        // これを構成するただ一つの規則は$[comp]$である．
        したがって，
        $T$と$T''$に$[repeatff]$を適用して，
        $
          #prooftree(
            rule(
              $T$,
              $T''$,
              $trans(vrepeat S vuntil b, s, s'')$
            )
          )
        $
        が得られる．
      これで証明は完了した．
  ]
]

#Ex[]

導出木の構造的帰納法は以下のようにまとめられる．
+ 遷移系の公理に対して主張が成り立つことを示す．
+ 遷移系の各規則の前提に対して主張が成り立つことを仮定して（帰納法の仮定），
  その規則の条件が満たされている場合に，
  その帰結に対しても主張が成り立つことを示す．

任意の文$S$, 状態$s, s', s''$に対して，
$
  trans(S, s, s') and trans(S, s, s'') => s' = s''
$
となることを*決定的*(deterministic)という．
つまり，
初期状態$s$における文$S$を実行したとき，
最終状態$s'$が存在するならば唯一つであるということである．

#Thm[
  $While$の自然意味論は決定的である．
]

#Ex[]

=== The Semantic Function *$cal(S)_"ns"$*

文の意味論は$State$から$State$への部分関数としてまとめられる：
$
  cal(S)_"ns" : Stm -> (State arrow.r.hook State) 
$
各文$S$に対して部分関数
$
  cal(S)_"ns" [|S|] in State arrow.r.hook State
$
が与えられる．
これは，
$
  cal(S)_"ns" [|S|]s =
  cases(
    s' & "if" trans(S, s, s'),
    "undef" quad& "otherwise"
  )
$
を表す．

#note[
  Theorem 2.9より，
  $cal(S)_"ns"$はwell-definedである．
  例えば，
  文$vwhile vtrue vdo vskip$は常にループするので（Exercise 2.4），
  任意の状態$s$に対して
  $
    cal(S)_"ns" [|vwhile vtrue vdo vskip|]s = "undef"
  $
  となる．
]

#Ex[]

#Ex[]

#Ex[]

== Structural Operational Semantics

構造的操作意味論において遷移系は以下のように表される：
$
  trans2(S, s, gamma)
$
ここで，
$gamma$は$cfg(S', s')$か$s'$のどちらか一方の形である．
これは文$S$の状態$s$における*第一ステップ*を表している．
出力は次の二通りがある：
- $gamma$が$cfg(S', s')$ならば，
  文$S$の実行は完了して*おらず*，
  残っている計算が中間の計算状況$cfg(S', s')$で表される．
- $gamma$が$s'$ならば，
  文$S$の実行は完了して，
  その最終状態が$s'$である．

$trans2(S, s, gamma)$となる$gamma$が存在しない場合，
$cfg(S, s)$は*スタック*する(stuck)という．

#note[
  stuck は「立ち往生する」，「行き詰る」という意味合いでここでは実行がいつまでも続くことを表す．
  似た綴りの stack は「積む」という意味であり，データ構造のスタック・ポップのスタックはこちらの意味．
]

$=>$の定義は以下の規則で与えられる．

#align(center)[
  #table(
    columns: 2,
    align: (left, left),
    inset : (x: 20pt, y: 1.5em),
    stroke: none,
    [[$ass2$]], [$trans2(x := a, s, s[x |-> cal(A)[|a|]s])$],
    [[$skip2$]], [$trans2(vskip, s, s)$],
    [[$comp21$]], [$prooftree(rule(trans2(S_1, s, cfg(S'_1, s')), trans2(S_1\;S_2, s, cfg(S'_1\;S_2, s'))))$],
    [[$comp22$]], [$prooftree(rule(trans2(S_1, s, s'), trans2(S_1\;S_2, s, cfg(S_2, s'))))$],
    [[$iftt2$]], [$trans2(vif b vthen S_1 velse S_2, s, cfg(S_1, s))$ if $cal(B)[|b|]s = tt$],
    [[$ifff2$]], [$trans2(vif b vthen S_1 velse S_2, s, cfg(S_2, s))$ if $cal(B)[|b|]s = ff$],
    [[$while2$]], [$trans2(vwhile b vdo S, s, s)$ $cfg(vif b vthen (S;vwhile b vdo S) velse vskip, s)$],
  )
]

状態$s$から始まる文$S$の*導出シークエント*(derivation sequence)は次のどちらかである：
+ 有限シークエント
  $
    gamma_0, gamma_1, gamma_2, dots.c, gamma_k
  $
  よく以下のようにも記す
  $
    gamma_0 => gamma_1 => gamma_2 => dots.c => gamma_k
  $
  ここで，
  $gamma_0 = cfg(S, s)$, $gamma_i => gamma_(i + 1) (0 <= i < k), k >= 0$であり，
  $gamma_k$は最終計算状況(単なる状態)であるかスタックする．
+ 無現シークエント
  $
    gamma_0, gamma_1, gamma_2, dots.c
  $
  ときどき以下のようにも記す
  $
    gamma_0 => gamma_1 => gamma_2 => dots.c
  $
  ここで，
  $gamma_0 = cfg(S, s)$, $gamma_i => gamma_(i + 1) (0 <= i)$である．

$gamma_0$から$gamma_i$への実行に$i$ステップかかることを$gamma_0 =>^i gamma_i$と記し，
ある数だけステップがかかることを$gamma_0 =>^* gamma_i$と記す．

#note[
  $gamma_0 =>^i gamma_i$と$gamma_0 =>^* gamma_i$は導出シークエント*ではなくてよい*．
  これらが導出シークエントとなるのは，
  $gamma_i$が最終計算状況になるかスタックするときかつそのときに限る．
]

#Eg[]

#Eg[]

#Ex[]

状態$s$における文$S$の実行が
- *終了する*：$cfg(S, s)$で始まる有限導出シークエントが存在する
- *ループする*：$cfg(S, s)$で始まる無限導出シークエントが存在する

$cfg(S, s) =>^* s'$となる状態$s'$が存在するならば，
状態$s$における文$S$の実行が*正常に終了する*という．
$While$では$cfg(S, s)$がスタックすることがないため，
$S$の実行が*正常に終了する*ことと$S$の実行が*終了する*ことは同値である．
また，
任意の状態$s$に対して，
$S$が終了することを$S$は*常に終了する*といい，
$S$がループすることを$S$は*常にループする*という．

#Ex[]

#Ex[]

== Properties of the Semantics

構造的操作意味論において，証明の実行には有限の導出木の*長さ*についての帰納法が役に立つ．
テクニックは以下のとおりである：
+ 長さが0の導出シークエントで性質が成り立つことを示す．
+ 長さが高々$k$の導出シークエントで性質が成り立つことを仮定して（帰納法の仮定），
  長さが$k+1$の場合でも成り立つことを示す．

証明の帰納ステップではよく以下のどちらかを検査することで行われる：
- 構文要素の構造
- 導出シークエントの最初の遷移を正当化する導出木

#Lem[
  $cfg(S_1\;S_2, s) =>^k s''$ならば，
  ある状態$s'$とある自然数$k_1, k_2$が存在して，
  $
    cfg(S_1, s) =>^(k_1) s' and cfg(S_2, s') =>^(k_2) s'' and k_1 + k_2 = k.
  $
  #proof[
    $k$についての帰納法，
    すなわち導出シークエント$cfg(S_1\;S_2, s) =>^k s''$の長さの帰納法による．
    + $k = 0$ならば，
      空虚な真である（前提が偽のときその含意は真である）．
      なぜなら$k = 0$の場合の導出シークエントの定義から$s'' = gamma_0 = cfg(S_1\;S_2, s)$とならなければならないが，
      $s''$は状態であり，$cfg(S_1\;S_2, s)$は計算状況なので，これはあり得ない．
    + 帰納ステップ．
      $k <= k_0$となるすべての$k$に対して補題が成り立つと仮定し，
      $k_0 + 1$に対しても主張が成り立つことを示す．
      そのために，
      $
        cfg(S_1\;S_2, s) =>^(k_0+1) s''
      $
      を仮定する．
      このことはある計算状況$gamma$を用いて次のようにも表せる：
      $
        cfg(S_1\;S_2, s) => gamma =>^(k_0) s''
      $
      このとき，
      $cfg(S_1\;S_2, s) => gamma$を得るのに適用する規則$[comp21]$と$[comp22]$で場合分けをして考える．
      - $[comp21]$の場合：
        $gamma = cfg(S'_1\;S_2, s')$であり，
        $
          trans2(S_1, s, cfg(S'_1, s'))
        $
        より
        $
          trans2(S_1\;S_2, s, cfg(S'_1\;S_2, s'))
        $
        を得る．
        したがって，
        $
          cfg(S'_1\;S_2, s') =>^(k_0) s''
        $
        であり，
        これには帰納法の仮定が適用できる．
        つまり，
        ある状態$s_0$とある自然数$k_1, k_2$が存在して，
        $
          cfg(S'_1, s) =>^(k_1) s_0 and cfg(S_2, s_0) =>^(k_2) s'' and k_1 + k_2 = k_0.
        $
        となる．
        $trans2(S_1, s, cfg(S'_1, s'))$と$cfg(S'_1, s) =>^(k_1) s_0$より，
        $
          cfg(S_1, s) =>^(k_1 + 1) s_0
        $
        を得る．
        よって
        $
          cfg(S_1, s) =>^(k_1 + 1) s_0 and cfg(S_2, s_0) =>^(k_2) s'' and (k_1 + 1) + k_2 = k_0 + 1.
        $
        となり所望の結果が得られた．
      - $[comp22]$の場合：
        $
          trans2(S_1, s, s')
        $
        であり，
        $gamma = cfg(S_2, s')$となる．
        よって，
        $
          cfg(S_2, s') =>^(k_0) s''
        $
        ゆえに，$k_1 = 1$および$k_2 = k_0$とすれば主張が従う．
  ]
]

#Ex[]

#Ex[
  $[cfg(S_1, s) =>^k s'] => [cfg(S_1\;S_2, s) =>^k cfg(S_2, s')]$
  #proof[
    長さ$k$についての帰納法で示す．
    + 基底ケース：$k = 0$のときは空虚な真である．
      なぜなら，
      導出シークエントの定義より，
      $cfg(S_1, s) = s'.$
      これは計算状況と最終状態が等しいことを表しているがこれはあり得ない．
    + 帰納ステップ：
      $k <= k_0$となるすべての$k$に対して
      #math.equation(
        block: true,
        numbering : _ => $(*)$
      )[
        $
          [cfg(S_1, s) =>^k s'] => [cfg(S_1\;S_2, s) =>^k cfg(S_2, s')]
        $
      ]
      成り立つと仮定する．
      さらに，
      $(*)$が$k_0 + 1$に対しても成り立つことを示すために，
      $
        cfg(S_1, s) =>^(k_0+1) s'
      $
      を仮定する．
      このとき，
      $
        cfg(S_1, s) => cfg(S'_1, s_0) =>^(k_0) s'
      $
      となる文$S'_1$と状態$s_0$が存在する．
      このとき，
      $cfg(S_1, s) => cfg(S'_1, s_0)$に対して$[comp21]$を適用して，
      $
        cfg(S_1\;S_2, s) => cfg(S'_1\;S_2, s_0)
      $
      を得る．
      さらに，
      $cfg(S'_1, s_0) =>^(k_0) s'$と帰納法の仮定$(*)$より，
      $
        cfg(S'_1\;S_2, s_0) =>^(k_0) cfg(S_2, s')
      $
      を得る．
      以上より，
      $
        cfg(S_1\;S_2, s) => cfg(S'_1\;S_2, s_0) =>^(k_0) cfg(S_2, s')
      $
      つまり，
      $
        cfg(S_1\;S_2, s) =>^(k_0 + 1) cfg(S_2, s')
      $
      したがって，
      $
        [cfg(S_1, s) =>^(k_0+1) s'] => [cfg(S_1\;S_2, s) =>^(k_0+1) cfg(S_2, s')]
      $
  ]
]

#Ex[
  $While$では，
  - 構造的操作意味論は決定的である．
  - $cfg(S, s)$で始まる導出シークエントが唯一存在する
  - 
    // 任意の状態$s$において$S$が終了する$and S$がループすることはない \
    $S$が常に終了する$and S$が常にループすることはない \
    // $<=> not$($S$が常に終了する)$or not$($S$が常にループする) \
    // $<=> $($S$が常に終了する)$=> not$($S$が常にループする) \
    // $<=> $($S$が常にループする)$=> not$($S$が常に終了する)
]

構造的操作意味論において，
$S_1$と$S_2$が*同値*であるとは，
任意の状態$s$に対して，
- $gamma$が最終計算状況である，
  またはスタックするならば
  $
    cfg(S_1, s) =>^* gamma <=> cfg(S_2, s) =>^* gamma
  $
かつ
- $cfg(S_1, s)$で始まる無限導出シークエントが存在する$<=> cfg(S_2, s)$で始まる無限導出シークエントが存在する
が成り立つことをいう．

#note[
  一つ目の条件ではステップの数は異なっていてもよい．
  二つ目の条件は
  「$S_1$がループする$<=> S_2$がループする」
  という条件に等しく，
  これの待遇をとれば，
  「$S_1$がループしない$<=> S_2$がループしない」
  という条件に等しい．
  さらに$While$の決定性より，
  これは
  「$S_1$が終了する$<=> S_2$が終了する」
  という条件に等しい．
  この条件は一つ目の条件から導かれるため，
  $While$で同値性を示すには最初の条件だけでよいということになる．
  さらに，言えば$While$ではスタックすることがないので，$gamma$が最終計算状況であるときだけ考えればよい．
]

#Ex[
  $gamma = s'$を最終計算状況とする．
  + $cfg(S\;vskip, s) =>^* gamma$と仮定すると，
    ある自然数$k$が存在して，
    $cfg(S\;vskip, s) =>^k gamma$となる．
    このとき補題2.19より，
    ある状態$s''$とある自然数$k_1, k_2$が存在して，
    $
      cfg(S, s) =>^(k_1) s'' and cfg(vskip, s'') =>^(k_2) s' and k_1 + k_2 = k.
    $
    と表せる．
    $[skip2]$より，
    $k_2 = 0, s'' = s'$,
    つまり$k_1 = k$でなければならない．
    よって，
    $cfg(S, s) =>^(k) s'$であり，
    $cfg(S, s) =>^* gamma$がわかる．

    逆に$cfg(S, s) =>^* gamma$を仮定すると，
    ある自然数$k$が存在して，
    $cfg(S, s) =>^k gamma$となる．
    Exercise 2.21 より，
    $
      cfg(S\;vskip, s) =>^k cfg(vskip, s') => s' = gamma
    $
    つまり
    $cfg(S\;vskip, s) =>^(k+1) gamma$であり，
    $cfg(S\;vskip, s) =>^* gamma$がわかる．
  +
  +
]

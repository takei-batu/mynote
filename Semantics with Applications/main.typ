#import "../Semantics with Applications/setting.typ":*
#show: conf

<<<<<<< HEAD
#include "chap1.typ"
#include "chap2.typ"
=======
// 見出し
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  it
}
#show heading: it => {
  if it.level >= 3{
    block(it.body, above: 1.5em)
  } 
  else {
    it
  }
}
#set heading(numbering: "1.1")

// 本文
#set text(
  lang: "ja",
  font: ("New Computer Modern", "Yu Mincho"),
)

// 共通環境
#let my-countor = counter("my-countor")
#show heading.where(level: 1): it => {
  my-countor.step(level: 1)
  it
}
#let mybox(title, body) = {
  my-countor.step(level: 2)
  block(
    width: 100%,
    spacing: 1em,
    above: 1.5em,
    // stroke: luma(150),
  )[
    #block(
        below: 1em,
        // stroke: luma(150),
      )[
      #text(
        size: 12pt, 
        font: "MS Gothic",
      )[
        #title #context {
          my-countor.display()
        }
      ]
    ]
    #text(
      // size: 11pt, 
      // font: "Yu Mincho",
    )[
      #body
      #h(1fr) $square$
    ]
  ]
}
#let Eg(body) = mybox("Example", body)
#let Ex(body) = mybox("Exercise", body)
#let Fact(body) = mybox("Fact", body)
#let Lem(body) = mybox("Lemma", body)

#let proof(body) = {
  block(
    width: 100%,
    spacing: 1em,
    above: 1.5em,
    
  )[
    #text(font: "Ms Gothic")[証明]：
    #body
    // #h(1fr) $square$
  ]
}

// note環境
#let note(body) = {
  block(
    width: 100%,
    spacing: 1em,
    above: 1.5em,
    // stroke: red,
    fill: luma(230),
    inset: 8pt,
    radius: 4pt,
  )[
    #block(
        below: 1em,
        // stroke: luma(150),
      )[
      #text(
        size: 12pt, 
        font: "New Computer Modern",
        style: "italic",
      )[
        Note
      ]
    ]
    #text(
      // size: 11pt, 
      // font: "Yu Mincho",
    )[
      #body
    ]
  ]
}

#let While() = math.bold("While")
#let Int() = math.bold("Z")
#let Num() = math.bold("Num")
#let Var() = math.bold("Var")
#let Aexp() = math.bold("Aexp")
#let Bexp() = math.bold("Bexp")
#let Stm() = math.bold("Stm")
#let State() = math.bold("State")
#let zero() = math.mono("0")
#let one() = math.mono("1")
#let vx() = math.mono("x")
#let vy() = math.mono("y")
#let vz() = math.mono("z")
#let vtrue() = math.mono("true")
#let vfalse() = math.mono("false")
#let truth() = math.bold("T")
#let tt() = math.bold("tt")
#let ff() = math.bold("ff")

= Inroduction
== Semantic Description Methods
=== Operational Semantics
=== Denotational Semantics
=== Axiomatic Semantics
=== The Complementary View
== The Example Language While
#Ex[
  略
]
#Ex[
  略
]
== Semantics of Expressions

$While()$における算術式とブール式の意味論の詳細を記す前に，
数値の意味論について考える．
簡単のために数値が二進数で表現されているものと仮定している．
つまり抽象構文が
$
  n ::= zero() | one() | n zero() | n one()
$
で与えられているとする．
数値が表現する数を決定するために，
関数
$
  cal(N) : Num() -> Int()
$
を定義する．
これを意味関数と呼ばれ，
数値の意味論を定義する．
我々は$cal(N)$を全関数としたい．
なぜなら，各数値にただ一つの数を指定したいからだ．
一般に，
意味関数の構文的実体に対する適用には通常の括弧(,)ではなく「構文的」括弧$[|,|]$を用いる．

意味関数$cal(N)$は以下の4つ意味節によって定まる：
$ 
  cal(N)[|zero()|] & = bold(0) \
  cal(N)[|one()|] & = bold(1) \
  cal(N)[|zero() med n|] & = 2 dot cal(N)[|n|] \
  cal(N)[|one() med n|] & = 2 dot cal(N)[|n|] + 1 \
$
ここで，
$bold(0)$と$bold(1)$は数学的な数（整数）である．
さらに，$dot$と$+$は整数上の通常の演算子である．
上記の定義は構成的定義（数値についての可能な構成方法すべてに対して，どのように対応する数が部分構成要素から得られるかということを教えている）の例である．

#note[
  embark on (= start) : はじめる，のりだす \
  ingredient : 構成要素 \
  entity : 実体 \
  juxtapositioning : 比較のために二つ以上のものを並べること
]

#Eg[
  上の意味関数$cal(N)$を使って数値$one()zero()one()$に対応する数$cal(N)[|one()zero()one()|]$を計算している．
  #note[
    accordance : 準拠 \
     in (strict) accordance with O : Oに(厳密に)従って
  ]
]

#Ex[
  抽象構文が
  $
    n ::= zero() | one() | zero() n | one() n
  $
  の場合でも同様に定義できるか？ $->$ Yes!
  
  まず意味関数
  $
    cal(L) : Num() -> Int()
  $
  を以下のように定める：
  $ 
    cal(L)[|zero()|] = cal(L)[|1|] & = bold(1) \
    cal(L)[|zero() med n|] = cal(L)[|one() med n|] & = cal(L)[|n|] + bold(1) \
  $
  これはwell-defindであり，
  $n in Num()$の長さを表すものと解釈できる．
  さらに意味関数
  $
    cal(N) : Num() -> Int()
  $
  を以下のように定める：
  $ 
    cal(N)[|zero()|] & = bold(0) \
    cal(N)[|one()|] & = bold(1) \
    cal(N)[|zero() med n|] & = cal(N)[|n|] \
    cal(N)[|one() med n|] & = 2^(cal(L)[|n|]-1) + cal(N)[|n|] \
  $
  これもwell-defindであり，
  $n in Num()$の10進数表示と解釈できる．
]

#note[
  so for S V#sub[p.p.] : これまでのところSはVしてきた \
  gives rise to O : O のもとである，（よくないことを）引き起こす \
  this is indeed the case : 実際にその通りである[強調]
]

#show math.equation: set text(font: ("New Computer Modern Math", "Yu Mincho"))
#Fact[
  上記の$cal(N)$が満たす等式は全関数$cal(N):Num() -> Int()$を定義する．
  #proof[
    任意の引数$n in cal(N)$に対して
    #math.equation(
      block: true,
      numbering: "(*)",
      supplement: none,
    )[
      #box()[
        $cal(N)[|n|] = bold("n")$を満たす$bold("n") in Int()$が存在する
      ]
    ] <fact_1.5>
    となるとき，$cal(N)$が全関数となる．
    数値$n$が与えられたならば，
    それは4つの形のうちの1つ，
    すなわちそれが基本要素(a basis element)のときは$zero()$または$one()$，
    複合要素(a composite element)のときは別の数値$n'$が存在して$n' zero()$または$n' one()$と表せる．
    よって(@fact_1.5)を示すために，
    4つすべての可能性を考慮しなければならない．

    証明は数値$n$についての構造的帰納法によって行われる．
    基底ケースでは，
    $Num()$の基本要素，
    つまり$n$が$zero()$または$one()$の場合について示す．
    帰納ステップでは，
    $Num()$の複合要素，
    つまり$n$が$n' zero()$または$n' one()$の場合について示す．
    帰納法の仮定は$n$の直接の構成要素（つまり$n'$）に対して(@fact_1.5)の成立を仮定することを許す．
    次に$n$に対して(@fact_1.5)が成り立つことを示す．
    そのとき，
    すべての数値$n$に対して(@fact_1.5)が成り立つことが従う．
    なぜなら，任意の数値$n$はそのように構成されるからである．

    $n = zero()$の場合：
    $cal(N)$を定義する意味節のうち1つのみが使われ，
    それは$cal(N)[|n|] = bold(0)$を与える．
    よって明らかに唯一の数$n in Int()$（すなわち$bold(0)$）が存在して$cal(N)[|n|] = bold("n").$

    $n = one()$の場合：同様．

    $n = n' zero()$の場合：
    $cal(N)$を定義する節の検証は節のうち1つのみが適用可能であることを示していて，
    $cal(N)[|n|] = 2 dot cal(N)[|n'|]$である．
    ここで$n'$に帰納法の仮定を適用すると，
    $cal(N)[|n'|] = bold("n'")$を満たす$bold("n'")$が唯一つ存在する．
    しかしこのとき，
    明らかに$cal[|n|] = bold("n")$を満たす$bold("n")$（すなわち$2 dot n'$）が唯一つ存在する．

    $n = n' one()$の場合：同様．
  ]
]

*構成的定義*は以下の要件を満たす。
+ 統語範疇は基本要素と複合要素を与える抽象構文によって特定される．
  複合要素はそれらの直接の構成要素への唯一の分解をもつ．
+ 意味論は関数の構成的定義により定義される：
  統語範疇のすべての基本要素および構成要素を構成するすべての方法に対して意味節が存在する．
意味節

*構造的帰納法*は以下の要件を満たす。
+ 統語範疇のすべての基本要素に対して性質を示す．
+ 統語範疇のすべての複合要素に対して性質を示す：
  その要素のすべての直接の構成要素に対して性質が成り立つと仮定し，
  その要素自身にも成り立つことを示す．

#note[
    constituent : 構成要素
  ]
  
#note[
  compositional（構成的）は全体の意味を特定するには部分の意味を特定すればよいということを強調．
  inductive（帰納的）は全体を構成するためのプロセス（木構造等）すなわち形式に注目している．
  どちらもrecursive（再帰的）ではある．
]

=== Semantic Functions

式の意味は式に出現する変数に割り当てられた値に依存する．
そこで状態(state)の概念を定義する．
状態は各変数に対して，その現在の値を結びつける．
これを変数から値への関数として表現する．
つまり，
$ State() = Var() -> Int() $

#note[
  後述を考えるとおそらく
  $ State() = {s | s : Var() -> Int()} $
  という意味だろう．
]
各変数$x in Var()$に対する状態$s$の値を$s x$と書く．
#align(center)[
  #table(
    columns: 2,
    inset : (x: 30pt, y: 10pt),
    stroke: (x, y) => (
      left: if x <= 1 {1pt}, 
      right: if x <= 1 {1pt}, 
      top: if y < 1 {1pt}, 
      bottom: if y > 1 {1pt}, 
    ),
    [$vx()$], [$bold(5)$],
    [$vy()$], [$bold(7)$],
    [$vz()$], [$bold(0)$],
  )
]
のように表を用いたり，
$
  [vx() |-> bold(5), vy() |-> bold(7), vz() |-> bold(0)]
$
のようにリスト形式を使うこともある．
各変数にはただ一つの値が結び付けられていなければならない．
これは状態を関数として定義すれば自明に満たされる．
ただし表やリスト形式の場合には書かれていない変数にもこの制限がつくことを忘れてはならない．

算術式$a$と状態$s$が与えられたならば，
その式の値を決定することができる．
したがって，
算術式の意味論としての全関数$cal(A)$は二つの引数（算術式の構文と状態）をとる．
$
  cal(A) : Aexp() -> (State() -> Int())
$

引数は一度にひとつずつとる．
例えば，$vx() + one()$を第一引数にとると，
関数
$
  cal(A)[|vx() + one()|] : State() -> Int()
$
を調べることになる．
状態を与えたときしか我々は$vx() + one()$の値を取得できない．

#note[
  only when we supply it ... do we obtain ... は
  we obtain ... only when we supply it ... の倒置．
  ここでのonly (when)は「...（のとき）しか...しない」という否定の意味を作る働き．
]

数値の意味論を定義する関数$cal(N)$の存在を仮定すると，
各算術式$a$と状態$s$に対して$cal(A)$の値$cal(A)[|a|]s$を定めることで，
関数$cal(A)$を定義できる．
次のようにして与えられる：
$
  cal(A)[|n|]s & = cal(N)[|n|] \
  cal(A)[|x|]s & = s x \
  cal(A)[|a_1 + a_2|]s & = cal(A)[|a_1|]s + cal(A)[|a_2|]s \
  cal(A)[|a_1 star a_2|]s & = cal(A)[|a_1|]s dot cal(A)[|a_2|]s \
  cal(A)[|a_1 - a_2|]s & = cal(A)[|a_1|]s - cal(A)[|a_2|]s \
$
ここで，
右辺に現れる$+, -$は算術の演算子であり，
左辺に現れる$+, -$は単に構文の一部である．
これは数値と数の違いとのアナロジー（似たような考え方）である．
なお異なる記号を使うことにはこだわらないことにする．

#Eg[
  $s vx() = bold(3)$の場合における$cal(A)[|vx() + one()|]s$の計算を示している．
]

#Eg[
  算術式の構文に$-a$を追加した場合，
  $cal(A)$の定義に
  $
    cal(A)[|-a|]s = bold(0) - cal(A)[|a|]s
  $
  をつけ加えればよい．
  ただし，
  $
    cal(A)[|-a|]s = cal(A)[|zero() - a|]s
  $
  は構成的定義の要求に矛盾する．

  #note[
    ここでの「矛盾する」の意味は，
    構成的定義の要求に則っていないということを「強調」しているだけである（この定義を採用しても計算上の不都合が起きるわけではない．）．
    つまり，右辺に現れる$zero()$が左辺に現れる$-a$の直接の構成要素ではないということである．
    なお$-a$を$zero() - a$の省略と定義すれば特に問題はない．
    // なぜならこれは$cal(A)[|a_1 - a_2|]s$の計算として扱えるからである．
  ]
]

#Ex[
  // $cal(A)$が全関数であることを示す．
  $s in State()$を任意とする．

  $a = n med (in Num())$の場合：
  $bold("v") = cal(N)[|n|] in Int()$とすれば，
  $
    cal(A)[|a|]s = cal(N)[|n|] = bold("v").
  $

  $a = x med (in Var())$の場合：
  $bold("v") = s x $とすれば，
  $s in State()$より$bold("v") in Int()$であり，
  $
    cal(A)[|a|]s = s x = bold("v").
  $

  $a = a_1 + a_2 $の場合：
  構造的帰納法の仮定より，
  $a_1, a_2 in Aexp()$に対して，
  $
    cal(A)[|a_1|]s = bold("v")_1 \
    cal(A)[|a_2|]s = bold("v")_2 \
  $
  となる$bold("v")_1, bold("v")_2 in Int()$が存在する．
  このとき$bold("v")_1 + bold("v")_2 in Int()$であり，
  よって，
  $bold("v") = bold("v")_1 + bold("v")_2$とすれば，
  $bold("v") in Int()$であり，
  $
    cal(A)[|a_1 + a_2|]s = cal(A)[|a_1|]s + cal(A)[|a_2|]s = bold("v")_1 + bold("v")_2 = bold("v").
  $

  $a = a_1 - a_2$および$a = a_1 star a_2$の場合：$a = a_1 + a_2$の場合と同様．

  以上より任意の$a in Aexp(), s in State()$に対して，
  $
    cal(A)[|a|]s = bold("v")
  $
  となる$bold("v") in Int()$が存在することが示された．
]

ブール式の値は真理値である．
算術式の意味論と同様の方法でブール式の意味論も定められる．
$State()$から$truth()$への全関数を用いて次のようになる．
$
  cal(B) : Bexp() -> (State() -> truth())
$
ここで，
$truth()$は$tt()$（真）と$ff()$（偽）からなる集合である．

$cal(A)$を用いて$cal(B)$の意味節を以下のように定義できる：
$
  cal(B)[|vtrue()|]s & = tt() \
  cal(B)[|vfalse()|]s & = ff() \
  cal(B)[|a_1 = a_2|]s & =
  cases(
   thin & tt() quad & "if" cal(A)[|a_1|]s = cal(A)[|a_2|]s,
    & ff() & "if" cal(A)[|a_1|]s != cal(A)[|a_2|]s
  ) \
  cal(B)[|a_1 <= a_2|]s & =
  cases(
   thin & tt() quad & "if" cal(A)[|a_1|]s <= cal(A)[|a_2|]s,
    & ff() & "if" cal(A)[|a_1|]s > cal(A)[|a_2|]s
  ) \
  cal(B)[|not b|]s & =
  cases(
   thin & tt() quad & "if" cal(B)[|b|]s = ff(),
    & ff() & "if" cal(B)[|b|]s = tt()
  ) \
  cal(B)[|b_1 and b_2|]s & =
  cases(
   thin & tt() quad & "if" cal(B)[|b_1|]s = tt() "and" cal(B)[|b_2|]s = tt(),
    & ff() & "if" cal(B)[|b_1|]s = ff() "or" cal(B)[|b_2|]s = ff()
  ) \
$

#Ex[
  $cal(A)[|x|]s = s x = bold(3), cal(A)[|1|]s = cal(N)[|1|] = bold(1)$より，
  $cal(A)[|x|]s != cal(A)[|1|]s$.

  $therefore cal(B)[|vx() = 1|] = ff().$

  $therefore cal(B)[|not(vx() = 1)|] = tt().$
]

#Ex[
  略
]

#Ex[
  $Bexp()'$の意味論は$Bexp()$の意味論に以下を追加すればよい．
  $
  cal(B)[|b_1 or b_2|]s & =
  cases(
   thin & tt() quad & "if" cal(B)[|b_1|]s = tt() "or" cal(B)[|b_2|]s = tt(),
    & ff() & "if" cal(B)[|b_1|]s = ff() "and" cal(B)[|b_2|]s = ff()
  ) \
  cal(B)[|b_1 => b_2|]s & =
  cases(
   thin & tt() quad & "if" cal(B)[|b_1|]s = ff() "or" cal(B)[|b_2|]s = tt(),
    & ff() & "if" cal(B)[|b_1|]s = tt() "and" cal(B)[|b_2|]s = ff()
  ) \
  cal(B)[|b_1 <=> b_2|]s & =
  cases(
   thin & tt() quad & "if" cal(B)[|b_1|]s = cal(B)[|b_2|]s,
    & ff() & "if" cal(B)[|b_1|]s != cal(B)[|b_2|]s
  ) \
$
二つ目の主張は$b' = b_1 or b_2 | b_1 => b_2 | b_1 <=> b_2$だけ考えればよい（それ以外は$b' = b$でよい）．
それぞれ以下の表のように対応させればよい：
#align(center)[
  #table(
    columns: 2,
    inset : (x: 10pt, y: 10pt),
    stroke: (x, y) => (
      left: if x <= 1 {1pt}, 
      right: if x <= 1 {1pt}, 
      top: if y <= 1 {1pt}, 
      bottom: if y > 2 {1pt}, 
    ),
    [$b'$], [$b$],
    [$b_1 or b_2$], [$not(not b_1 and not b_2)$],
    [$b_1 => b_2$], [$not(b_1 and not b_2)$],
    [$b_1 <=> b_2$], [$not(b_1 and not b_2) and not(b_2 and not b_1)$],
  )
]
]

== Properties of the Semantics

後半では式についての二つの性質に関心をもつ．
+ 式の値は式に現れない変数の値に依存しないこと．
+ 変数を式で置き換えたとき，状態も同様の変化をしてよいこと．
以下でこれらを形式化し証明する．

=== Free Variables

算術式$a$の自由変数はその中に出現する変数の集合である．
形式的には$Var()$の部分集合$"FV"(a)$の構成的定義で与える：
$
  "FV"(n) &= emptyset \
  "FV"(x) &= {x} \
  "FV"(a_1 + a_2) &= "FV"(a_1) union "FV"(a_2) \
  "FV"(a_1 star a_2) &= "FV"(a_1) union "FV"(a_2) \
  "FV"(a_1 - a_2) &= "FV"(a_1) union "FV"(a_2) \
$

#Lem[
  $s, s'$を任意の$x in "FV"(a)$に対して$s x = s' x$を満たす状態とする．
  このとき，$cal(A)[|a]s = cal(A)[|a]s'$.

  #proof[
    算術式の構造的帰納法を用いてかなり詳細な証明を与える．
    まずは$Aexp()$の基本要素に対して考える．

    $n$の場合：
    算術式の定義から$cal(A)[|n|]s = cal(N)[|n|], cal(A)[|n|]s' = cal(N)[|n|]$である．
    よって，
    $cal(A)[|n|]s = cal(A)[|n|]s'.$

    $x$の場合：
    算術式の定義から$cal(A)[|x|]s = s x, cal(A)[|x|]s' = s' x$である．
    補題の仮定より$x in "FV"(x)$に対して$s x = s' x$なので，
    明らかに成り立つ．

    次は$Aexp()$の複合要素に対して行う．

    $a_1 + a_2$の場合：
    算術式の定義から$cal(A)[|a_1 + a_2|]s = cal(A)[|a_1|]s + cal(A)[|a_2|]s, cal(A)[|a_1 + a_2|]s' = cal(A)[|a_1|]s' + cal(A)[|a_2|]s'$である．
    $a_i (i = 1, 2)$が$a_1 + a_2$の直接の部分式であり，
    $"FV"(a_1) subset.eq "FV"(a_1 + a_2)$なので，
    $a_i$に対して帰納法の仮定（つまり補題）を適用でき，
    $cal(A)[|a_i]s = cal(A)[|a_i]s'$を得る．
    $a_1 + a_2$についても同様に補題が成り立つことが簡単に分かる．

    $a_1 star a_2$と$a_1 - a_2$の場合は同じパターンであるから省略する．
  ]
]

同様に，
ブール式の自由変数の集合を以下のように定義できる：
$
  "FV"(vtrue()) &= emptyset \
  "FV"(vfalse()) &= emptyset \
  "FV"(a_1 = a_2) &= "FV"(a_1) union "FV"(a_2) \
  "FV"(a_1 <= a_2) &= "FV"(a_1) union "FV"(a_2) \
  "FV"(not b) &= "FV"(b) \
  "FV"(b_1 and b_2) &= "FV"(b_1) union "FV"(b_2) \
$

#Ex[
  略
]

=== Substitutions

#Ex[
  $s in State()$を任意とする．
  $a in Aexp()$についての構造的帰納法による．
  
  #set enum(numbering: "1.1", full: true)
  + 基底ステップ
    + $a = n$の場合：
    $
      cal(A)[|a[y|->a_0]|]s
      = cal(A)[|n[y|->a_0]|]s
      = cal(A)[|n|]s.
    $
    $cal(A)[|n|]s$は$s$に依存しないので，
    $
      cal(A)[|a[y|->a_0]|]s = cal(A)[|n|]s = cal(A)[|n|](s[y|->cal(A)[|a_0|]s]) = cal(A)[|a|](s[y|->cal(A)[|a_0|]s]).
    $
    + $a = x$の場合：
      さらに$x = y$と$x != y$で場合分けする．
      + $x = y$の場合：
        $a[y|->a_0] = y[y|->a_0] = a_0$より，
        #h(1fr)
        $
          cal(A)[|a[y|->a_0]|]s = cal(A)[|a_0|]s.
        $
        また，$s' = s[y|->cal(A)[|a_0|]s]$とすると，
        $
          cal(A)[|a|]s' = cal(A)[|y|]s' = s'y = (s[y|->cal(A)[|a_0|]s]) y = cal(A)[|a_0|]s.
        $
        $therefore cal(A)[|a[y|->a_0]|]s = cal(A)[|a|](s[y|->cal(A)[|a_0|]s]).$
      + $x != y$の場合：
        $a[y|->a_0] = x[y|->a_0] = x$より，
        #h(1fr)
        $
          cal(A)[|x[y|->a_0]|]s = cal(A)[|x|]s = s x.
        $
        また，$s' = s[y|->cal(A)[|a_0|]s]$とすると，
        $
          cal(A)[|a|]s' = cal(A)[|x|]s' = s'x = (s[y|->cal(A)[|a_0|]s]) x = s x.
        $
        $therefore cal(A)[|a[y|->a_0]|]s = cal(A)[|a|](s[y|->cal(A)[|a_0|]s]).$
  + 帰納ステップ

    $a = a_1 + a_2$の場合だけ示す（$a = a_1 - a_2$および$a = a_1 star a_2$の場合も同様にして示せる）．
    簡単のため以下の略記を与える：
    $
      a'_1 = a_1[y|->a_0],
      a'_2 = a_2[y|->a_0],
      s' = s[y|->cal(A)[|a_0|]s]
    $
    帰納法の仮定より，
    $
      cal(A)[|a'_1|]s = cal(A)[|a_1[y|->a_0]|]s = cal(A)[|a_1|](s[y|->cal(A)[|a_0|]s]) = cal(A)[|a_1|]s', \
      cal(A)[|a'_2|]s = cal(A)[|a_2[y|->a_0]|]s = cal(A)[|a_2|](s[y|->cal(A)[|a_0|]s]) = cal(A)[|a_2|]s'.
    $
    このとき，
    $
      cal(A)[|a[y|->a_0]|]s
      &= cal(A)[|(a_1 + a_2)[y|->a_0]|]s \
      &= cal(A)[|(a_1[y|->a_0]) + (a_2[y|->a_0])|]s \
      &= cal(A)[|a'_1 + a'_2|]s \
      &= cal(A)[|a'_1|]s + cal(A)[|a'_2|]s \
      &= cal(A)[|a_1|]s' + cal(A)[|a_2|]s' \
      &= cal(A)[|a_1 + a_2|]s' \
      &= cal(A)[|a|]s' \
      &= cal(A)[|a|](s[y|->cal(A)[|a_0|]s]). \
    $
]

#Ex[
  略
]

= Operational Semantics
a
#Ex[
  a
]
>>>>>>> 379620bac56d9b956afa363e5f20b470acbc8aa6

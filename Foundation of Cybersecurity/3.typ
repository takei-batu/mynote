#import "setting.typ":*
#show: conf

#set page(
  header: align(right)[26M30015 筏井 俊介],
  footer: context {
    align(center)[
      #counter(page).display()
    ]
  } 
)

#set enum(numbering: "1.a.")
+ 公開鍵暗号について
  + 公開鍵を発行した機関が正当であることを（信頼できる第三者が）保証する．
  + 開始時刻：2025/09/19 13:23:05 JST
    終了時刻：2026/10/20 13:23:05 JST
  + 開始時刻：2020/12/15 17:46:22 JST
    終了時刻：2029/05/29 14:00:39 JST
+ ECDHEによる鍵交換ではForward security, 
  すなわち秘密鍵が漏洩してしまったとしてもそれ以前の通信の安全性が保たれる性質を持つが，
  公開鍵暗号による鍵交換ではこの性質を持たないため．
  
#import "setting.typ":*
#show: conf

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  counter(page).update(1)
  it
}
#set page(
  header: align(right)[26M30015 筏井 俊介],
  footer: context {
    align(center)[
      #counter(page).display()
    ]
  } 
)

#include "asg1.typ"
#include "asg2.typ"
=
=
=
=
#include "asg7.typ"
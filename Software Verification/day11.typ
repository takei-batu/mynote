#import "utils.typ":*

=

$sigma tack.double phi_1 bold("U") phi_2 <=> exists k >= 0 [forall i [0 <= i < k => sigma^i tack.double phi_1] and sigma^k tack.double phi_2]$
より

$sigma tack.double bold("F") phi 
&<=> sigma tack.double "true" bold("U") phi \ 
&<=> exists k >= 0 [forall i [0 <= i < k => sigma^i tack.double "true"] and sigma^k tack.double phi]\ 
&<=> exists k >= 0 [sigma^k tack.double phi]$

$sigma tack.double bold("G") phi 
&<=> sigma tack.double not F not phi \ 
&<=> not exists k >= 0 [sigma^k tack.double not phi]\
&<=> forall k >= 0 [sigma^k tack.double phi]$

$bold("G") phi equiv not bold("F") not phi$

$sigma tack.double bold("XF") phi 
&<=> sigma^1 tack.double bold("F") phi \
&<=> exists k >= 0 [sigma^(k+1) tack.double phi]$

$sigma tack.double bold("GX") phi 
&<=> sigma^1 tack.double forall k >= 0 [sigma^k tack.double bold("X") phi] \
&<=> forall k >= 0 [sigma^(k+1) tack.double phi]$

$bold("GX") phi equiv not bold("XF") not phi$

#Ex[
  - $p bold("U")bold("G") not q$
  - $(not p) bold("U") (p and bold("G")bold("X") not p)$
]
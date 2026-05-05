import os
import csv
from queen import Queen, vsSAT

'''
出力形式 csv

出力例

N sec
1 0.000001
2 0.000002
...

'''

N = 10
timeout = 60

# name = "backtrackv"
# name = "backtrack"
# name = "bitmap-1"
name = "bitmap-1"

path = os.path.join(os.path.dirname(__file__), f"{name}.csv")
header = ['N', 'sec', 'status']
with open(path, 'w') as f:
	writer = csv.writer(f)
	writer.writerow(header)
	for i in range(1, N + 1):
		# Q = Queen(i)
		Q = vsSAT(i)
		# Q.check(Q.backtrack,timeout)
		Q.check(Q.bitmap,timeout)
		writer.writerow([i, f"{Q.diff:.6f}", Q.status])

print(f"created CSV at '{path}'.")

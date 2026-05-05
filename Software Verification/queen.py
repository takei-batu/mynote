import time
import signal

# 一定時間で実行を切り上げる例外
class Timeout(Exception):
	def __str__(self):
		return "Time-up"

# 探索を打ち切るための例外
class FoundSolution(Exception):
	def __str__(self):
		return "Found solution"

def handler(signum, frame):
	raise Timeout

# 実行時間の計測
def benchmark(queen_instance, func, timeout):
	queen_instance.count = 0
	print(f"{queen_instance.size}-Queen-problem by {func.__name__}", flush=True)

	# アラームセット
	signal.signal(signal.SIGALRM, handler)
	signal.setitimer(signal.ITIMER_REAL, timeout)

	# 計測開始
	start_time = time.perf_counter()
	try:
		func()
		diff = time.perf_counter() - start_time
		if queen_instance.count:
			status = f"The number of solutions : {queen_instance.count}"
		else:
			status = f"No solution"
	except (Timeout, FoundSolution) as e:
		diff = time.perf_counter() - start_time
		status = str(e)
	finally:
		# アラーム解除
		signal.setitimer(signal.ITIMER_REAL, 0)

	queen_instance.status = status
	queen_instance.diff = diff


'''
アルゴリズム1 : （通常の）バックトラック -> backtrack()
参考文献 : https://qiita.com/yudai_suita/items/91f49c290c7156516440
アルゴリズム2 : ビットマップ -> bitmap()
参考文献 : https://suzukiiichiro.github.io/posts/2023-06-13-05-n-queens-suzuki/
ただし，上記のコードをまとめてクラスにして扱う
SATと比較するために, 解を全探索するものと解を一つ見つけた時点で終了するものを作成
signalを使う関係で linux/mac 上でのみ動作
'''
class Queen:
	def __init__(self, N:int):
		self.size = N # 行（列）の数
		self.range = range(self.size) # {x | 0 <= x < N}
		self.board = [-1 for _ in self.range] # 通常のバックトラックで使用
		self.mask = (1 << self.size) - 1 # ビットマップで使用
		self.count = 0 # 解の個数

	# 解の計算
	def solution(self):
		self.count += 1
	
	# 配置可能性判定
	def placeable(self, x, y) -> bool:
		for i in range(x):
			# 列に置けるか
			if self.board[i] == y:
					return False
			# 対角線上に置けるか
			if abs(i - x) == abs(self.board[i] - y):
					return False
		return True

	# 通常のバックトラック
	def backtrack(self, x:int=0):
		if x == self.size:
			self.solution()
		else:
			for y in self.range:
				if self.placeable(x, y):
					self.board[x] = y
					self.backtrack(x + 1)
	
	# ビットシフトを利用したバックトラック
	'''
	ビット列で各行のどの列にqueenが配置可能かを表す
	pos: 0 -> 配置不可, 1 → 配置可能
	BL(Bottom Left), B(Bottom), BR(Bottom Right): 0 -> 配置可能, 1 → 配置不可
	BL, B, BR はひとつ前の行のposに依存して決まる(スタートは0)
	'''
	def bitmap(self, row=0, BL=0, B=0, BR=0):
		# n行目で終了
		if row == self.size:
			self.solution()
		else:
			pos = ~(BL|B|BR) & self.mask
			while pos:
				p = pos & -pos # 配置可能なビットの右端のビットを取り出す
				self.bitmap(row + 1, (BL | p) << 1, B | p, (BR | p) >> 1) # 次の行へ進む
				pos &= pos - 1 # 失敗した場合、戻って来て右端の候補を消す

	def check(self, func, timeout:float=30):
		benchmark(self, func, timeout)
		print(self.status)
		print(f"Execution time : {self.diff:.6f} sec")

# SATと比較するためのオーバーロード
class vsSAT(Queen):
	def __init__(self, N, target:int=1):
		super().__init__(N)
		self.target = target

	def solution(self):
		super().solution()
		if self.count == self.target:
			raise FoundSolution

# テスト
if __name__ == "__main__":
  N = 2
  # Q1 = Queen(N)
  # Q1.check(Q1.backtrack)
  # print("-"*10)
  # Q1.check(Q1.bitmap)
  Q2 = vsSAT(N)
  Q2.check(Q2.backtrack)
  print("-"*10)
  Q2.check(Q2.bitmap)

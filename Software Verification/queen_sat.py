import os
from itertools import product

class QueenFormat:
  def __init__(self, N:int):
    self.size = N # 行（列）の数
    self.num_prop = N * N # マスの数
    self.range = range(1, self.size + 1) # {x | 1 <= x <= N}

    
  # p(i, j) : (i, j) にクイーンがいる
  def p(self, i:int, j:int) -> str:
    return str((i - 1) * self.size + j)
  
  # p(i, j) : (i, j) にクイーンがいない
  def not_p(self, i:int, j:int) -> str:
    return "-" + self.p(i, j)
  
  # 各行にクイーンが少なくとも1ついる
  def row(self) -> list[int]:
    return [" ".join(self.p(i, j) for j in self.range) for i in self.range]
  
  # 各行にクイーンがいるなら1つだけである
  def only_one_row(self) -> list[int]:
    return [self.not_p(i, j) + " " + self.not_p(i, k) for i, j, k in product(self.range, repeat=3) if j < k]
  
  # 各列にクイーンがいるなら1つだけである
  def only_one_col(self) -> list[int]:
    return [self.not_p(i, j) + " " + self.not_p(k, j) for i, j, k in product(self.range, repeat=3) if i < k]
  
  # 右上がりの対角線上にクイーンがいるなら1つだけである
  # 右上がり : i + j の差が一定
  # (0 < i + j - k <= N) => (i + j - N <= k < i + j)
  # i + j - N < j
  def only_one_up_right(self) -> list[int]:
    return [self.not_p(i, j) + " " + self.not_p(i + j - k, k) for i, j, k in product(self.range, repeat=3) if j < k < i + j]

  # 左上がりの対角線上にクイーンがいるなら1つだけである
  # 左上がり : i - j の差が一定
  # (0 < i - j + k <= N) => (j - i < k <= N - i + j)
  # j - i < j
  def only_one_down_right(self) -> list[int]:
    return [self.not_p(i, j) + " " + self.not_p(i - j + k, k) for i, j, k in product(self.range, repeat=3) if j < k <= self.size - i + j]
  
  def print_DIMACS(self, path:str=None):
    all = self.row() + self.only_one_row() + self.only_one_col() + self.only_one_up_right() + self.only_one_down_right()
    head = f"p cnf {self.num_prop} {len(all)}"
    body = " \n".join(map(lambda s: s + " 0", all))

    if path == None:
      print(head, body, sep="\n")
    else:
      with open(path, "w") as o:
        print(head, body, sep="\n", file=o)


if __name__ == "__main__":
  N = 2
  SAT = QueenFormat(N)
  # print(SAT.row())
  # print(SAT.only_one_row())
  # print(SAT.only_one_col())
  # print(SAT.only_one_up_right())
  # print(SAT.only_one_down_right())
  # SAT.print_DIMACS()

  name = f"N={N}"
  path = os.path.join(os.path.dirname(__file__), f"{name}.cnf")
  print(f"created CNF for {N}-Queen-problem at '{path}'.")
  SAT.print_DIMACS(path)
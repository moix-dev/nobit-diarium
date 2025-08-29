module Nobit.Nature (nature, Nature(..)) where

-- /corpus/2025.08.26.md
data Nature = NobitPositive | NobitNegative | Debit | Credit
  deriving (Eq, Show)

nature :: Int -> Int -> Nature
nature s n = case [s,n] of
  [0,0] -> NobitPositive
  [0,1] -> NobitNegative
  [1,0] -> Debit
  [1,1] -> Credit

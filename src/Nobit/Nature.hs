module Nobit.Nature (nature) where

-- /corpus/2025.08.26.md
data Nature = NobitPositive | NobitNegative | Debit | Credit
  deriving (Eq, Show)

nature bits = case bits of
  00 -> show NobitPositive
  01 -> show NobitNegative
  10 -> show Debit
  11 -> show Credit

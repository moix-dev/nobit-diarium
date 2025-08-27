module Lib where

-- /corpus/2025.08.26.md
data Nature = NobitPositive | NobitNegative | Debit | Credit
  deriving (Eq, Show)

data Account

data Entry

data DiaryBook

data MajorBook

nature bits = case bits of
  00 -> show NobitPositive
  01 -> show NobitNegative
  10 -> show Debit
  11 -> show Credit

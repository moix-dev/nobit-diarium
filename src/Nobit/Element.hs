module Nobit.Element (element) where

-- /corpus/2025.08.28.md
data Element = Data | Assets | Liabilities | Capital | Revenues | Expenses | Dividends
  deriving (Eq, Show)

element id
  | id < 1.0 = show Data
  | id < 2.0 = show Assets
  | id < 3.0 = show Liabilities
  | id < 4.0 = show Capital
  | id < 5.0 = show Revenues
  | id < 6.0 = show Expenses
  | id < 7.0 = show Dividends
  | otherwise = show Data

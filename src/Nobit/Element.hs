module Nobit.Element (element, Element(..)) where

-- /corpus/2025.08.28.md
-- /corpus/2025.08.29.md
data Element = Data 
  | Assets | Liabilities | Capital 
  | Revenues | Expenses | Dividends 
  | Internal | External
  | Temporary
  deriving (Eq, Show)

element :: Float -> Element
element id
  | id < 1.0 = Data -- 0.0
  | id < 2.0 = Assets -- 1.0
  | id < 3.0 = Liabilities -- 2.0
  | id < 4.0 = Capital -- 3.0
  | id < 5.0 = Revenues -- 4.0
  | id < 6.0 = Expenses -- 5.0
  | id < 7.0 = Dividends -- 6.0
  | id < 8.0 = Internal -- 7.0
  | id < 9.0 = External -- 8.0
  | id < 10.0 = Temporary -- 9.0
  | otherwise = Data

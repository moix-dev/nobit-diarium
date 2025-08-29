module Main where

import Nobit (element, Element(..), nature, Nature(..))
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
  testGroup
    "Tests"
    [ testCase "OK" $ True @?= True,
      -- NATURE
      testCase "nature 0 0" $ nature 0 0 @?= NobitPositive,
      testCase "nature 0 1" $ nature 0 1 @?= NobitNegative,
      testCase "nature 1 0" $ nature 1 0 @?= Debit,
      testCase "nature 1 1" $ nature 1 1 @?= Credit,
      -- ELEMENT
      testCase "element 0.0" $ element 0.0 @?= Data,
      testCase "element 1.0" $ element 1.0 @?= Assets,
      testCase "element 2.0" $ element 2.0 @?= Liabilities,
      testCase "element 3.0" $ element 3.0 @?= Capital,
      testCase "element 4.0" $ element 4.0 @?= Revenues,
      testCase "element 5.0" $ element 5.0 @?= Expenses,
      testCase "element 6.0" $ element 6.0 @?= Dividends,
      testCase "element 7.0" $ element 7.0 @?= Internal,
      testCase "element 8.0" $ element 8.0 @?= External,
      testCase "element 9.0" $ element 9.0 @?= Temporary
    ]

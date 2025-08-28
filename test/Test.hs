module Main where

import Nobit (element, nature)
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
      testCase "nature 00" $ nature 00 @?= "NobitPositive",
      testCase "nature 01" $ nature 01 @?= "NobitNegative",
      testCase "nature 10" $ nature 10 @?= "Debit",
      testCase "nature 11" $ nature 11 @?= "Credit",
      -- ELEMENT
      testCase "element 0.0" $ element 0.0 @?= "Data",
      testCase "element 1.0" $ element 1.0 @?= "Assets",
      testCase "element 2.0" $ element 2.0 @?= "Liabilities",
      testCase "element 3.0" $ element 3.0 @?= "Capital",
      testCase "element 4.0" $ element 4.0 @?= "Revenues",
      testCase "element 5.0" $ element 5.0 @?= "Expenses",
      testCase "element 6.0" $ element 6.0 @?= "Dividends"
    ]

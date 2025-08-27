module Main where

import Lib
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
  testGroup
    "Tests"
    [ testCase "OK" $ True @?= True,
      testCase "nature 00" $ nature 00 @?= "NobitPositive",
      testCase "nature 01" $ nature 01 @?= "NobitNegative",
      testCase "nature 10" $ nature 10 @?= "Debit",
      testCase "nature 11" $ nature 11 @?= "Credit"
    ]

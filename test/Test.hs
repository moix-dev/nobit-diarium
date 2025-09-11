module Main where

import Database.SQLite.Simple
import Nobit
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = defaultMain tests

tests :: TestTree
tests =
  testGroup
    "Tests"
    [ testCase "OK" $ True @?= True
    ]

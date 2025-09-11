module Main where

import Database.SQLite.Simple
import Nobit
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = do
  conn <- open "data/test.sqlite"
  defaultMain (tests conn)
  close conn

tests :: Connection -> TestTree
tests conn =
  testGroup
    "Tests"
    [ testCase "OK" $ True @?= True,
      testCase "Journal 2025" $ do
        journal <- withJournal conn 2025
        "Journal_2025" @?= journal
    ]

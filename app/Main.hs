{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Database.SQLite.Simple
import Nobit

main :: IO ()
main = do
  conn <- open "data/test.sqlite"
  journal <- withJournal conn 2025
  [[x :: Int]] <- query_ conn "SELECT 1 + 2"
  print x
  close conn

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Database.SQLite.Simple
import Nobit

main :: IO ()
main = do
  conn <- open "data/test.sqlite"
  [[x :: Int]] <- query_ conn "SELECT 2 + 2"
  print x

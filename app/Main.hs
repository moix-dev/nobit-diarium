module Main where

import Nobit

main :: IO ()
main = do
    journal <- loadFromData "data/data.test.txt"
    print journal

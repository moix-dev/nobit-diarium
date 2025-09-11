{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}

module Nobit where

import qualified Data.String as S
import Database.SQLite.Simple
import Database.SQLite.Simple.FromRow

journalSQL :: String -> Query
journalSQL name =
  S.fromString $
    concat
      [ "CREATE TABLE IF NOT EXISTS ",
        name,
        "(id INTEGER PRIMARY KEY AUTOINCREMENT",
        ",created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP",
        ",entry TEXT NOT NULL",
        ",account TEXT NOT NULL",
        ",nature INTEGER NOT NULL",
        ",amount NUMERAL NOT NULL CHECK(amount > 0)",
        ",entry_ref TEXT",
        ",__data TEXT",
        ")"
      ]

withJournal :: Connection -> Int -> IO String
withJournal conn period =
  do
    let name = "Journal_" ++ show period
        q = journalSQL name
    execute_ conn q
    return name

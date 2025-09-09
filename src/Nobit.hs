module Nobit where

data Journal = Journal
    deriving (Show, Read)

loadFromData :: FilePath -> IO Journal
loadFromData path = do
    txt <- readFile path
    return (read txt :: Journal)

module Files where

import System.Environment (getEnv)

-- Get $PATH and split the directories properly into a list.
getPath :: IO [String]
getPath = fmap split $ getEnv "PATH"
  where
    split :: String -> [String]
    split "" = []
    split s  = let (a,b) = break (== ':') s
                in a : split (dropWhile (== ':') b)


import Data.List (intersperse)
import System.Environment (getArgs, getEnv)
import System.IO (hFlush, stdout)

import FuzzyFinder

-- Get $PATH and split the directories properly into a list.
getPath :: IO [String]
getPath = fmap split $ getEnv "PATH"
  where
    split :: String -> [String]
    split "" = []
    split s  = let (a,b) = break (== ':') s
                in a : split (dropWhile (== ':') b)

main = do list <- getArgs
          path <- getPath
          putStr "Entery query: "
          hFlush stdout
          query <- getLine
          mapM_ putStrLn $ fuzzyFinder query list


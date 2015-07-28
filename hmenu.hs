import Data.List (intersperse)
import System.Environment (getArgs)
import System.IO (hFlush, stdout)

import Files
import FuzzyFinder

main = do path <- getPath
          list <- getExecutables path
          putStr "Entery query: "
          hFlush stdout
          query <- getLine
          mapM_ putStrLn $ fuzzyFinder query list


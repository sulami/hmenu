import Data.List (intersperse)
import System.Environment (getArgs)
import System.IO (hFlush, stdout)

import FuzzyFinder

main = do list <- getArgs
          putStr "Entery query: "
          hFlush stdout
          query <- getLine
          mapM_ putStrLn $ fuzzyFinder query list


import Data.List (intersperse)
import System.Environment (getArgs)
import System.IO (hFlush, stdout)

import Files
import FuzzyFinder

main = do list <- getArgs
          path <- getPath
          putStr "Entery query: "
          hFlush stdout
          query <- getLine
          mapM_ putStrLn $ fuzzyFinder query list


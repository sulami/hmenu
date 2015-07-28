module Main where

import Data.List (intersperse)
import System.Environment (getArgs)
import System.IO (
  hFlush, stdout, hSetBuffering, stdin, BufferMode (NoBuffering), hSetEcho
  )

import Files
import FuzzyFinder

ff :: [String] -> String -> IO ()
ff list q = do query <- getChar
               let nq = case query of
                          '\x7f' -> if q == "" then q else init q -- Backspace
                          '\x17' -> let ws = words q
                                    in if length ws == 1 then ""
                                       else unwords (init ws) ++ " " -- Ctrl-W
                          _      -> q ++ [query]
               putChar '\n'
               let results = case nq of
                              "" -> list
                              _  -> fuzzyFinder nq list
               mapM_ putStr $ intersperse " " results
               putStr $ "\n> " ++ nq
               hFlush stdout
               ff list nq

main = do path <- getPath
          list <- getExecutables path
          hSetBuffering stdin NoBuffering
          hSetEcho stdin False
          putStr "> "
          hFlush stdout
          ff list ""


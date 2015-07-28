module Main where

import Data.List (intersperse)
import System.Environment (getArgs)
import System.Exit (exitSuccess)
import System.IO (
  hFlush, stdout, hSetBuffering, stdin, BufferMode (NoBuffering), hSetEcho
  )
import System.Process (callCommand)

import Files
import FuzzyFinder

ff :: [String] -> String -> IO ()
ff list q = do query <- getChar
               let nq = case query of
                          '\x7f' -> if q == "" then q else init q -- Backspace
                          '\x17' -> ""                            -- Ctrl-w
                          '\n'   -> if q == "" then "true" else q -- Enter
                          _      -> q ++ [query]
               let results = case nq of
                              "" -> list
                              _  -> fuzzyFinder nq list
               if query == '\n'
                 then do callCommand $ head results
                         exitSuccess
                 else putChar '\n'
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


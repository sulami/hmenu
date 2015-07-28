module Main where

import Data.List (intersperse)
import System.Environment (getArgs)
import System.IO (
  hFlush, stdout, hSetBuffering, stdin, BufferMode (NoBuffering)
  )

import Files
import FuzzyFinder

ff :: [String] -> String -> IO ()
ff list q = do query <- getChar
               let nq = case query of
                          '\x7f' -> if q == "" then q else init q -- Backspace
                          _      -> q ++ [query]
               putChar '\r'
               case nq of
                 "" -> putStrLn $ "> " ++ nq
                 _  -> do mapM_ putStrLn $ fuzzyFinder nq list
                          putStrLn $ "> " ++ nq
               ff list nq

main = do path <- getPath
          list <- getExecutables path
          hSetBuffering stdin NoBuffering
          ff list ""


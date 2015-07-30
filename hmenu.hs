module Main where

import Data.List (intersperse)
import System.Cmd.Utils (forkRawSystem)
import System.Environment (getArgs)
import System.Exit (exitSuccess)
import System.IO (
  hFlush, stdout, hSetBuffering, stdin, BufferMode (NoBuffering), hSetEcho
  )

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
                 then do forkRawSystem (head results) []
                         exitSuccess
                 else putStr "\x1b[2K\r"
               let colo = case length results of
                            0 -> "\x1b[31m"
                            _ -> "\x1b[34m"
               putStr $ colo ++ nq ++ "\x1b[39m: "
               putStr $ unwords $ take 5 results
               hFlush stdout
               ff list nq

main = do path <- getPath
          list <- getExecutables path
          hSetBuffering stdin NoBuffering
          hSetEcho stdin False
          putStr $ ": " ++ unwords (take 5 list)
          hFlush stdout
          ff list ""


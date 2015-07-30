module FuzzyFinder (fuzzyFinder) where

import Data.Char (toLower)
import Data.List (sort)

prepInput :: [[Char]] -> [([Char], [Char])]
prepInput i = zip i $ map (map toLower) i

partOf :: Char -> [Char] -> Int -> (Bool, Int)
partOf _ []     r = (False, 0)
partOf c (x:xs) r |    c == x = (True, r + 1)
                  | otherwise = partOf c xs $ r + 1

match :: [Char] -> ([Char], [Char]) -> (Bool, [Int])
match i s = match' i (snd s) []
  where
    match' :: [Char] -> [Char] -> [Int] -> (Bool, [Int])
    match' []     _ r = (True, r)
    match' (x:xs) s r | fst check = match' xs (drop used s) $ r ++ [used]
                      | otherwise = (False, r)
      where
        used = snd check
        check = partOf x s 0

fuzzyFinder :: [Char] -> [[Char]] -> [[Char]]
fuzzyFinder input list = map fst . map snd $ sort combo
  where
    combo = zip (zip ((map sum . map tail) scores) (map head scores)) matches
    scores = map snd $ map (match input) matches
    matches = filter (fst . match input) $ prepInput list


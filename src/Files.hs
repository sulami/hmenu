module Files where

import System.Environment (getEnv)
import System.Process (readProcess)

-- Get $PATH and split the directories properly into a list.
getPath :: IO [String]
getPath = fmap split $ getEnv "PATH"
  where
    split :: String -> [String]
    split "" = []
    split s  = let (a,b) = break (== ':') s
                in a : split (dropWhile (== ':') b)

-- Get all executables in all dirs of $PATH. We use find(1) becuase it can do
-- what we want more easily than we could without too much effort.
getExecutables :: [String] -> IO [String]
getExecutables []     = return []
getExecutables (x:xs) = do e <- gE x
                           es <- getExecutables xs
                           return $ e ++ es
  where
    gE :: String -> IO [String]
    gE p = fmap words $ readProcess "find" [p, "-perm", "-a=x", "-printf",
                                            "%f\n"] []


module Main where

import System.IO -- to get stdout
import Lib

main :: IO ()
main = do
    putStr "awesomepret> "
    hFlush stdout -- putStrLn flushes, putStr does not.
    line <- getLine
    putStrLn $ show $ awesomepret $ read line
    main
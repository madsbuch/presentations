module Lib where

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- The datatype we work on
data ALang =
    Lit Float
  | Add ALang ALang
  | Mul ALang ALang
  | Sub ALang ALang
  | Div ALang ALang
  deriving (Show, Read)

--The interpreter which reduces the expression to a single value
awesomepret (Lit x)     = x
awesomepret (Add a b)   = (awesomepret a) + (awesomepret b)
awesomepret (Mul a b)   = let
                            ae = awesomepret a
                            be = awesomepret b
                          in
                             ae * be
awesomepret (Sub a b)   = ae - be
  where
    ae :: Float
    ae = awesomepret a
    be = awesomepret b
awesomepret (Div a b)
               | (awesomepret b) == 0    = error "Division by 0"
               | otherwise               = (awesomepret a) / (awesomepret b) 
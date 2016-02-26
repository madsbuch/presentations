---
title:  A Practical Introduction to Haskell - Presentation Notes
author: Mads Buch
---

_Some intro here_

# Assumptions
Assumptions for doing this presentation.

# Presentation Overview
The quick overview for the presentation

* Motivation
    - Haskell / Functional programming
        + Other paradigm in general
        + Efficiency: Reduction in time to write code
        + Flexible: Higher order functions provide extreme flexibility
        + Bug reductions: Strong typesystems prevent errors
* Environment: Haskell Stack
    - Setting up a project
        + `stack new`
        + `stack setup`: Environmet consistency, resolver from _stack.yaml_
    - `app` folder  
    - `src` folder
    - `test` folder
    - Package Administration
        + Adding Packages
        + Applying Changes: `stack solver --update-config`
* Functional Constructs: The `src` folder
    - ADTs
        + Modeling our problem using ADTs
        + Introducing the `deriving` functionality
    - Implementing the awesomepret function
        + Normal recursion
        + let .. in expression
        + where
        + guards. This is an excellent choice for handling division by 0
* Testing. So far HUnit, could also look at QuickCheck: The `test` folder
    - Importing the libraries
    - Implementing tests
    - running tests
    - [QuickCheck and property testing]
* Input Output: the `app` folder
    - Serial execution through Monads
    - the `Read` type class
    - looping by calling main
* Deploying
    - Oh well, call `stack build` -> `stack exec awesomepreter-exe`
    - [Docker integration]
    - [Build executable]

# Snippets to remember

## Add to `awesomepreter.cabal`

     -- HUnit test
     , HUnit
     , testpack
     , test-framework
     , test-framework-hunit

## `src/Lib.hs` Contents

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
    awesomepret :: ALang -> Float
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

## `test/spec.hs` Contents

    -- Import test framework
    import Test.HUnit
    import Test.Framework -- For defaultMainWithOpts
    import Test.Framework.Providers.HUnit -- Binding test framework to HUnit

    -- To be able to catch errors
    import Control.Exception (ErrorCall(ErrorCall), evaluate)
    import Test.HUnit.Tools (assertRaises)

    -- Import the Library
    import Lib

    -- Run the tests
    main :: IO ()
    main = defaultMainWithOpts
           [ testCase "Test a simple expression" awesomepretTest
           , testCase "Test division by 0 is illegal" divideByZero]
           mempty

    awesomepretTest :: Assertion
    awesomepretTest = assertEqual
        "A test"
        (awesomepret (Lit 4))
        4.0

    divideByZero :: Assertion
    divideByZero = assertRaises 
        "Division by cause the world to burn" (ErrorCall "Division by 0")
        (evaluate ( awesomepret (Div (Lit 5) (Lit 0))))

## `app/Main.hs` Contents

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
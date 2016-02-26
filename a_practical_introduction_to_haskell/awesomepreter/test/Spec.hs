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
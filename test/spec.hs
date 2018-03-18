import Data.List.NonEmpty
import Test.Tasty
import Test.Tasty.HUnit

import Gjallarbru

main :: IO ()
main = defaultMain (testGroup "gjallarbru" [parseErrors])

parseErrors :: TestTree
parseErrors = testGroup
    "parse errors"
    [ testCase "reports unclosed splice" $ parse "#{" @?= ParseErr
        (UnclosedSplice 1 3 :| [])
    , testCase "parses empty splice" $ parse "#{}" @?= ParseSuccess ()
    , testCase "parses unexpected right paren " $ parse "#{)}" @?= ParseErr
        (UnexpectedRParen 1 3 :| [])
    ]

-- What do I want to test? At the top, there are parse errors!

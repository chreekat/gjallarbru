import Data.List.NonEmpty
import Test.Tasty
import Test.Tasty.HUnit

import Gjallarbru

main :: IO ()
main = defaultMain $ testGroup "parse errors"
        [ testCase "reports unclosed splice" $ parse "#{" @?= ParseErr (UnclosedSplice 1 3 :| [])
        , testCase "parses empty splice" $ parse "#{}" @?= ParseSuccess ()
        , testCase "parses " $ pure ()
        ]

-- What do I want to test? At the top, there are parse errors!

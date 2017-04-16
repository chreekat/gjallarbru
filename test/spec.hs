import Data.List.NonEmpty
import Test.Tasty
import Test.Tasty.HUnit

import Gjallarbru

main :: IO ()
main = defaultMain $ testGroup "specs"
        [ testCase "reports unclosed splice" $ parse "#{" @?= ParseErr (UnclosedSplice 1 3 :|[])
        , testCase "parses empty splice" $ parse "#{}" @?= ParseSuccess ()
        ]

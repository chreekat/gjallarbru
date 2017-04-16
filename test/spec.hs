import Test.Tasty
import Test.Tasty.HUnit

import Gjallarbru

main :: IO ()
main = defaultMain $ testCase "test" $ parse "#{" @?= ParseErr [UnclosedSplice 1 3]

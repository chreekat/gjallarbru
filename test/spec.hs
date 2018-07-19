{-# LANGUAGE OverloadedStrings #-}
import Data.List.NonEmpty
import Test.Tasty
import Test.Tasty.HUnit

import Gjallarbru

it :: TestName -> Assertion -> TestTree
it = testCase

shouldBe :: (Eq a, Show a) => a -> a -> Assertion
shouldBe = (@?=)

main :: IO ()
main = defaultMain (testGroup "gjallarbru" [parsing])

parsing :: TestTree
parsing = testGroup
    "parsing"
    [ parseErrors
    , it "parses nothing" (parse "" `shouldBe` ParseSuccess GjZero)
    , it
        "parses static text"
        (parse "foo" `shouldBe` ParseSuccess (GjConst "foo" GjZero))
    , it "parses empty splice" (parse "#{}" `shouldBe` ParseSuccess GjZero)
    , it "parses static text with an empty splice" $ do
        parse "foo #{}" `shouldBe` ParseSuccess (GjConst "foo " GjZero)
        parse " #{}  " `shouldBe` ParseSuccess (GjConst "   " GjZero)
        parse "x#{}yy" `shouldBe` ParseSuccess (GjConst "xyy" GjZero)
    , it
        "parses a splice with a variable"
        (parse "#{foo}" `shouldBe` ParseSuccess (GjVar "foo" GjZero))
    , it "ignores whitespace padding in splice" $ do
        parse "#{ foo}" `shouldBe` ParseSuccess (GjVar "foo" GjZero)
        parse "#{bar }" `shouldBe` ParseSuccess (GjVar "bar" GjZero)
        parse "#{ baz }" `shouldBe` ParseSuccess (GjVar "baz" GjZero)
    , it "parses static text + splice with var" $ do
        parse "foo #{bar}"
            `shouldBe` ParseSuccess (GjConst "foo " (GjVar "bar" GjZero))
        parse "qux#{hup}+zaz"
            `shouldBe` (ParseSuccess
                         (GjConst "qux" (GjVar "hup" (GjConst "+zaz" GjZero)))
                       )
    ]

parseErrors :: TestTree
parseErrors = testGroup
    "parse errors"
    [ it "reports unclosed splice" $ parse "#{" `shouldBe` ParseErr
        (UnclosedSplice 2 :| [])
    , it "parses unexpected right paren " $ parse "#{)}" `shouldBe` ParseErr
        (UnexpectedRParen 2 :| [])
    ]

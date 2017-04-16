module Gjallarbru where

parse :: String -> ParseResult String
parse = ParseSuccess

data ParseResult a = ParseErr [ParseError] | ParseSuccess a deriving (Eq, Show)

data ParseError = UnclosedSplice Int Int deriving (Eq, Show)

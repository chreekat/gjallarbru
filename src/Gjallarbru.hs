module Gjallarbru where

import Data.List.NonEmpty

parse :: String -> ParseResult ()
parse "#{" = ParseErr (UnclosedSplice 1 3 :| [])
parse "#{}" = ParseSuccess ()
parse _ = ParseSuccess ()


data ParseResult a = ParseErr (NonEmpty ParseError) | ParseSuccess a deriving (Eq, Show)

data ParseError = UnclosedSplice Int Int deriving (Eq, Show)

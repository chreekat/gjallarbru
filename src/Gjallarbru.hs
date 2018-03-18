module Gjallarbru where

import Data.List.NonEmpty

{-

The syntax for templates is:

 splice   := Templ1 value Templ2
 value    := Var | accessor
 accessor := Accessor Var | Accessor Grp1 value Grp2

 Templ1 := '#{'
 Templ2 := '}'
 Grp1   :=  '('
 Grp2   := ')'

 Esc := '#\{'

-}

parse :: String -> ParseResult ()
parse "#{"  = ParseErr (UnclosedSplice 1 3 :| [])
parse "#{}" = ParseSuccess ()
parse ")"   = ParseSuccess ()
parse "#{)}" = ParseErr (UnexpectedRParen 1 3 :| [])
parse _     = ParseSuccess ()

data ParseResult a = ParseErr (NonEmpty ParseError) | ParseSuccess a deriving (Eq, Show)
data ParseError = UnclosedSplice Int Int deriving (Eq, Show)

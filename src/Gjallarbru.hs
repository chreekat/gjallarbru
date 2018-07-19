{-# LANGUAGE OverloadedStrings #-}
module Gjallarbru where

import Data.List.NonEmpty
import Data.Text (Text)
import qualified Data.Text as T

-- TODO: Write generators for templates, write property tests, add megaparsec,
-- start parsing, look up recursion schemes to use, structure Gj accordingly,
-- parse into the right shape for those schemes, start interpreting the data
-- into haskell code as well as purescript

-- TODO: NonEmptyText, so (GjConst "") isn't equivalent to GjZero
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

data Gj
    = GjZero
    | GjConst Text Gj
    | GjVar Text Gj
    deriving (Eq, Show)

parse :: Text -> ParseResult Gj
parse "#{"   = ParseErr (UnclosedSplice 2 :| [])
parse "#{}"  = ParseSuccess GjZero
parse "#{)}" = ParseErr (UnexpectedRParen 2 :| [])
parse s      = ParseSuccess (GjConst s GjZero)

data ParseResult a
    = ParseErr (NonEmpty ParseError)
    | ParseSuccess a
    deriving (Eq, Show)

data ParseError
    = UnclosedSplice Int
    | UnexpectedRParen Int
    deriving (Eq, Show)

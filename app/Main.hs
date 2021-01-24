{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Person
import Data.YAML

import qualified Data.ByteString.Lazy.Char8 as C


main :: IO ()
main = do
  let bs = encode [Person {name = "Vijay", age = 19, magic = False}]
  C.writeFile "out/person.yaml" bs
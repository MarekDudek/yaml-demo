{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Person
import Data.YAML

import qualified Data.ByteString.Lazy.Char8 as C


main :: IO ()
main = do
  let Right ps = decode "- name: Erik Weisz\n  age: 52\n  magic: True\n- name: Mina Crandon\n  age: 53" :: Either (Pos,String) [[Person]]
  print (ps :: [[Person]])
  let Right is = decode1 "- 1\n- 2\n- 3\n" :: Either (Pos,String) [Int]
  print (is :: [Int])
  let bs = encode [Person {name = "Vijay", age = 19, magic = False}]
  C.writeFile "out/person.yaml" bs
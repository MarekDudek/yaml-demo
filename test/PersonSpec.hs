{-# LANGUAGE OverloadedStrings #-}
module PersonSpec where

import Person
import Data.YAML

import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec =
    describe "Person" $
        it "can be decoded from string" $
          let Right ps = decode "- name: Erik Weisz\n  age: 52\n  magic: True\n- name: Mina Crandon\n  age: 53" :: Either (Pos,String) [[Person]]
          in
            ps `shouldBe` [[Person {name = "Erik Weisz", age = 52, magic = True}, Person {name = "Mina Crandon", age = 53, magic = False}]]
{-# LANGUAGE OverloadedStrings #-}
module PersonSpec where

import Person
import Data.YAML

import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "Person" $ do
        let erik =
              Person {
                name = "Erik Weisz" ,
                age = 52,
                magic = True
              }
            mina =
              Person {
                name = "Mina Crandon",
                age = 53,
                magic = False
              }
        it "can decode multiple persons from string" $ do
          let Right [ps] = decode "- name: Erik Weisz\n  age: 52\n  magic: True\n- name: Mina Crandon\n  age: 53" :: Either (Pos,String) [[Person]]
          ps `shouldBe` [erik, mina]
        it "can decode single person from string" $ do
          let Right [p] = decode1 "- name: Erik Weisz\n  age: 52\n  magic: True" :: Either (Pos,String) [Person]
          p `shouldBe` erik

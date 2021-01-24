{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ScopedTypeVariables #-}
module PersonSpec where

import Person
import Data.YAML

import qualified Data.ByteString.Lazy.Char8 as C

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
        it "can encode single person to string" $ do
          let bs = encode [erik]
          bs `shouldBe` "age: 52\nmagic: true\nname: Erik Weisz\n"
        it "can be written to file" $ do
          let bs = encode [erik]
          C.writeFile "out/test/yaml-demo/erik.yaml" bs
        it "can be read from file" $ do
          bs <- C.readFile "test-data/erik.yaml"
          bs `shouldBe` "- name: Erik Weisz\n  age: 52\n  magic: true\n"
        it "should preserver order of fields" $ do
          original <- C.readFile "test-data/erik.yaml"
          let Right ps = decode original :: Either (Pos,String) [[Person]]
          let copy = encode ps
          C.writeFile "out/test/yaml-demo/erik-copy.yaml" copy
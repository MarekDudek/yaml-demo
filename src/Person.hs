{-# LANGUAGE OverloadedStrings #-}
module Person where

import Data.YAML
import Data.Text

data Person = Person
    { name  :: Text
    , age   :: Int
    , magic :: Bool
    } deriving (Show, Eq)


instance FromYAML Person where
   parseYAML = withMap "Person" $ \m -> Person
       <$> m .: "name"
       <*> m .: "age"
       <*> m .:? "magic" .!= False

instance ToYAML Person where
    toYAML (Person n a m) = mapping [ "name" .= n, "age" .= a, "magic" .= m]

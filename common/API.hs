{-# LANGUAGE DataKinds, TypeOperators #-}
module API where 

import Servant.API

type API = "a":>"b":> "c" :> "d" :> Get '[JSON] String


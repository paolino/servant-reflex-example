{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE RankNTypes #-}


import Data.Bool
import Data.Maybe
import Servant.API
import Servant.Reflex
import API
import Data.Proxy
import Text.Read (readMaybe)
import Reflex.Dom

api :: Proxy API
api = Proxy

main :: IO ()
main = mainWidget run


run :: forall t m. MonadWidget t m => m ()
run = do
  url <- baseUrlWidget
  el "br" (return ())
  dynText =<< mapDyn showBaseUrl url
  el "br" (return ())
  -- Name the computed API client functions
  let getUnit = client api (Proxy :: Proxy m) url

  elClass "div" "demo-group" $ do
    unitBtn  <- button "Get unit"
    unitResponse <- getUnit unitBtn

    let parseR (ResponseSuccess a b) = (a ++ showXhrResponse b)
        parseR (ResponseFailure a b) = (a ++ showXhrResponse b)
        parseR (RequestFailure s) = s
    r <- holdDyn "Waiting" $ fmap parseR unitResponse
    dynText r 

showXhrResponse :: XhrResponse -> String
showXhrResponse (XhrResponse stat stattxt rbmay rtmay) =
  unlines ["stat: " ++ show stat
          ,"stattxt: " ++ show stattxt
          ,"resp: " ++ maybe "" showRB rbmay
          ,"rtext: " ++ show rtmay]

showRB :: XhrResponseBody -> String
showRB (XhrResponseBody_Default t) = show t
showRB (XhrResponseBody_Text t) = show t
showRB (XhrResponseBody_Blob t) = "<Blob>"
showRB (XhrResponseBody_ArrayBuffer t) = show t

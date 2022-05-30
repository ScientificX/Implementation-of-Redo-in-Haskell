module Redo where

import qualified System.Process as SP
import qualified System.Environment as SE



main :: IO ()
main = do
    args <- SE.getArgs
    mapM_ redo args

redo :: String -> IO ()
redo file = do
    (_, _, _, id) <- SP.createProcess $  SP.shell $ "sh " ++ file ++ ".do"
    _ <- SP.waitForProcess id
    return ()
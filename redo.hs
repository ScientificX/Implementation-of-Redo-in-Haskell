module Main where

import qualified System.Process as SP
import qualified System.Environment as SE
import System.Exit (ExitCode(..))
import qualified System.Exit 
import System.IO 
import System.Directory



main :: IO ()
main = do
    args <- SE.getArgs
    mapM_ redo args

redo :: String -> IO ()
redo file = do
  let tmp = file ++ "--redoing"
  (_, _, _, id) <- SP.createProcess $  SP.shell $ "sh " ++ file ++ ".do" ++ " - - "++ tmp ++ ">" ++ tmp
  exit <- SP.waitForProcess id
  case exit of
    ExitSuccess -> do renameFile tmp file
    ExitFailure c -> do hPutStrLn stderr $ "Process rreturned a non zero exit code" ++ show c
  removeFile tmp

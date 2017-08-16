module Main where

import Control.Monad.Trans.State
import System.IO

import Direction
import Position
import Robot
import Table

readLine :: Handle -> IO ()
readLine h = do
  line <- hGetLine h
  putStrLn line

main :: IO ()
main = do
  let t = Table (Position 0 0) (Position 5 5)

  let filename = "robot-test.in"
  content <- readFile filename

  let initialRobot = (Robot (Position 1 1) North) :: Robot
  let states = map (\s -> doCommand s t) (lines content) :: [GameState]
  let finalState = foldr (>>) (pure ()) states :: GameState
  _ <- execStateT finalState initialRobot :: IO Robot
  pure ()

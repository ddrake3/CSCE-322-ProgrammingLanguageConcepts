import Data.List
import Helpers
import System.Environment (getArgs)
import Prelude

-- The main method that will be used for testing / comgand line access
main = do
  args <- getArgs
  filename <- readFile (head args)
  (game, moves) <- readExtremePegSolitaireFile filename
  print "Result"
  let result = onePlayerManyMoves game moves
  printGame result

-- arguments: game2D, map of moves (move:moves), game2D
-- YOUR CODE SHOULD COME AFTER THIS POINT
onePlayerManyMoves :: [[Char]] -> [Char] -> [[Char]]
onePlayerManyMoves game [] = game
onePlayerManyMoves game (move : moves) = onePlayerManyMoves gameToReturn moves
  where
    gameToReturn = manyMoveHelper game '1' move
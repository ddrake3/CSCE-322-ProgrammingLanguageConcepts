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
  let result = onePlayerOneMove game (head moves)
  printGame result

-- YOUR CODE SHOULD COME AFTER THIS POINT
onePlayerOneMove :: [[Char]] -> Char -> [[Char]]
onePlayerOneMove game move = (manyMoveHelper game '1' move)
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
  let result = manyPlayersOneMove game moves
  printGame result

-- YOUR CODE SHOULD COME AFTER THIS POINT
manyPlayersOneMove :: [[Char]] -> [Char] -> [[Char]]
manyPlayersOneMove game moves = manyPlayerHelper game sortedPlayers moves
  where
    sortedPlayers = sortString players
    players = getPlayers (convertTo1D game)
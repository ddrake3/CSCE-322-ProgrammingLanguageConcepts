module Helpers
  ( readExtremePegSolitaireFile,
    printGame,
    countPlayers,
    playerLocation,
    convertTo1D,
    manyMoveHelper,
    manyPlayerHelper,
    manyPlayerManyMovesHelper,
    getPlayers,
    sortString,
    isValidUp,
    moveUp,
    makeMove1Up,
    makeMove2Up,
    makeMove3Up,
    isValidLeft,
    moveLeft,
    makeMove1Left,
    makeMove2Left,
    makeMove3Left,
    isValidRight,
    moveRight,
    makeMove1Right,
    makeMove2Right,
    makeMove3Right,
    isValidDown,
    moveDown,
    makeMove1Down,
    makeMove2Down,
    makeMove3Down,
  )
where

import Data.Char
import Data.Function
import Data.List
import Data.Maybe
import Debug.Trace
import Prelude

readExtremePegSolitaireFile :: String -> IO ([[Char]], [Char])
readExtremePegSolitaireFile = readIO

printGame :: [[Char]] -> IO ()
printGame [] = do
  print ""
printGame (row : rows) = do
  print row
  printGame rows

countPlayers :: [[Char]] -> Int
countPlayers game = (length game) * (length (head game)) - numSpaces - numPegs
  where
    numSpaces = length (find2D game '-')
    numPegs = length (find2D game 'x')

find2D :: [[Char]] -> Char -> [(Int, Int)]
find2D [] _ = []
find2D (row : rows) e = first ++ rest
  where
    first = [(0, c) | c <- (find1D row e)]
    rest = [(r + 1, c) | (r, c) <- (find2D rows e)]

find1D :: [Char] -> Char -> [Int]
find1D [] _ = []
find1D (h : t) e
  | h == e = 0 : rst
  | otherwise = rst
  where
    rest = find1D t e
    rst = map (+ 1) rest

-- gets the given players index [i, j]
-- arguments: game, player, [i, j]
playerLocation :: [[Char]] -> [Char] -> Char -> (Int, Int)
playerLocation game game1D player = (div a (length (head game)), mod a (length (head game)))
  where
    a = (fromJust $ elemIndex player game1D)

-- converts the 2D list to a 1D list
-- arguments: game2D, game1D
convertTo1D :: [[Char]] -> [Char]
convertTo1D game = concat (game)

-- helps iterate through the move list
-- arguments: game2D, player, move, game2D
manyMoveHelper :: [[Char]] -> Char -> Char -> [[Char]]
manyMoveHelper game player move
  | (move == 'u') = moveUp game player
  | (move == 'l') = moveLeft game player
  | (move == 'r') = moveRight game player
  | (move == 'd') = moveDown game player
  | otherwise = game

-- helps iterate through the player list
-- arguments: game2D, players, moves, game2D
manyPlayerHelper :: [[Char]] -> [Char] -> [Char] -> [[Char]]
manyPlayerHelper game [] _ = game
manyPlayerHelper game players [] = game
manyPlayerHelper game (player : players) (move : moves) = manyPlayerHelper gameToReturn players moves
  where
    gameToReturn = manyMoveHelper game player move

-- helps with many players, many moves
-- arguments: game2D, moves, players, game2D
manyPlayerManyMovesHelper :: [[Char]] -> [Char] -> [Char] -> [[Char]]
manyPlayerManyMovesHelper game [] _ = game
manyPlayerManyMovesHelper game moves [] = manyPlayerManyMovesHelper game moves sortedPlayers
  where
    sortedPlayers = sortString players
    players = getPlayers (convertTo1D game)
manyPlayerManyMovesHelper game (move : moves) (player : players) = manyPlayerManyMovesHelper gameToReturn moves players
  where
    gameToReturn = manyMoveHelper game player move

-- gets all the players in the game
-- arguments: game1D, players
getPlayers :: String -> [Char]
getPlayers = filter isDigit

-- sorts a given string
sortString :: [Char] -> [Char]
sortString players = sort players

----------------------------------------------------------------------------------
-- Move = 'u' section
-- checks to make sure the move is valid
-- (not trying to move into a '-' or another player)
isValidUp :: [[Char]] -> (Int, Int) -> Bool
isValidUp game (x, y) =
  ((game !! (x - 1) !! (y) == 'x') && (game !! (x - 2) !! (y) == 'x'))

-- moves the player up
-- arguments: game2D, player, game2D
moveUp :: [[Char]] -> Char -> [[Char]]
moveUp game player
  | (((&&) (fst (x, y) > 1) (isValidUp game (x, y))) == True) = (makeMove1Up game (x, y) player)
  | otherwise = game
  where
    (x, y) = playerLocation game (convertTo1D game) player

-- replaces the old player space with a 'x'
-- arguments: game2D, index, player, game2D
makeMove1Up :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove1Up game (x, y) player =
  take x gameToReturn ++ [take y (gameToReturn !! x) ++ text ++ drop (y + 1) (gameToReturn !! x)]
    ++ drop (x + 1) gameToReturn
  where
    gameToReturn = makeMove2Up game (x, y) player
    text = ['x']

-- replaces the specified character with a '-'
-- arguments: game2D, index, player, game2D
makeMove2Up :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove2Up game (x, y) player =
  take (x - 1) gameToReturn ++ [take y (gameToReturn !! (x - 1)) ++ text ++ drop (y + 1) (gameToReturn !! (x - 1))]
    ++ drop (x) gameToReturn
  where
    gameToReturn = makeMove3Up game (x, y) player
    text = ['-']

-- replaces the specified character with the player number
-- arguments: game2D, index, player, game2D
makeMove3Up :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove3Up game (x, y) player =
  take (x - 2) game ++ [take y (game !! (x - 2)) ++ [player] ++ drop (y + 1) (game !! (x - 2))]
    ++ drop (x - 1) game

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Move = 'l' section
-- checks to make sure the move is valid
-- (not trying to move into a '-')
isValidLeft :: [[Char]] -> (Int, Int) -> Bool
isValidLeft game (x, y) =
  (((game !! x !! (y - 1)) == 'x') && ((game !! x !! (y - 2)) == 'x'))

-- moves the player left
-- arguments: game2D, player, game2D
moveLeft :: [[Char]] -> Char -> [[Char]]
moveLeft game player
  | (((&&) (snd (x, y) > 1) (isValidLeft game (x, y))) == True) = (makeMove1Left game (x, y) player)
  | otherwise = game
  where
    (x, y) = playerLocation game (convertTo1D game) player

-- replaces the old player space with a 'x'
-- arguments: game2D, index, player, game2D
makeMove1Left :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove1Left game (x, y) player =
  take x gameToReturn ++ [take y (gameToReturn !! x) ++ text ++ drop (y + 1) (gameToReturn !! x)]
    ++ drop (x + 1) gameToReturn
  where
    gameToReturn = makeMove2Left game (x, y) player
    text = ['x']

-- replaces the specified character with a '-'
-- arguments: game2D, index, player, game2D
makeMove2Left :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove2Left game (x, y) player =
  take (x) gameToReturn ++ [take (y - 1) (gameToReturn !! (x)) ++ text ++ drop (y) (gameToReturn !! (x))]
    ++ drop (x + 1) gameToReturn
  where
    gameToReturn = makeMove3Left game (x, y) player
    text = ['-']

-- replaces the specified character with the player number
-- arguments: game2D, index, player, game2D
makeMove3Left :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove3Left game (x, y) player =
  take (x) game ++ [take (y - 2) (game !! (x)) ++ [player] ++ drop (y - 1) (game !! (x))]
    ++ drop (x + 1) game

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Move = 'r' section
-- checks to make sure the move is valid
-- (not trying to move into a '-')
isValidRight :: [[Char]] -> (Int, Int) -> Bool
isValidRight game (x, y) =
  (((game !! x !! (y + 1)) == 'x') && ((game !! x !! (y + 2)) == 'x'))

-- moves the player right
-- arguments: game2D, player, game2D
moveRight :: [[Char]] -> Char -> [[Char]]
moveRight game player
  | (((&&) (snd (x, y) < ((length (head game)) - 2)) (isValidRight game (x, y))) == True) = (makeMove1Right game (x, y) player)
  | otherwise = game
  where
    (x, y) = playerLocation game (convertTo1D game) player

-- replaces the old player space with a 'x'
-- arguments: game2D, index, player, game2D
makeMove1Right :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove1Right game (x, y) player =
  take x gameToReturn ++ [take y (gameToReturn !! x) ++ text ++ drop (y + 1) (gameToReturn !! x)]
    ++ drop (x + 1) gameToReturn
  where
    gameToReturn = makeMove2Right game (x, y) player
    text = ['x']

-- replaces the specified character with a '-'
-- arguments: game2D, index, player, game2D
makeMove2Right :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove2Right game (x, y) player =
  take x gameToReturn ++ [take (y + 1) (gameToReturn !! x) ++ text ++ drop (y + 2) (gameToReturn !! x)]
    ++ drop (x + 1) gameToReturn
  where
    gameToReturn = makeMove3Right game (x, y) player
    text = ['-']

-- replaces the specified character with the player number
-- arguments: game2D, index, player, game2D
makeMove3Right :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove3Right game (x, y) player =
  take x game ++ [take (y + 2) (game !! x) ++ [player] ++ drop (y + 3) (game !! x)]
    ++ drop (x + 1) game

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
-- Move = 'd' section
-- checks to make sure the move is valid
-- (not trying to move into a '-')
isValidDown :: [[Char]] -> (Int, Int) -> Bool
isValidDown game (x, y) =
  ((game !! (x + 1) !! (y) == 'x') && (game !! (x + 2) !! (y) == 'x'))

-- moves the player down
-- arguments: game2D, player, game2D
moveDown :: [[Char]] -> Char -> [[Char]]
moveDown game player
  | (((&&) (fst (x, y) < ((length game) - 2)) (isValidDown game (x, y))) == True) = (makeMove1Down game (x, y) player)
  | otherwise = game
  where
    (x, y) = playerLocation game (convertTo1D game) player

-- replaces the old player space with a 'x'
-- arguments: game2D, index, player, game2D
makeMove1Down :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove1Down game (x, y) player =
  take x gameToReturn ++ [take y (gameToReturn !! x) ++ text ++ drop (y + 1) (gameToReturn !! x)]
    ++ drop (x + 1) gameToReturn
  where
    gameToReturn = makeMove2Down game (x, y) player
    text = ['x']

-- replaces the specified character with a '-'
-- arguments: game2D, index, player, game2D
makeMove2Down :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove2Down game (x, y) player =
  take (x + 1) gameToReturn ++ [take y (gameToReturn !! (x + 1)) ++ text ++ drop (y + 1) (gameToReturn !! (x + 1))]
    ++ drop (x + 2) gameToReturn
  where
    gameToReturn = makeMove3Down game (x, y) player
    text = ['-']

-- replaces the specified character with the player number
-- arguments: game2D, index, player, game2D
makeMove3Down :: [[Char]] -> (Int, Int) -> Char -> [[Char]]
makeMove3Down game (x, y) player =
  -- possibly change to setIth from notes~~
  take (x + 2) game ++ [take y (game !! (x + 2)) ++ [player] ++ drop (y + 1) (game !! (x + 2))]
    ++ drop (x + 3) game
----------------------------------------------------------------------------------
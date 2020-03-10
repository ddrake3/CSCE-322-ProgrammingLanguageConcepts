module.exports = {
	manyPlayersManyMoves : manyPlayersManyMoves
}

var helpers = require('./helpers');

function manyPlayersManyMoves(game) {

	function whatever(moves) {
		var playerCount = 0;
		var playerPositionI = 0;
		var playerPositionJ = 0;
		var x = 0;
		// get number of players
		for (var i = 0; i < game.length; i++) {
			for (var j = 0; j < game[0].length; j++) {
				if (game[i][j] != '-' && game[i][j] != 'x') {
					playerCount++;
				}
			}
		}
		while (x < moves.length) {
			// iterate through the number of players
			for (var y = 1; y < playerCount + 1; y++) {
				// get the players current position

				for (var i = 0; i < game.length; i++) {
					for (var j = 0; j < game[0].length; j++) {
						if (parseInt(game[i][j], 10) == y) {
							playerPositionI = i;
							playerPositionJ = j;
						}
					}
				}
				switch (moves[x]) {
				case 'l':
					if (playerPositionJ > 1) {
						if (game[playerPositionI][playerPositionJ - 1] != '-'
								&& game[playerPositionI][playerPositionJ - 2] != '-'
								&& isNaN(parseInt(game[playerPositionI][playerPositionJ - 1]))
								&& isNaN(parseInt(game[playerPositionI][playerPositionJ - 2]))) {
							game[playerPositionI][playerPositionJ] = 'x';
							game[playerPositionI][playerPositionJ - 1] = '-';
							game[playerPositionI][playerPositionJ - 2] = y
									.toString(10);

						}
					}
					break;
				case 'u':
					if (playerPositionI > 1) {
						if (game[playerPositionI - 1][playerPositionJ] != '-'
								&& game[playerPositionI - 2][playerPositionJ] != '-'
								&& isNaN(parseInt(game[playerPositionI - 1][playerPositionJ]))
								&& isNaN(parseInt(game[playerPositionI - 2][playerPositionJ]))) {
							game[playerPositionI][playerPositionJ] = 'x';
							game[playerPositionI - 1][playerPositionJ] = '-';
							game[playerPositionI - 2][playerPositionJ] = y
									.toString(10);
						}
					}
					break;
				case 'r':
					if (playerPositionJ < game[0].length - 2) {
						if (game[playerPositionI][playerPositionJ + 1] != '-'
								&& game[playerPositionI][playerPositionJ + 2] != '-'
								&& isNaN(parseInt(game[playerPositionI][playerPositionJ + 1]))
								&& isNaN(parseInt(game[playerPositionI][playerPositionJ + 2]))) {
							game[playerPositionI][playerPositionJ] = 'x';
							game[playerPositionI][playerPositionJ + 1] = '-';
							game[playerPositionI][playerPositionJ + 2] = y
									.toString(10);

						}
					}
					break;
				case 'd':
					if (playerPositionI < game.length - 2) {
						if (game[playerPositionI + 1][playerPositionJ] != '-'
								&& game[playerPositionI + 2][playerPositionJ] != '-'
								&& isNaN(parseInt(game[playerPositionI + 1][playerPositionJ]))
								&& isNaN(parseInt(game[playerPositionI + 2][playerPositionJ]))) {
							game[playerPositionI][playerPositionJ] = 'x';
							game[playerPositionI + 1][playerPositionJ] = '-';
							game[playerPositionI + 2][playerPositionJ] = y
									.toString(10);
						}
					}
					break;

				}
				x++;
			}
		}
		return game;
	}

	return whatever;
}

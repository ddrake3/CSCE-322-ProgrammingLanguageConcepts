module.exports = {
	onePlayerManyMoves : onePlayerManyMoves
}

var helpers = require('./helpers');

function onePlayerManyMoves(game) {

	function whatever(moves) {

		var playerPositionI = 0;
		var playerPositionJ = 0;

		// iterate through the moves array
		for (var x = 0; x < moves.length; x++) {
			// get the players current position
			for (var i = 0; i < game.length; i++) {
				for (var j = 0; j < game[0].length; j++) {
					if (game[i][j] != '-' && game[i][j] != 'x') {
						playerPositionI = i;
						playerPositionJ = j;
					}
				}
			}
			switch (moves[x]) {
			case 'l':
				if (playerPositionJ > 1) {
					if (game[playerPositionI][playerPositionJ - 1] != '-'
							&& game[playerPositionI][playerPositionJ - 2] != '-') {
						game[playerPositionI][playerPositionJ] = 'x';
						game[playerPositionI][playerPositionJ - 1] = '-';
						game[playerPositionI][playerPositionJ - 2] = '1';

					}
				}
				break;
			case 'u':
				if (playerPositionI > 1) {
					if (game[playerPositionI - 1][playerPositionJ] != '-'
							&& game[playerPositionI - 2][playerPositionJ] != '-') {
						game[playerPositionI][playerPositionJ] = 'x';
						game[playerPositionI - 1][playerPositionJ] = '-';
						game[playerPositionI - 2][playerPositionJ] = '1';
					}
				}
				break;
			case 'r':
				if (playerPositionJ < game[0].length - 2) {
					if (game[playerPositionI][playerPositionJ + 1] != '-'
							&& game[playerPositionI][playerPositionJ + 2] != '-') {
						game[playerPositionI][playerPositionJ] = 'x';
						game[playerPositionI][playerPositionJ + 1] = '-';
						game[playerPositionI][playerPositionJ + 2] = '1';

					}
				}
				break;
			case 'd':
				if (playerPositionI < game.length - 2) {
					if (game[playerPositionI + 1][playerPositionJ] != '-'
							&& game[playerPositionI + 2][playerPositionJ] != '-') {
						game[playerPositionI][playerPositionJ] = 'x';
						game[playerPositionI + 1][playerPositionJ] = '-';
						game[playerPositionI + 2][playerPositionJ] = '1';
					}
				}
				break;

			}
		}
		return game;
	}

	return whatever;
}

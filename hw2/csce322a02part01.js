module.exports = {
	onePlayerOneMove : onePlayerOneMove
}

var helpers = require('./helpers');

function onePlayerOneMove(game) {

	function whatever(move) {

		var playerPositionI = 0;
		var playerPositionJ = 0;

		// get the players current position
		for (var i = 0; i < game.length; i++) {
			for (var j = 0; j < game[0].length; j++) {
				if (game[i][j] != '-' && game[i][j] != 'x') {
					playerPositionI = i;
					playerPositionJ = j;
				}
			}
		}

		// for every player an invalid move is:
		// trying to move out of bounds
		// trying to move into a '-'(empty space)
		console.error(playerPositionI);
		console.error(playerPositionJ);
		console.error(game[0].length);

		switch (move) {
		case 'l':
			if (playerPositionJ > 1) {
				if (game[playerPositionI][playerPositionJ - 1] != '-'
						&& game[playerPositionI][playerPositionJ - 2] != '-') {
					game[playerPositionI][playerPositionJ] = 'x';
					game[playerPositionI][playerPositionJ - 1] = '-';
					game[playerPositionI][playerPositionJ - 2] = '1';

				}
			}
			return game;
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
			return game;
			break;
		case 'r':
			if (playerPositionJ < game.length - 1) {
				if (game[playerPositionI][playerPositionJ + 1] != '-'
						&& game[playerPositionI][playerPositionJ + 2] != '-') {
					game[playerPositionI][playerPositionJ] = 'x';
					game[playerPositionI][playerPositionJ + 1] = '-';
					game[playerPositionI][playerPositionJ + 2] = '1';

				}
			}
			return game;
			break;
		case 'd':
			if (playerPositionI < game[0].length - 1) {
				if (game[playerPositionI + 1][playerPositionJ] != '-'
						&& game[playerPositionI + 2][playerPositionJ] != '-') {
					game[playerPositionI][playerPositionJ] = 'x';
					game[playerPositionI + 1][playerPositionJ] = '-';
					game[playerPositionI + 2][playerPositionJ] = '1';
				}
			}
			return game;
			break;
		}

		return game;
	}

	return whatever;
}

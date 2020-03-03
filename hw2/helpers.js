module.exports = {
	readMovesFile : readMovesFile,
	readGameFile : readGameFile,
	printMoves : printMoves,
	printGame : printGame
}

function readMovesFile(file) {
	var text;
	var moves = [];
	var rows = [];
	var mvs = [];
	var filesystem = require('fs');

	text = filesystem.readFileSync(file);
	rows = text.toString().split("\n");
	rows.pop();

	moves = rows[0].split(',');

	for (var m = 0; m < moves.length; m++) {
		mvs[m] = moves[m];
	}

	return mvs;
}

function readGameFile(file) {
	var text;
	var game = [];
	var rows = [];
	var filesystem = require('fs');

	text = filesystem.readFileSync(file);
	rows = text.toString().split("\n");
	rows.pop();

	for (var r = 0; r < rows.length; r++) {
		game[r] = rows[r].split(',');
	}

	return game;
}

function printMoves(moves) {
	console.log(moves);
}

function printGame(game) {
	for (var r = 0; r < game.length; r++) {
		console.log(game[r]);
	}
}

function findPlayers(game) {
	var players = 0;
	for (var r = 0; r < game.length; r++) {
		for (var c = 0; c < game[0].length; c++) {
			if (game[r][c] != '-' && game[r][c] != 'x'
					&& parseInt(game[r][c]) > players) {
				players = parseInt(game[r][c]);
			}
		}
	}
	return players;
}

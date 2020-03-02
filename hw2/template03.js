var helpers = require( './helpers' );
var part = require( './csce322a02part03' );

var moves = helpers.readMovesFile('test02.moves.eps');
var game = helpers.readGameFile('test02.game.eps');
var beforeMo = moves.slice(0);
var beforeGa = game.slice(0);

var theFunction = part.manyPlayersOneMove( game );
var after = theFunction( moves );
console.log( 'game' );
helpers.printGame( after );

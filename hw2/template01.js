var helpers = require( './helpers' );
var part = require( './csce322a02part01' );

var game = helpers.readGameFile('test02.game.single.eps');
var moves = helpers.readMovesFile('test02.moves.eps');
var beforeGa = game.slice(0);
var beforeMo = moves.slice(0);

var theFunction = part.onePlayerOneMove( game );
var after = theFunction( moves[0] );
console.log( 'game' );
helpers.printGame( after );

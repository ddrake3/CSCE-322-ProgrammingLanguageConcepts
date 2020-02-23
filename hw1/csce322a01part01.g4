grammar csce322a01part01;

// rules
extremePegSolitaire 					: (moves game endOfFile | error) | (game moves endOfFile | error);

game 									: (gameSectionTitle sectionBeginning gameBeginning ((gameSymbolHyphen|gameSymbolX|gameSymbolNumb)+ (rowEnding|gameEnding)+)+  sectionEnding) | error;
moves 									: (movesSectionTitle sectionBeginning movesBeginning (moveSymbol|moveSymbolComma)+ movesEnding sectionEnding) | error;

sectionBeginning						: SECTIONBEGINNING{System.out.println("Begin the Section");} | error;
sectionEnding							: SECTIONENDING{System.out.println("End the Section");} | error;
gameSectionTitle						: GAMESECTIONTITLE{System.out.println("game Section");} | error;
movesSectionTitle						: MOVESSECTIONTITLE{System.out.println("moves Section");} | error;
											
moveSymbol								: MOVESYMBOL{System.out.println("Move: " + $MOVESYMBOL.text);} | error;
moveSymbolComma							: MOVESYMBOLCOMMA{} | error;
gameSymbolHyphen						: GAMESYMBOLHYPHEN{System.out.println("Space: Empty");} | error;
gameSymbolX								: GAMESYMBOLX{System.out.println("Space: " + $GAMESYMBOLX.text);} | error;
gameSymbolNumb							: GAMESYMBOLNUMB{System.out.println("Space: " + $GAMESYMBOLNUMB.text);} | error;

rowEnding								: ROWENDING{System.out.println("End the Row");} | error;

gameBeginning							: GAMEBEGINNING{System.out.println("Start the Game");} | error;
gameEnding								: GAMEENDING{System.out.println("End the Game");} | error;

movesBeginning							: MOVESBEGINNING{System.out.println("Begin the List");} | error;
movesEnding								: MOVESENDING{System.out.println("End the List");} | error;

endOfFile								: EOF{System.out.println("End the File");} | error;
 
error									: ANYTHING{System.out.println("SYNTAX ERROR IN LINE " + $ANYTHING.line);System.exit(1);};

// tokens
SECTIONBEGINNING 						: '>>';
SECTIONENDING							: '<<';
GAMESECTIONTITLE 						: '!game';
MOVESSECTIONTITLE						: '!moves';

MOVESYMBOL 								: 'u'|'d'|'l'|'r';
MOVESYMBOLCOMMA							: ',';
GAMESYMBOLHYPHEN						: '-';
GAMESYMBOLX								: 'x';
GAMESYMBOLNUMB							: [0-9];

ROWENDING 								: '*';

GAMEBEGINNING 							: '{';
GAMEENDING 								: '}';

MOVESBEGINNING 							: '^';
MOVESENDING 							: '$';

WS 										: [ \t\r\n]+ -> skip;

ANYTHING 								: .;
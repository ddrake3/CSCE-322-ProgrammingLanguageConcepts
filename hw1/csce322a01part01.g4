grammar csce322a01part01;

// rules
extremePegSolitaire 					: moves game endOfFile | game moves endOfFile ;

game 									: gameSectionTitle sectionBeginning gameBeginning ((gameSymbolHyphen|gameSymbolX|gameSymbolNumb)+ (rowEnding|gameEnding)+)+  sectionEnding;
moves 									: movesSectionTitle sectionBeginning movesBeginning (moveSymbol|moveSymbolComma)+ movesEnding sectionEnding;

sectionBeginning						: SECTIONBEGINNING{System.out.println("Begin the Section");};
sectionEnding							: SECTIONENDING{System.out.println("End the Section");};
gameSectionTitle						: GAMESECTIONTITLE{System.out.println("game Section");};
movesSectionTitle						: MOVESSECTIONTITLE{System.out.println("moves Section");};
											
moveSymbol								: MOVESYMBOL{System.out.println("Move: " + $MOVESYMBOL.text);};
moveSymbolComma							: MOVESYMBOLCOMMA{};
gameSymbolHyphen						: GAMESYMBOLHYPHEN{System.out.println("Space: Empty");};
gameSymbolX								: GAMESYMBOLX{System.out.println("Space: " + $GAMESYMBOLX.text);};
gameSymbolNumb							: GAMESYMBOLNUMB{System.out.println("Space: " + $GAMESYMBOLNUMB.text);};

rowEnding								: ROWENDING{System.out.println("End the Row");};

gameBeginning							: GAMEBEGINNING{System.out.println("Start the Game");};
gameEnding								: GAMEENDING{System.out.println("End the Game");};

movesBeginning							: MOVESBEGINNING{System.out.println("Begin the List");};
movesEnding								: MOVESENDING{System.out.println("End the List");};

endOfFile								: EOF{System.out.println("End the File");};
 
error									: ANYTHING{System.out.println("SYNTAX ERROR IN LINE " + $ANYTHING.line);};

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
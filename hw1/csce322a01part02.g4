grammar csce322a01part02;

// rules
extremePegSolitaire 					: moves game semantics endOfFile  | game moves semantics endOfFile  ;



semantics								: {
											if(playerCount > 4 || playerCount < 2){
												System.out.println("SEMANTIC ERROR 1");
												exit(1);
											}
											if((emptySpaces / totalCharacters) > 0.4){
												System.out.println("SEMANTIC ERROR 2");
												exit(1);
											}
											if((up < 1) | (down < 1) | (left < 1) | (right < 1)){
												System.out.println("SEMANTIC ERROR 3");
												exit(1);
											}
											// extra credit: no player may be surrounded my empty spaces

			




										}

// tokens
SECTIONBEGINNING 						: '>>';
SECTIONENDING							: '<<';
GAMESECTIONTITLE 						: '!game';
MOVESSECTIONTITLE						: '!moves';

MOVESYMBOLUP							: 'u';
MOVESYMBOLDOWN							: 'd';
MOVESYMBOLLEFT							: 'l';
MOVESYMBOLRIGHT							: 'r';
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

SEMANTICS 								: .;

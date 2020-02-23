grammar csce322a01part02;

@members {
			int playerCount = 0;
			int emptySpaces = 0;
			int totalCharacters = 0;
			int up = 0;
			int down = 0;
			int left = 0;
			int right = 0;	
			int rows = 0;
			int cols = 0;
			int moves = 0;
			boolean flag = true;
			}
			
// rules
extremePegSolitaire 					: (moves game semantics endOfFile | error) | (game moves semantics endOfFile | error);

game 									: (gameSectionTitle sectionBeginning gameBeginning ((gameSymbolHyphen|gameSymbolX|gameSymbolNumb)+ (rowEnding|gameEnding)+)+  sectionEnding) | error;
moves 									: (movesSectionTitle sectionBeginning movesBeginning ((moveSymbolUp|moveSymbolDown|moveSymbolLeft|moveSymbolRight)|moveSymbolComma)+ movesEnding sectionEnding) | error;
sectionBeginning						: SECTIONBEGINNING | error;
sectionEnding							: SECTIONENDING | error;
gameSectionTitle						: GAMESECTIONTITLE | error;
movesSectionTitle						: MOVESSECTIONTITLE | error;
											
moveSymbolUp							: MOVESYMBOLUP{up++; moves++;} | error;
moveSymbolDown							: MOVESYMBOLDOWN{down++; moves++;} | error;
moveSymbolLeft						    : MOVESYMBOLLEFT{left++; moves++;} | error;
moveSymbolRight							: MOVESYMBOLRIGHT{right++; moves++;} | error;
moveSymbolComma							: MOVESYMBOLCOMMA | error;

gameSymbolHyphen						: GAMESYMBOLHYPHEN{emptySpaces++; totalCharacters++; cols++;} | error;
gameSymbolX								: GAMESYMBOLX{totalCharacters++; cols++;} | error;
gameSymbolNumb							: GAMESYMBOLNUMB{playerCount++; totalCharacters++; cols++;} | error;

rowEnding								: ROWENDING{rows++;
											if(cols < 10){
												System.out.println("SYNTAX ERROR ON LINE " + $ROWENDING.line);
												System.exit(1);
											}
										} | error;

gameBeginning							: GAMEBEGINNING | error;
gameEnding								: GAMEENDING{
											if(rows < 10){
												System.out.println("SYNTAX ERROR ON LINE " + $GAMEENDING.line); 
												System.exit(1);
											}
										} | error;

movesBeginning							: MOVESBEGINNING | error;
movesEnding								: MOVESENDING{
											if(moves < 5){
												System.out.println("SYNTAX ERROR ON LINE " + $MOVESENDING.line); 
												System.exit(1);
											}
										} | error;

endOfFile								: EOF | error;

semantics								: {
											if(playerCount > 4 || playerCount < 2){
												System.out.println("SEMANTIC PROBLEM 1");
												flag = false;
											}
											if(((double) emptySpaces / totalCharacters) > 0.4){
												System.out.println("SEMANTIC PROBLEM 2");
												flag = false;
											}
											if((up < 1) | (down < 1) | (left < 1) | (right < 1)){
												System.out.println("SEMANTIC PROBLEM 3");
												flag = false;
											}
											if(flag){
												System.out.println("There are " + emptySpaces + " empty spaces on the board");
											}
											System.exit(1);
											
										} | error;
										
error									: ANYTHING{System.out.println("SYNTAX ERROR ON LINE " + $ANYTHING.line); System.exit(1);};
											
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

ANYTHING 								: .;

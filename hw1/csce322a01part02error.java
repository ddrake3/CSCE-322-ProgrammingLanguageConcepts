import org.antlr.v4.runtime.*;

class csce322a01part02error extends BaseErrorListener {
	@Override
	public void syntaxError(Recognizer<?, ?> recognizer, Object offendingSymbol, int line, int position, String msg,
			RecognitionException e) {

		System.out.println("SYNTAX ERROR IN LINE " + line);

		System.exit(0);
	}
}

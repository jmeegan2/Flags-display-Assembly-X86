; EXTERNAL DEPENDENCIES
INCLUDE		Irvine32.inc
INCLUDELIB	Irvine32.lib

; EXECUTION MODE PARAMETERS
.386
.model flat, stdcall
.stack 4096

; PROTOTYPES
ExitProcess PROTO, dwExitCode:DWORD

; DATA SEGMENT
.data
; --- VARIABLES VS. SYMBOLIC CONSTANTS ---
; ! VARIABLES !
; A 'variable' is an identifier associated with a specific memory offset containing
; data used by the program.  Consequently, variables DO take up memory during the
; execution of a program.  The data contents associated with a variable CAN
; be altered and preserved during runtime.
imABYTEVariable					BYTE	10d
imAStringVariable				BYTE	"I'm a variable!", 0Dh, 0Ah, 0

; ! SYMBOLIC CONSTANTS !
; A 'symbolic constant' is an identifier that results in a direct text substitution
; by the assembler upon building the executable.  Symbolic constants DO NOT take up
; memory during run-time.  The value of a symbolic constant can be changed at any
; point in the source code and the new value will used until a subsequent change
; takes place.  It is important to not think of symbolic constants as variables since
; they simply result in a series of text-based substitutions by the assembler.  Symbolic
; constants CANNOT have their values changed during runtime.
imASymbolicConstant				=		10d

; --- LITERAL EXPRESSIONS ---
; Expressions containing the standard mathematical operators will evaluate as expected and
; replace with a resolved value from the expression.  However, the expression must act 
; as a pure constant for this to be successful (i.e. no variable expressions allowed).
; As is the case with all symbolic constants, the value resolved from the expression must
; be fully derivable prior to runtime.
;
; ! SUPPORTED LITERAL EXPRESSION OPERATIONS & SYNTAX !
; OPERATOR	|	PURPOSE								|	PRIORITY
;-----------------------------------------------------------------
;	()		|	grouping							|	1
;	+,-		|	unary positive, unary negative		|	2 (L->R Associativity)
;	*,/,MOD	|	multiplication, division, modulus	|	3 (L->R Associativity)
;	+,-		|	addition, subtraction				|	4 (L->R Associativity)
imASymbolicConstantExpression	=		((2 + 5) MOD 5) * 5

; --- EQU and TEXTEQU ---
; NOTE: Refer to the subsequent demonstration of EQU and TEXTEQU for clarity here...
notAStringVariable				EQU		<"I feel like a string variable, but I'm not one yet.", 0>
isAStringVariable				BYTE	notAStringVariable
alsoNotAStringVariable			TEXTEQU	<"I'm not a string variable as well, but my text might be part of one someday.", 0>
nowItsAStringVariable			BYTE	alsoNotAStringVariable

; CODE SEGMENT
.code
main PROC
	; DEMONSTRATION OF VARIABLE USAGE
	; Display a variable in a traditional manner.  Notice that the MOVZX command must be used
	; because 'imABYTEVariable' was declared as a BYTE (8-bit) and EAX is 4 bytes (32-bit).
	MOVZX EAX, imABYTEVariable
	CALL WriteDec
	CALL Crlf

	; The ADD instruction changes the value of EAX and this new value is copied over to the
	; memory associated with 'imAByteVariable'.  This change occured during program execution
	; and resulted in a physical change at the memory location.
	ADD EAX, 10
	MOV imAByteVariable, AL		; AL since we only need the lower byte of EAX.

	; Now when the modified contents of 'imAByteVariable' are copied over into EAX for subsequent
	; display, the new value can be seen since the memory was modified.
	MOVZX EAX, imAByteVariable
	CALL WriteDec
	CALL Crlf
	CALL Crlf

	; DEMONSTRATION OF SYMBOLIC CONSTANT USAGE
	; Display the value represented by 'imASymbolicConstant'.  By the time the assembler got to
	; this line, the token 'imASymbolicConstant' was replaced by '10d' as associated in the .data
	; segment.  No memory was modified and 'imASymbolicConstant' was treated as an immediate expression.
	MOV EAX, imASymbolicConstant
	CALL WriteDec
	CALL Crlf

	; We can change the immediate expression associated with 'imASymbolicConstant' on-the-fly at any point
	; in the source code.  However, note that no memory was modified by doing this.  Instead, all lines of code
	; after the new definition will be impacted.  This sort of change can occur as many times as the programmer
	; would like, but the assembler is just updating the substitution triggered by the use of the symbolic
	; constant as it progresses through the source code.  No memory was changed as a result of this operation.
	imASymbolicConstant = 20

	; Show the new substitution being used to replace the constant 'imASymbolicConstant'.
	MOV EAX, imASymbolicConstant
	CALL WriteDec
	CALL Crlf

	; Keep in mind that symbolic constants defined with an expression are still just constants.  Any evaluation
	; of the defining expression occurs during program assembly and not runtime.  As a result, no meaningful
	; on-the-fly calculations can occur within these expressions.  Mathematical manipulations dealing with active
	; runtime memory must be brokered through the CPU registers and corresponding mathematical instructions.
	MOV EAX, imASymbolicConstantExpression
	CALL WriteDec
	CALL Crlf
	CALL Crlf

	; DEMONSTRATION OF "EQU" and "TEXTEQU" DIRECTIVES
	; -- EQU Directive --
	; The EQU directive is used to directly associate one symbolic name with another expression.  Evaluation
	; occurs prior to runtime.  Associations established with the EQU directive cannot be changed once established.
	; An EQU symbolic constant can be associated with a literal expression, another symbolic constant or a field
	; of static text.
	
	; Using the EQU directive to create an alias for another symbol.
	thatInteger EQU imASymbolicConstant
	MOV EAX, thatInteger
	CALL WriteDec
	CALL Crlf

	; Using the EQU directive to associate a symbol with a constant mathematical expression.
	shouldBeTwenty EQU 4 / 2 * 10
	MOV EAX, shouldbeTwenty
	CALL WriteDec
	CALL Crlf

	; Using the EQU directive to associate a symbol with static text.  Since the text associated
	; with this symbol must be stored in a variable for display purposes, refer to the .data segment
	; for full context on this example.
	MOV EDX, OFFSET isAStringVariable
	CALL WriteString
	CALL Crlf

	MOV EDX, OFFSET nowItsAStringVariable
	CALL WriteString
	CALL Crlf

	; TEXTEQU is a nearly identical directive to EQU with a few minor exceptions.  Unlike EQU, 
	; TEXTEQU can be redefined at any point in your source code.  The TEXTEQU directive is more
	; commonly associated with pure text substitutions, but can be used to evaluate expressions
	; with special syntax.  TEXTEQU statements are commonly referred to as "text macros" and can
	; be used to alias assembly commands with programmer chosen equivalents.  Multiple text macros
	; can be used to build up interconnected strings of text.
	
	; Set up some aliases for the commands needed to print the contents of 'nowItsAStringVariable'.
	LoadDatText		TEXTEQU <MOV EDX, OFFSET nowItsAStringVariable>
	ShowDatText		TEXTEQU	<CALL WriteString>
	HopDownCursor	TEXTEQU <CALL Crlf>

	; Use the new alias commands to make the string print on the screen.
	LoadDatText
	ShowDatText
	HopDownCursor
	
	; A literal expression using arithmetic operators can be established by containing
	; the constant expression with a preceding '%' symbol.
	thisOneIsThirty TEXTEQU %(shouldBeTwenty + 10)				; Notice how multiple symbolic constants can be used together
																;  to create compound statements.

	; One alias can be used to define another previously defined alias using TEXTEQU
	GoGoGadgetNewline	TEXTEQU	HopDownCursor
	MOV EAX, thisOneIsThirty
	CALL WriteDec
	GoGoGadgetNewline

	; return to OS
	INVOKE ExitProcess, 0
main ENDP

END main					; end of program OPCODES
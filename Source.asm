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

ShowNewline		TEXTEQU	<CALL Crlf>

cornerLeft					EQU		201d	; 201 is the base-10 ASCII code for open ended left corner
theDoubleLinesSymbol		EQU		205d	; 205 is the base-10 ASCII code for "="
tShapeConnector				EQU		203d	; 203 is the base-10 ASCII code for t shape open ended connector
cornerRight					EQU		187d	; 187 is the base-10 ASCII code for open ended right corner 
straightLinesDown			EQU		186d	; 186 is the base-10 ASCII code for straight double line down
letterSalph					EQU		83d		; 83 is the base-10 ASCII code for a letter S
letterFalph					EQU		70d		; 70 is the base-10 ASCII code for a letter F




; --- DUP Operator ---
; The DUP operator can be used to replicate symbolic constant text an arbitrary number of times.
; DUP is commonly used to initialize large data segment arrays.
;arraySizeMessage	BYTE	"'howeverManyAs' array size currently set to: ", 0

cornerL			BYTE	1	DUP(cornerLeft), 0
flatLines		BYTE	3 DUP(theDoubleLinesSymbol), 0
tConnector		BYTE	1 DUP(tShapeConnector),0
cornerR			BYTE	1 DUP(cornerRight), 0
straightLineD	BYTE    1 DUP(straightLinesDown), 0
letterS			BYTE	1 DUP(letterSalph), 0
letterF			BYTE	1 DUP(letterFalph), 0



;
;howeverManyAs		BYTE	arraySize DUP("A"), 0

; --- CURRENT LOCATION COUNTER ($) ---
; The current location is the 32-bit memory address associated with the current offset
; into the code segment.  This value can be casually retrieved with the '$' symbol used
; in place of a 32-bit integer literal (memory addresses take 
; the form of DWORDs, or 32-bit on x86).
;endOfAsOffset		DWORD	$

; NOTE: By capturing the offset address at 'endOfAsOffset', we can calculate the size
; of 'howeverManyAs' by creating a literal symbolic constant containing the difference
; between the two addresses.  Since this is an array of BYTE variables, a single offset
; address correlates exactly to a single element in the string.  Keep in mind the null
; byte was also appened to the end of the string to ensure compatibility with display
; functions.  This null byte also takes up a BYTE when the size calculation takes place.

; CODE SEGMENT
.code
main PROC
	
	MOV EDX, OFFSET cornerL
	CALL WriteString
	
	; Show the string with 5 = signs.
	MOV EDX, OFFSET flatLines
	CALL WriteString

	MOV EDX, OFFSET tConnector
	CALL WriteString 
	
	; Show the string with 5 = signs.
	MOV EDX, OFFSET flatLines
	CALL WriteString

	MOV EDX, OFFSET tConnector
	CALL WriteString 
	
		; Show the string with 5 = signs.
	MOV EDX, OFFSET flatLines
	CALL WriteString

	MOV EDX, OFFSET tConnector
	CALL WriteString 

		; Show the string with 5 = signs.
	MOV EDX, OFFSET flatLines
	CALL WriteString

	MOV EDX, OFFSET tConnector
	CALL WriteString 

		; Show the string with 5 = signs.
	MOV EDX, OFFSET flatLines
	CALL WriteString

	MOV EDX, OFFSET tConnector
	CALL WriteString 

		; Show the string with 5 = signs.
	MOV EDX, OFFSET flatLines
	CALL WriteString

	MOV EDX, OFFSET tConnector
	CALL WriteString 

		; Show the string with 5 = signs.
	MOV EDX, OFFSET flatLines
	CALL WriteString

	MOV EDX, OFFSET tConnector
	CALL WriteString 

		; Show the string with 5 = signs.
	MOV EDX, OFFSET flatLines
	CALL WriteString

	MOV EDX, OFFSET cornerR	
	CALL WriteString 
	ShowNewline

	MOV EDX, OFFSET straightLineD
	CALL WriteString

	MOV EDX, OFFSET letterS
	call WriteString 
	
	MOV EDX, OFFSET letterF
	call WriteString 

	; Show 'arraySize' As.
	;MOV EDX, OFFSET howeverManyAs
	;CALL WriteString
	;ShowNewline

	; Establish and display 'howeverManyAs' array size by adjusting the constant
	; difference between 'endOfAsOffset' and 'howeverManyAs'.
	;MOV EDX, OFFSET arraySizeMessage
	;CALL WriteString
	;MOV EAX, (endOfAsOffset - howeverManyAs)		; it is arraySize + 1 since the null byte counts
	;DEC EAX											; adjust for null byte
	; NOTE: We were only able to perform (endOfAsOffset - howeverManyAs) as a literal expression
	; subtraction because at this point in the code, both identifiers resolve to constant (immediate)
	; values.  If either of these values was associated with a memory location for storate, this
	; different would have to have been calculated through a CPU operation (probably SUB).
	;CALL WriteDec
	ShowNewline
	
	; return to OS
	INVOKE ExitProcess, 0
main ENDP

END main				; end of program OPCODES
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
addendOne			DWORD 10d

eFlagContents		BYTE ?

ShowNewline		TEXTEQU	<CALL Crlf>

;numberZero					EQU		48d		; 48 is the base-10 ASCII code for the number zero
cornerLeft					EQU		201d	; 201 is the base-10 ASCII code for open ended left corner
theDoubleLinesSymbol		EQU		205d	; 205 is the base-10 ASCII code for "="
tShapeConnector				EQU		203d	; 203 is the base-10 ASCII code for t shape open ended connector
cornerRight					EQU		187d	; 187 is the base-10 ASCII code for open ended right corner 
straightLinesDown			EQU		186d	; 186 is the base-10 ASCII code for straight double line down
tShapeConnectorLeft			EQU		204d	; 204 is the base-10 ASCII code for t shape open connector on left side 
fourWayConnector			EQU		206d	; 206 is the base-10 ASCII code for four way connector with open ends
letterSalph					EQU		83d		; 83 is the base-10 ASCII code for a letter S
letterFalph					EQU		70d		; 70 is the base-10 ASCII code for a letter F
letterZalph					EQU		90d		; 90 is the base-10 ASCII code for a letter Z
letterRalph					EQU		82d		; 82 is the base-10 ASCII code for a letter R
letterEalph					EQU		69d		; 69 is the base-10 ASCII code for a letter E
letterAalph					EQU		65d		; 65 is the base-10 ASCII code for a letter A
letterPalph					EQU		80d		; 80 is the base-10 ASCII code for a letter P
letterCalph					EQU		67d		; 67 is the base-10 ASCII code for a letter C
spaceCommand				EQU     32d		; 32 is the base-10 ASCII code for a space
tShapeConnectorRight		EQU		185d	; 185 is the base-10 ASCII code for a t shape connector on the right side 
bottomCornerLeft			EQU     200d	; 200 is the base-10 ASCII code for a open ended L shape
bottomCornerRight			EQU		188d	; 188 is the base-10 ASCII code for a open ended backwards L shape
InvertedTConnector			EQU		202d	; 202 is the base-10 ASCII code for a inverted open ended capital T

numberOne					EQU		49d		; 49 is the base-10 ASCII code for the number one		





cornerL			BYTE	1	DUP(cornerLeft), 0
flatLines		BYTE	3 DUP(theDoubleLinesSymbol), 0
tConnector		BYTE	1 DUP(tShapeConnector),0
cornerR			BYTE	1 DUP(cornerRight), 0
straightLineD	BYTE    1 DUP(straightLinesDown), 0
letterS			BYTE	1 DUP(letterSalph), 0
letterF			BYTE	1 DUP(letterFalph), 0
letterZ			BYTE	1 DUP(letterZalph), 0
letterR			BYTE	1 DUP(letterRalph), 0
letterE			BYTE	1 DUP(letterEalph), 0
letterA			BYTE	1 DUP(letterAalph), 0
letterP			BYTE	1 DUP(letterPalph), 0
letterC			BYTE	1 DUP(letterCalph), 0
spaceC			byte	1 DUP(spaceCommand), 0
tShapeConnectorL BYTE   1 DUP(tShapeConnectorLeft), 0
fourWayC		BYTE	1 DUP(fourWayConnector), 0
tShapeConnectorR BYTE   1 DUP(tShapeConnectorRight), 0
bottomCornerL	BYTE	1 DUP(bottomCornerLeft), 0
bottomCornerR	BYTE	1 DUP(bottomCornerRight), 0
invertedTC		BYTE	1 DUP(invertedTConnector), 0
;numberZeroD			BYTE	0 DUP(numberZero); 0
number1			BYTE	1 DUP(numberOne); 0









;


; CODE SEGMENT
.code
main PROC

; "lahf" - load flag data into AH - This is a single command that appears alone.
	;                                   when the command is executed, the lower BYTE (8-bits)
	;                                   of the EFLAGS register is loaded directly to AH.
	lahf
	MOV eFlagContents, AH				; Store a copy of the flag contents for future use.

	; Show the contents of EAX directly after the 'lahf' call.
	CALL WriteBinB
	CALL Crlf

	
	;Visual represention of graph begins here
	
	ShowNewLine
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

	MOV EDX, OFFSET spaceC
	call WriteString 
	
	MOV EDX, OFFSET straightLineD
	CALL WriteString

	MOV EDX, OFFSET letterZ
	CALL WriteString

	MOV EDX, OFFSET letterF
	CALL WriteString

	MOV EDX, OFFSET spaceC
	call WriteString 
	
	MOV EDX, OFFSET straightLineD
	CALL WriteString

	 MOV EDX, OFFSET letterR
	CALL WriteString

	MOV EDX, OFFSET letterE
	CALL WriteString

	MOV EDX, OFFSET letterS
	CALL WriteString

	MOV EDX, OFFSET straightLineD
	CALL WriteString

	MOV EDX, OFFSET letterA
	CALL WriteString

	MOV EDX, OFFSET letterF
	CALL WriteString

	MOV EDX, OFFSET spaceC
	call writestring
	
	MOV EDX, OFFSET straightLineD
	CALL WriteString

	MOV EDX, OFFSET letterR
	CALL WriteString

	MOV EDX, OFFSET letterE
	CALL WriteString

	MOV EDX, OFFSET letterS
	CALL WriteString

	MOV EDX, OFFSET straightLineD
	CALL WriteString

	MOV EDX, OFFSET letterP
	CALL WriteString

	MOV EDX, OFFSET letterF
	CALL WriteString

	mov edx, offset spaceC
	call writestring

		MOV EDX, OFFSET straightLineD
	CALL WriteString

	MOV EDX, OFFSET letterR
	CALL WriteString

	MOV EDX, OFFSET letterE
	CALL WriteString

	MOV EDX, OFFSET letterS
	CALL WriteString

	MOV EDX, OFFSET straightLineD
	CALL WriteString

	MOV EDX, OFFSET letterC
	CALL WriteString

	MOV EDX, OFFSET letterF
	CALL WriteString

	mov edx, offset spaceC
	call writestring

	MOV EDX, OFFSET straightLineD
	CALL WriteString

	ShowNewLine

	mov edx, offset tShapeConnectorL
	call writestring

	MOV EDX, OFFSET flatLines
	CALL WriteString

	mov edx , offset fourWayC
	call writestring 

	mov edx, offset flatlines
	call writestring 

	mov edx , offset fourWayC
	call writestring 

	mov edx, offset flatlines
	call writestring 

	mov edx , offset fourWayC
	call writestring 

	mov edx, offset flatlines
	call writestring 

	mov edx , offset fourWayC
	call writestring 

	mov edx, offset flatlines
	call writestring 

	mov edx , offset fourWayC
	call writestring 

	mov edx, offset flatlines
	call writestring 

	mov edx , offset fourWayC
	call writestring 

	mov edx, offset flatlines
	call writestring 

	mov edx , offset fourWayC
	call writestring 

	mov edx, offset flatlines
	call writestring 

	mov edx, offset tShapeConnectorR
	call writestring 

	ShowNewLine

	mov edx,offset straightLineD
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset spaceC		;Directly under SF, ATTENTION FUTURE ME: you will be able to remove the middle space and place the value for corresponding flag
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset straightLineD
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset spaceC	;Directly under ZF
	call writestring

	mov edx,offset spaceC
	call writestring
	
	mov edx,offset straightLineD
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset spaceC	;Directly under RES
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset straightLineD
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset spaceC	;Directly under AF
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset straightLineD
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset spaceC	;Directly under RES
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset straightLineD
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset spaceC	;Directly under PF
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset straightLineD
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset number1 ;Directly under RES, Reserved, always 1 in Eflags
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset straightLineD
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset spaceC	;Directly under CF 
	call writestring

	mov edx,offset spaceC
	call writestring

	mov edx,offset straightLineD
	call writestring

	; End of values for flags section
	ShowNewLine

	
	mov edx,offset bottomCornerL
	call writestring

	
	mov edx,offset flatLines
	call writestring

	mov edx, offset invertedTC
	call writestring
	
	mov edx,offset flatLines
	call writestring

	
	mov edx, offset invertedTC
	call writestring
	
	mov edx,offset flatLines
	call writestring

	
	mov edx, offset invertedTC
	call writestring
	
	mov edx,offset flatLines
	call writestring

	
	mov edx, offset invertedTC
	call writestring
	
	mov edx,offset flatLines
	call writestring

	
	mov edx, offset invertedTC
	call writestring
	
	mov edx,offset flatLines
	call writestring

	
	mov edx, offset invertedTC
	call writestring
	
	mov edx,offset flatLines
	call writestring
		
	mov edx, offset invertedTC
	call writestring
	
	mov edx,offset flatLines
	call writestring

	
	mov edx, offset bottomCornerR
	call writestring

	

	
	
	
	;Visual represention of graph ends here



	ShowNewline

	


	; return to OS


	INVOKE ExitProcess, 0
main ENDP

END main				; end of program OPCODES
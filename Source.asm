
;By: James Meegan 3/25/21

; EXTERNAL DEPENDENCIES

INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

; EXECUTION MODE PARAMETERS
.386
.model flat, stdcall
.stack 4096

; PROTOTYPES
ExitProcess PROTO, dwExitCode:DWORD

; DATA SEGMENT
.data
eFlagContents		BYTE ?

; -- Status Flag Names --
; NOTE: After a call to LAHF, AH is loaded with EFLAGS status flag
;       information. AH = EFLAGS(SF:ZF:00:AF:00:PF:01:CF).  Notice
;       that from the least significant position, bits 1, 3 and 5 are reserved.
;       SF = Sign Flag				-- Set to 1 if the result of an immediate operation is negative.
;       ZF = Zero Flag				-- Set to 1 if the result of an immediate operation is zero.
;       AF = Auxillary Carry Flag	-- Set to 1 if the result of an immediate operation resulted in
;									--  a carry bit moving from bit position 3 to bit position 4
;									--  in the lowest BYTE.
;       PF = Parity Flag			-- Set to 1 if the result of an immediate operation stored a value
;									--  with an ODD number of 1 bits.  Set to 0 if the result of an
;									--  immediate operation stored a value with an EVEN number of 1 bits.
;       CF = Carry Flag				-- Set to 1 if a bit carried out of the most significant position
;									--  on an unsigned integer encoding.

; CODE SEGMENT
.code
main PROC


	; Clobber EAX with all 0s and show the clean slate.
	MOV EAX, 0
	
	CALL Crlf
	
	; "lahf" - load flag data into AH - This is a single command that appears alone.
	;                                   when the command is executed, the lower BYTE (8-bits)
	;                                   of the EFLAGS register is loaded directly to AH.
	lahf
	MOV eFlagContents, AH				; Store a copy of the flag contents for future use.

	; Now that the flag data has been captured in 'eFlagContents' (8-bits), we must copy in
	;  into EAX (32-bits).
	MOVZX EAX, eFlagContents


	; Show the contents of AL (the place where the flag data should have been copied at this point).
	MOV EBX, TYPE BYTE
	
	CALL WriteBinB ;Intial flag contents displayed here
	CALL Crlf


	; Return to OS.
	INVOKE ExitProcess, 0
main ENDP

END main								; end of OPCODES
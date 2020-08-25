section .text
	global	ft_strcmp
	extern	ft_strlen

;int rax	ft_strcmp(const char *rdi, const char *rsi);

ft_strcmp:
	XOR 	rcx, rcx			;initialize rcx (i.e. the cursor) at 0 (because bytes are =)
	XOR 	rax, rax			;initialize rax (i.e. the return value) at 0 (//)

comp:
	XOR 	al, al				;initialize	al (the low part of the ax register)
	SUB 	al, byte[rsi + rcx]	;al = al - byte[rsi + rcx]
	ADD 	al, byte[rdi + rcx]	;al = al + byte[rdi + rcx]
	JZ		incr				;if al equals , jump to the incr label
	MOVSX	rax, al				;if not, al is copied in rax (even though it is < to the latest:
								;remaning bytes in rax are filled with the extension of the signs
	RET							;return rax

incr:
	INC 	rcx					;increment rcx
	CMP 	BYTE[rdi + rcx], 0	;check if rdi[rcx] != \0 -> jump to incr layer
	JNZ 	comp
	CMP 	BYTE[rsi + rcx], 0	;check if rsi[rcx] != \0 -> jump to diff_bellow
	JNZ		comp
	MOV 	rax, 0
	RET



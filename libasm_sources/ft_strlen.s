section	.text
	global	ft_strlen

;size_t rax	ft_strlen(const char *rdi);

ft_strlen:
	MOV rcx, 0				;initialize rcx (i.e. the cursor) at 0
	MOV rax, 0				;initialize rax (i.e. the return value) at 0
	JMP comp				;jump to the comp label

incr:
	INC	rcx;				;increment rcx

comp:
	CMP byte[rdi + rcx], 0	;compare the byte at str[rcx] to 0
	JNE	incr				;if not equal, jump to the incr label
	MOV rax, rcx			;if equal, rax get the value of rcx
	RET						;return rax
section	.text
	global	ft_strcpy

;char	*ft_strcpy(char *dest, const char *src);
;rax	ft_strcpy(rdi, rsi);

ft_strcpy:
	XOR		rcx, rcx			;initialize rcx (i.e. the cursor) at 0 (because bytes are equal)
	XOR		rax, rax			;initialize rax (i.e. the return value) at 0 (//)

copy:
	MOV		al, byte[rsi + rcx]	;al receives the value of the byte at the source address rsi + rcx
	MOV		byte[rdi + rcx], al	;the byte at the destination adress rdi + rcx receives the value of al

incr:
	INC		rcx					;increment rcx

comp:
	CMP		byte[rsi + rcx], 0	;compare the byte at str[rcx] to 0
	JNE		copy				;if not equal, jump to the copy label
	MOV		rax, rdi			;if equal, rax get the value of rdi
	RET							;return
section	.text
	global	ft_strdup
	extern	malloc				;import malloc() uncontionally (rax	malloc(rdi))
	extern	ft_strlen			;import ft_strlen()
	extern	ft_strcpy			;import ft_strcpy()

;char	*ft_strdup(const char *str)
;rax	ft_strdup(rdi)

ft_strdup:
	XOR 	rax, rax			;initialize rax at 0
	XOR		rbx, rbx			;initialize rbx (i.e. a general register) at 0

size:
	CALL	ft_strlen
	MOV		rbx, rdi			;rbx receives the value of rdi (the parameter of ft_strdup())
	JMP		crea				;jump to the crea label
	
crea:
	INC		rax					;add 1 to the size for the null character
	MOV		rdi, rax			;rdi receives the value of rax
	CALL	malloc				;call the malloc function
	CMP		rax, 0				;compare rax (the return of the malloc function) to 0
	JNE		copy				;if the return is not null, jump to the copy label
	RET							;else (if malloc failed) jump to the zero label

copy:
	XOR		rdi, rdi			;re-initialize rdi at 0
	MOV		rdi, rax			;rdi receives the value of rax (= the newly allocated string)
	MOV		rsi, rbx			;rsi receives the value of rbx (= the string to copy)
	XOR		rax, rax			;re-initialize rax at 0
	CALL 	ft_strcpy
	RET
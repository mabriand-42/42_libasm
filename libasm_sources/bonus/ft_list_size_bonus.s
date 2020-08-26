section	.text
	global	ft_list_size

;int	ft_list_size(t_list *begin_list);
;rax	ft_list_size(rdi);

ft_list_size:
	MOV		rsi, rdi		;rsi receives the value of rdi
	XOR		rax, rax		;initialize rax at 0
	JMP		count

incr:
	INC		rax

;count:
;	CMP		rdi, 0			;check if begin_list is a null pointer
;	JZ		return			;jump to the return label if so
;	MOV		rdi, [rdi + 8]	;begin = begin.next (to go through the list)
;	JMP		incr

count:
	CMP		rdi, 0			;check if begin_list is a null pointer
	JNZ		move			;jump to the move label if not
	MOV		rdi, rsi
	RET

move:
	MOV		rdi, [rdi + 8]	;begin = begin.next (to go through the list)
	JMP		incr

;return:
;	MOV		rdi, rsi
;	RET
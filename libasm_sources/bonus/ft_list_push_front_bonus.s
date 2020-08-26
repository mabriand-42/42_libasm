section	.text
	global	ft_list_push_front		;import malloc() uncontionally (rax malloc(rdi))
	extern	malloc

;void	ft_list_push_front(t_list **begin_list, void *data)
;rax	ft_list_push_front(rdi, rsi)

ft_list_push_front:
	PUSH	rsp				;save the content of rsp (i.e. a general register = stack pointer) by putting it in the pile
	PUSH	rdi				;save begin_list (rdi can now be used : set at 0)
	PUSH	rsi				;save data (rsi can now be used : set at 0)

	MOV		rdi, 16			;add 16 bits to rdi (content = 1B, pointer to the next element of the list = 1B)
	XOR		rax, rax		;initialize rax at 0
	CALL	malloc			;call the malloc function
	POP		rsi				;get the content of the pile (= stack) back in the register rsi
	POP		rdi				;get the content of the pile (= stack) back in the register rdi
	CMP		rax, 0			;compare rax (the return of the malloc function) to 0
	JZ		return			;if malloc failed, jump to the return label

	MOV		[rax], rsi		;new.data = data
	MOV		rcx, [rdi]
	MOV		[rax + 8], rcx	;new.next = *begin
	MOV		[rdi], rax		;*begin = new

return:
	POP		rsp				;get the content of the pile (= stack) back in the register rsp
	RET
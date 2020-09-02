section	.text
	global	ft_list_remove_if
	extern	free

; void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
; int	(*cmp)(list_ptr->data, data_ref);
; void	(*free_fct)(list_ptr->data);
; rax	ft_list_remove_if(rdi, rsi, rdx, rcx);

ft_list_remove_if:
	PUSH	rbp					; save rbp (tmp)
	PUSH	rbx					; save rbx (previous)
	PUSH	r12					; save r12 (first)
	MOV		r12, [rdi]			; first = *begin
	XOR		rbx, rbx			; previous = NULL
	CMP		rdi, 0				; begin == NULL
	JZ		return
	CMP		rdx, 0
	JZ		return
	CMP		rcx, 0
	JZ		return
	JMP		comp_start			; jump to the comp_start label

free_elt:
	MOV		r8, [rdi]			; r8 receives the adress of rdi (r10 = *begin_list)
	MOV		rbp, [r8 + 8]		; tmp = (*begin)->next
	PUSH	rsi
	PUSH	rdx
	PUSH	rcx
	PUSH	rdi
	MOV		rdx, [rdi]
	MOV		rdi, [rdx]
	CALL	rcx					; (*free_fct)((*begin)->data)
	POP		rdi
	PUSH	rdi
	MOV		rdx, [rdi]
	MOV		rdi, rdx
	CALL	free				; free(*begin)
	POP		rdi
	POP		rcx
	POP		rdx
	POP		rsi
	MOV		[rdi], rbp			; *begin = tmp
	CMP		rbx, 0				; previous == NULL
	JNZ		prev_next
	MOV		r12, rbp			; first == tmp
	JMP		comp_start

prev_next:
	MOV		[rbx + 8], rbp		; previous.next = tmp
	JMP		comp_start

comp_null:
			xor		rdi, rsi
	MOV		rax, rdi
	JMP		comp_end

move_next:
	MOV		rbx, [rdi]
	MOV		r8,	[rbx + 8]		; tmp = (*begin)->next
	MOV		[rdi], r8			; *begin = tmp

comp_start:
	CMP		QWORD [rdi], 0		; *begin == NULL
	JZ		return
	PUSH	rdi
	PUSH	rsi					; data_ref already in rsi
	PUSH	rdx
	PUSH	rcx
	MOV		r8, [rdi]
	MOV		rdi, [r8]			; (*begin)->data in rdi
	CMP		rdi, 0				; (*begin)->data == NULL
	JZ		comp_null
	CALL	rdx					; (*cmp)((*begin)->data, data_ref)

comp_end:
	POP		rcx
	POP		rdx
	POP		rsi
	POP		rdi
	CMP		rax, 0				; (*cmp) == 0
	JZ		free_elt			; (*free_fct)
	JMP		move_next

return:
	MOV		[rdi], r12			; *begin = first
	POP		r12					; restore rbx
	POP		rbx					; restore rbx
	POP		rbp					; restore rbp
	RET
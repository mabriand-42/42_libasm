section	.text
	global	ft_list_remove_if
	extern	free

;void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
;int	(*cmp)(list_ptr->data, data_ref);
;void	(*free_fct)(list_ptr->data);
;rax	ft_list_remove_if(rdi, rsi, rdx, rcx);

ft_list_remove_if:
first:
	MOV		r10, [rdi]	; r10 = *begin_list
	CMP		r10, 0		; check if *begin_list == NULL
	JE		stop		; if so, jump to the return label
	PUSH	rdi			; save rdi
	PUSH	rsi			; save rsi
	PUSH	rdx			; save rdx

	MOV		rdi, [r10]	; first = lst->data


	CALL	rdx				; call the comparison function
	POP		rdx				; restore rdx
	POP		rsi				; restore rsi
	POP		rdi				; restore rdi
	CMP		rax, 0			; check if ret == 0 (the return of the function previously calleds)
	JNE		stop			; if not jump to the stop label

	MOV		r10, [rdi]		; stock *begin_list (r10 = *begin_list)

	MOV		r11, [r10+8]	; r11 = *begin_list->next
	MOV		[rdi], r11		; *begin_list = (*begin_list)->next
	PUSH	rdi
	PUSH	rsi
	PUSH	rdx
	PUSH	r10
	PUSH	r11

	MOV		rdi, r10		; first = *begin_list
	CALL	free			; free(*begin_list)
	POP		r11
	POP		r10
	POP		rdx
	POP		rsi
	POP		rdi
	JMP		first			; loop by jumping to the first label

stop:
	MOV		r10, [rdi]		; r10 = *begin_list

second:
	MOV		r11, [r10+8]	; r11 = r10->next
	CMP		r10, 0			; check if r10 == NULL
	JE		end				; if so, jump to the end label
	CMP		r11, 0			; check if r11 (next) == NULL
	JE		end				; if so, jump to the end label
	PUSH	rdi
	PUSH	rsi
	PUSH	rdx
	PUSH	r10
	PUSH	r11
	MOV		rdi, [r11]		; first = next->data
	CALL	rdx				; *cmp((*being_list)->data, data_ref)
	POP		r11
	POP		r10
	POP		rdx
	POP		rsi
	POP		rdi
	CMP		rax, 0			; check if ret == 0
	JNE		pass			; if not, jump to the pass label
	PUSH	rdi
	PUSH	rsi
	PUSH	rdx
	PUSH	r10
	PUSH	r11
	MOV		rdi, r11		; 1st = next
	MOV		r11, [r11+8]	; r11 = next->next
	MOV		[r10+8], r11	; r10->next = next->next
	CALL	free			; free(next)
	POP		r11
	POP		r10
	POP		rdx
	POP		rsi
	POP		rdi
	JMP		second			; loop by jumping to the second label

pass:
	MOV		r10, r11		; *r10 = next
	JMP		second			; loop by jumping to the second label

end:
	RET
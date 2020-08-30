section .text
	extern free
	global ft_list_remove_if

ft_list_remove_if:
first:
	mov		r10, [rdi]	; r10 = *begin_list
	cmp		r10, 0		; if *begin_list == NULL
	je		stop		; then return
	push	rdi			;
	push	rsi			;
	push	rdx			;
	mov		rdi, [r10]	; 1st = lst->data
	call	rdx			; *cmp((*being_list)->data, data_ref)
	pop		rdx			;
	pop		rsi			;
	pop		rdi			;
	cmp		rax, 0		; if ret != 0
	jne		stop		; then break
	mov		r10, [rdi]	; stock *begin_list
	mov		r11, [r10+8]; r12 = *begin_list->next
	mov		[rdi], r11	; *begin_list = (*begin_list)->next
	push	rdi			;
	push	rsi			;
	push	rdx			;
	push	r10			;
	push	r11			;
	mov		rdi, r10	; 1st = *begin_list
	call	free		; free(*begin_list)
	pop		r11			;
	pop		r10			;
	pop		rdx			;
	pop		rsi			;
	pop		rdi			;
	jmp		first		; loop

stop:
	mov		r10, [rdi]	; r10 = *begin_list

second:
	mov		r11, [r10+8]; r11 = r10->next
	cmp		r10, 0		; if r10 == NULL
	je		end			; then end
	cmp		r11, 0		; if next == NULL
	je		end			; then end
	push	rdi			;
	push	rsi			;
	push	rdx			;
	push	r10			;
	push	r11			;
	mov		rdi, [r11]	; 1st = next->data
	call	rdx			; *cmp((*being_list)->data, data_ref)
	pop		r11			;
	pop		r10			;
	pop		rdx			;
	pop		rsi			;
	pop		rdi			;
	cmp		rax, 0		; if ret != 0
	jne		pass		; then break
	push	rdi			;
	push	rsi			;
	push	rdx			;
	push	r10			;
	push	r11			;
	mov		rdi, r11	; 1st = next
	mov		r11, [r11+8]; r11 = next->next
	mov		[r10+8], r11; r10->next = next->next
	call	free		; free(next)
	pop		r11			;
	pop		r10			;
	pop		rdx			;
	pop		rsi			;
	pop		rdi			;
	jmp		second		; loop

pass:
	mov		r10, r11	; *r10 = next
	jmp		second		; loop

end:
	ret
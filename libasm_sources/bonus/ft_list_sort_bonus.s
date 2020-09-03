section	.text
	global	ft_list_sort

; void	ft_list_sort(t_list **begin_list, int (*cmp)());
; int	(*cmp)(list_ptr->data, other_list_ptr->data);
; rax	ft_list_sort(rdi, rsi);

ft_list_sort:
	PUSH	rbx					; save rbx (next)
	PUSH	r12					; save r12 (first)
	CMP		rdi, 0				; check if rdi == NULL
	JZ		restore				; if equal, jump to the restore label
	MOV		r12, [rdi]			; else r12 receives the adress of rdi (first = *begin)
	CMP		rsi, 0				; check if rsi == NULL
	JZ		return				; if equal, jump to the return label
	JMP		comp_main			; else jump to the comp_main label

incr_main:
	MOV		rcx, [rdi]
	MOV		rbx, [rcx + 8]
	MOV		[rdi], rbx			; *begin = (*begin)->next

comp_main:
	CMP		QWORD [rdi], 0		; check if the adress of rdi = NULL (*begin == NULL) (!*begin)
	JZ		return				; if equal, jump to the return label
	MOV		rcx, [rdi]			; rcx receives the adress of rdi
	MOV		rbx, [rcx + 8]		; current = (*begin)->next

comp_single:
	CMP		rbx, 0				; !current
	JZ		incr_main

compare:
	PUSH	rdi					; save rdi
	PUSH	rsi					; save rsi
	MOV		rax, rsi
	MOV		rcx, [rdi]
	MOV		rdi, [rcx]			; rdi = (*begin)->data
	MOV		rsi, [rbx]			; rsi = current->data
	CALL	rax					; (*cmp)((*begin)->data, current->data)
	POP		rsi
	POP		rdi
	CMP		rax, 0				; check if rax > 0
	JG		swap				; if superior, jump to the swap label

incr_single:
	MOV		rcx, [rbx + 8]
	MOV		rbx, rcx			; current = current.next
	JMP		comp_single

swap:
	MOV		r8, [rdi]
	MOV		rcx, [r8]			; rcx = (*begin)->data
	MOV		rax, [rbx]			; rax = current->data
	MOV		[r8], rax			; (*begin)->data = current->data
	MOV		[rbx], rcx			; current->data = (*begin)->data
	JMP		incr_single

return:
	MOV		[rdi], r12			; the adress of rdi receives the value of r12 (*begin = first)

restore:
	POP		r12					; restore r12
	POP		rbx					; restore rbx
	RET
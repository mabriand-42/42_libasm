section	.text
	global ft_write
	extern __errno_location

; ssize_t	ft_write(int fd, const void *buf, size_t count);
; rax		ft_write(rdi, rsi, rdx);

ft_write:
	XOR		rax, rax			; initialize rax (i.e. the return value) at 0
	MOV		rax, 1				; rax receives the value 1
	SYSCALL						; make a system call on 1 (=write)
	CMP		rax, 0				; chek if the system call succeeded
	JL		error				; if not, jump to the error label
	RET

error:
	NEG		rax
	MOV		rdi, rax
	CALL	__errno_location	; call the errno function
	MOV		[rax], rdi
	MOV		rax, -1
	RET
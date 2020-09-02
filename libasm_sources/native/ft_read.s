section	.text
	section .text
	global ft_read
	extern __errno_location

;ssize_t	ft_read(int fd, void *buf, size_t count);
;rax		ft_read(rdi, rsi, rdx);

ft_read:
	XOR		rax, rax			; initialize rax (i.e. the return value) at 0
	MOV		rax, 0				; rax receives the value 0
	SYSCALL						; make a system call on 0 (=read)
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
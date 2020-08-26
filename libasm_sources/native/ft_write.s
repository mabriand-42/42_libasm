section	.text
	global ft_write
	extern __errno_location

;ssize_t	ft_write(int fd, const void *buf, size_t count)
;rax		ft_write(rdi, rsi, rdx)

ft_write:
	XOR		rax, rax
	MOV		rax, 1
	SYSCALL
	CMP		rax, 0
	JL		error
	RET

error:
	NEG		rax
	MOV		rdi, rax
	CALL	__errno_location
	MOV		[rax], rdi
	MOV		rax, -1
	RET
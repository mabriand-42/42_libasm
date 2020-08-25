section	.text
	section .text
	global ft_read
	extern __errno_location

;ssize_t	ft_read(int fd, void *buf, size_t count)
;rax		ft_read(rdi, rsi, rdx)

ft_read:
	XOR		rax, rax	
	MOV		rax, 0
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
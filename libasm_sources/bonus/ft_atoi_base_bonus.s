section	.text
	global	ft_atoi_base

; int	ft_atoi_base(const char *str,const char *base);
; rax	ft_atoi_base(rdi, rsi);

ft_atoi_base:
	XOR		rax, rax				; initialize rax(i.e. the return value) at 0
	XOR		rbx, rbx				; initialize rbx(i.e. the sign) at 0
	XOR		r12, r12				; initialize r12(i.e. the base length) at 0 (i = 0)
	JMP		base_loop

base_incr:
	INC		r12						; increment r12 (i++)

base_loop:
	CMP		BYTE [rsi + r12], 0		; check if rsi[r12] == '\0'
	JZ		base_end				; if equal, jump to base_end label
	MOV		r8, r12					; else r8 receives the value of r12 (j = i)

check_incr:
	INC		r8						; increment r8 (j++)

check_loop:
	CMP		BYTE [rsi + r8], 0		; chek if base[r8] == '\0'
	JZ		base_check				; if equal, jump to the base_check label
	MOV		r9b, [rsi + r8]
	CMP		BYTE [rsi + r12], r9b	; base[base_length] == base[j]
	JE		set_rax					; if equal, jump to the set_rax label
	JMP		check_incr				; else, jump to the check_incr label

base_check:
	CMP		BYTE [rsi + r12], 32	; chek if base[base_length] == ' '
	JE		set_rax
	CMP		BYTE [rsi + r12], 43	; chek if base[base_length] == '+'
	JE		set_rax
	CMP		BYTE [rsi + r12], 45	; chek if base[base_length] == '-'
	JE		set_rax
	CMP		BYTE [rsi + r12], 9		; chek if base[base_length] == '\t'
	JE		set_rax
	CMP		BYTE [rsi + r12], 10	; chek if base[base_length] == '\n'
	JE		set_rax
	CMP		BYTE [rsi + r12], 13	; chek if base[base_length] == '\r'
	JE		set_rax
	CMP		BYTE [rsi + r12], 11	; chek if base[base_length] == '\v'
	JE		set_rax
	CMP		BYTE [rsi + r12], 12	; chek if base[base_length] == '\f'
	JE		set_rax
	JMP		base_incr

base_end:
	CMP		r12, 1					; check if base_length <= 1 (if so, it means the base is not valid)
	JLE		set_rax					; if lower or equal, jump to the set_rax label
	XOR		r8, r8					; else initialize r8 at 0 (i = 0)
	JMP		skip_white				; jump to the skip_white label

skip_incr:
	INC		r8						; i++

skip_white:
	CMP		BYTE [rdi + r8], 32		; check if str[i] == ' '
	JE		skip_incr
	CMP		BYTE [rdi + r8], 9		; check if str[i] == '\t'
	JE		skip_incr
	CMP		BYTE [rdi + r8], 10		; check if str[i] == '\n'
	JE		skip_incr
	CMP		BYTE [rdi + r8], 13		; check if str[i] == '\r'
	JE		skip_incr
	CMP		BYTE [rdi + r8], 11		; check if str[i] == '\v'
	JE		skip_incr
	CMP		BYTE [rdi + r8], 12		; check if str[i] == '\f'
	JE		skip_incr
	JMP		check_sign

is_negative:
	XOR		bl, 0x00000001

is_positive:
	INC		r8

check_sign:
	CMP		BYTE [rdi + r8], 45		; check if str[i] == '-'
	JE		is_negative				; if equal, jump to the is_negative label
	CMP		BYTE [rdi + r8], 43		; else check if str[i] == '+'
	JE		is_positive				; if equal, jump to the is_positive label
	JMP		atoi_loop				; else jump to the atoi_loop label

atoi_incr:
	INC		r8						; increment r8 (i++)

atoi_loop:
	CMP		BYTE [rdi + r8], 0		; str[i] == '\0'
	JE		set_rax					; if equal jump to the set_rax label
	XOR		r9, r9					; else initialize r9 at 0
	JMP		index_incr

index_incr:
	INC		r9						; increment r9 (j++)

atoi_index:
	MOV		r10b, BYTE [rsi + r9]	; r10b (8 "lower" bits register) receives the value of the byte at rsi[r9]
	CMP		r10b, 0					; check if r10b == '\0' (base[j] == 0)
	JE		set_rax
	CMP		BYTE [rdi + r8], r10b	; else check if rdi[r8] == r10b (base[j] == str[i])
	JNE		index_incr				; if not equal, jump to the atoi_idx_inc label

add_to_total:
	MUL		r12						; total *= base_length
	ADD		rax, r9
	JMP		atoi_incr

set_rax:
	MOV		rax, rax				; ret = total
	CMP		rbx, 0					; check if rbx == 0 (if so, the sign is positive)
	JZ		return					; if equal, jump to the return label
	NEG		rax						; else ret = -ret

return:
	RET
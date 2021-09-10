.data

return2: .word 0

.text

.global ambient_control

ambient_control:
	ldr r5, addr_return2
	str lr, [r5]

	cmp r1, #1
	bne no_people

	mov r0, #1
	ldr lr, addr_return2
	ldr lr, [lr]
	bx lr

no_people:
	mov r0, #0
	ldr r2, addr_return2
	ldr lr, [r2]
	bx lr

addr_return2: .word return2

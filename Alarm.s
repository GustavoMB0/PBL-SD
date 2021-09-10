.data
return4: word 0

.text

.global garage

garage:
	ldr r5, addr_return3
	str lr, [r5]

//
	cmp r1, #1
	bne leave2

	orr r6, r2, r3
	cmp r6, #1
	bne leave

	mov r0, #1
	
	ldr lr, addr_return3
	ldr lr, [lr]
	bx lr

leave:
	mov r0, #0
	ldr lr, addr_return3
	ldr lr, [lr]
	bx lr

addr_return3: .word return3


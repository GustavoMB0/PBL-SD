.data

.balign 4
return: .word 0

.text

.global gargen_module

garden_module:

	ldr r5, addr_return
	str lr, [r5]
	cpm r1, #18
	blt leave

	cmp r1, #23
	bge leave

	mov r0, #1
	ldr r6, addr_return
	ldr lr, [r6]
	bx lr

leave:
	mov r0, #0
	ldr lr, addr_return
	ldr lr, [lr]
	bx lr

addr_return: .word return

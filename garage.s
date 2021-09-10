.data
return4: .word 0

.text

.global garage

garage:
	ldr r5, addr_return4
	str lr, [r5]

	cmp r1, #1
	bne leave2

	cmp r2, #18
	bge trigger_alarm

	cmp r2, #6
	ble trigger_alarm

	b leave2

leave2:
	mov r0, #0
	ldr lr, addr_return4
	ldr lr, [lr]
	bx lr

trigger_alarm:
	mov r0, #1
	ldr lr, addr_return4
	ldr lr, [lr]
	bx lr

addr_return4: .word return4

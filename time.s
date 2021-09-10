.data
.balign 4
return: .word 0

.balign 4
minutes: .word 0

.text

.global time_update

time_update:
	ldr r10, addr_return
	str lr, [r6]

	ldr r5, addr_minutes

	//Calcule time since the last loop iteraction
	mov r6, #174
	mov r7, #1
	mul r8, r6, r7

	//for testing we consider 1 minute for each iteraction
	add r5, r5, #1
	cmp r5, #60
	bne leave
	add r0, r1, #1

	ldr lr, addr_return
	ldr lr, [lr]
	bx lr

leave:
	ldr lr, addr_return
	ldr lr, [lr]
	bx lr

addr_minutes: .word minutes
addr_return: .word return

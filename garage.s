.data
return4: .word 0

hours: .word 0

sensor: word 0

query: .asciz "%d"


.text

.global main

main:
	ldr r10, addr_return
	str lr, [r5]
	
	// Lê a entrada do sensor de presença
	ldr r0, addr_query
	ldr r1, addr_sensor
	bl scanf

	//Lê a hora
	ldr r0, addr_query
	ldr r1, addr_hours
	bl scanf	

	//Verifica a presença da pessoa
	ldr r1, addr_sensor
	ldr r1, [r1]
	cmp r1, #1
	bne leave2

	//Verifica a hora

	ldr r1, addr_hours
	ldr r1, [r1]
	cmp r1, #18
	bge trigger_alarm

	cmp r1, #6
	ble trigger_alarm

	b leave2

leave2:
	//Printa o resultado
	mov r1, #0
	ldr r0, addr_query
	bl printf

	ldr lr, addr_return4
	ldr lr, [lr]
	bx lr

trigger_alarm:
	//Printa o resultado
	mov r1, #1
	ldr r0, addr_query
	bl printf

	ldr lr, addr_return4
	ldr lr, [lr]
	bx lr

addr_return4: .word return4
addr_query: .word query
addr_hours: .word hours
addr_sensor: .word sensor

.global printf
.gloabl scanf



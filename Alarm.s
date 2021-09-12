.data
return: word 0

query: .asciz "%d"

door: .word 0

sensor: .word 0

alarm: .word 0

.text

.global main

main:
	ldr r5, addr_return
	str lr, [r5]

	// Lê se o alarme está ligado
	ldr r0, addr_query
	ldr r1, addr_alarm
	bl scanf

	// Lê os sensores de presença e se a porta ou janelas abriram
	ldr r0, addr_query
	ldr r1, addr_door
	bl scnaf
	ldr r0, addr_query
	ldr r1, addr_sensor
	bl scanf

	// Verifica se o alarme está ligado
	ldr r1, addr_alarm
	ldr r1, [r1]
	cmp r1, #1
	bne leave

	// Verifica se um dos dois sensores está recebendo sinal
	ldr r2, addr_door
	ldr r2, [r2]
	ldr r3, addr_sensor
	ldr r3, [r3]
 
	orr r6, r2, r3
	cmp r6, #1
	bne leave

	//Printa os resultados
	mov r1, #1
	ldr r0, addr_query
	bl printf

	ldr lr, addr_return
	ldr lr, [lr]
	bx lr

leave:	
	//Printa o resultado
	mov r1, #0
	ldr r0, addr_query
	bl printf	

	ldr lr, addr_return
	ldr lr, [lr]
	bx lr

addr_return: .word return
addr_door: .word door
addr_query: .word query
addr_sensor: .word sensor
addr_alarm: .word alarm

.gloabl printf

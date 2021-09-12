.data

return: .word 0

query: .asciz "%d"

sensor: .word 0



.text

.global main

main:
	ldr r5, addr_return
	str lr, [r5]
	
	//Lê a entrada do sensor
	ldr r0, addr_query
	ldr r1, addr_sensor
	bl scanf
	
	//Carrega o valor do sensor e compara
	ldr r1, addr_sensor
	ldr r1, [r1]
	cmp r1, #1
	bne no_people
	
	//Printa o resultado
	mov r1, #1
	ldr r0, addr_query
	bl printf

	ldr lr, addr_return2
	ldr lr, [lr]
	bx lr

no_people:
	Printa o resultado
	mov r1, #0
	ldr r0, addr_query
	bl printf

	ldr lr, addr_return
	ldr lr, [lr]
	bx lr

addr_return: .word return
addr_query: .word query
addr_sensor: .word sensor

.global scanf
.global printf


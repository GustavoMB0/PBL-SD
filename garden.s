.data

.balign 4
return: .word 0

.balign 4
query: "%d"

.baling 4
hours: word 0

.text

.global main

main:
	
	ldr r6, addr_return
	str lr, [r6]
	
	//Lê as horas
	ldr r0, addr_query
	ldr r1, addr_hours
	bl scanf

	//Carrega o valor das horas e compara
	ldr r1, addr_hours
	ldr r1, [r1]
	cpm r1, #18
	blt leave

	cmp r1, #23
	bge leave


	//Printa o resultado
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
addr_query: .word query
addr_hours: .word hours

.gloabl printf
.global scanf

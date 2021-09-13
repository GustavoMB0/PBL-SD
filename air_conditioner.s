.data

.balign 4
air_return: .word 0

.balign 4
time_people: .word 0

.balign 4
time_temperature: .word 10

.balign 4
temperature: .word 0

.balign 4
time_offset: .word 0

.balign 4
onTemperature: .word 0

.balign 4
offTemperature: .word 0

.balign 4
sensor: .word 0

.balign 4
isOn: .word 0

.balign 4
temopar: .word 0

.balign4
query: .asciz "%d"

.text

.global main

main:
	ldr r6, addr_airreturn
	str lr, [r6]

	//Lê temperatura do ambiente
	ldr r0, addr_query
	ldr r1, addr_temperature
	bl scanf
	
	//Lê o tempo para desligar o ar condicionado depois que a pessoa deixa o ambiente
	ldr r0, addr_query
	ldr r1, addr_timeOffset
	bl scanf

	//Lê as temperaturas de funcionamento
	ldr r0, addr_query
	ldr r1, addr_onTemperature
	bl scanf
	ldr r0, addr_query
	ldr r1, addr_offTemperature
	bl scanf	

loop:
	//Lê o sensor de presença
	ldr r0, addr_query
	ldr r1, addr_sensor
	bl scanf

	// Verifica se a pessoa está presente no ambiente	
	ldr r0, addr_sensor
	ldr r0, [r0]
	cmp r0, #0
	beq no_people

	mov r5, #0
	ldr r9, addr_timePeople
	str r5, [r9]
	b temp_people


no_people:
	
	//Verifica se o ar está ligado
	ldr r0, addr_isOn
	ldr r0, [r0]
	cmp r0, #0
	beq turn_off
	
	//Ciclos do clock calculados contados a partir do codigo
	mov r7, #174
	mov r6, #1
	mul r5, r7, r6

	mov r5, #1
	
	//Soma o tempo em que a pessoa ficou fora da sala
	ldr r6, addr_timePeople
	ldr r6, [r6]
	add r5, r5, r6
	ldr r9, addr_timePeople
	str r5, [r9]
	
	//Verifica se o tempo salvo em r5 é igual ou maior que o tempo dado para desligar
	//O ar-condiciondo caso a pessoa 
	ldr r7, addr_timeOffset
	ldr r7, [r7]
	cmp r5, r7
	bge turn_off
	b temp_noPeople

temp_people:
	//Verficia se a temperatura do ambiente é maior que a temperatura
	//maxima indicada pelo usuario
	ldr r5, addr_temperature
	ldr r5, [r5]
	ldr r6, addr_onTemperature
	ldr r6, [r6]
	cmp r5, r6
	bge turn_on
	
	//Verifica se o ar está ligado
	ldr r0, addr_isOn
	ldr r0, [r0]
	cmp r0, #1
	beq isOn_module
	
	//Desliga o ar condicionado e printa o valor
	mov r0, #0
	ldr r9, addr_isOn
	str r0, [r9]

	ldr r0, addr_query
	ldr r1, addr_isOn
	ldr r1, [r1]
	bl printf
	
	//Atualiza a temperatura do ambiente
	ldr r5, addr_temperature
	ldr r5, [r5]
	sub r5, r5, #1

	ldr r9, addr_temperature
	str r5, [r9]

	mov r6, #10
	ldr r9, addr_timeTemperature
	str r6, [r9]
		
	b end

turn_on:
	ldr r6, addr_timeTemperature
	ldr r6, [r6]
	ldr r5, addr_termopar
	ldr r5, [r5]

	// Verifica se a temperatura chegou em 17 graus
	cmp r5, #1
	cmpeq r6, #5
	ble temp_termopar

	// Caso ar não tenha sido desligado devido ao termopar liga ele
	mov r0, #1
	ldr r9, addr_isOn
	str r0, [r9]
	
	//Verifica se o termopar o ar foi desligado pelo termopar
	ldr r5, addr_termopar
	ldr r5, [r5]
	cmp r5, #1
	beq temp_termopar
	
	// Printa o resultado
	ldr r0, addr_query
	ldr r1, addr_isOn
	ldr r1, [r1]
	bl printf

	// Altera a temperatura do ambiente
	ldr r5, addr_temperature
	ldr r5, [r5]
	sub r5, r5, #1
	
	ldr r9, addr_temperature
	str r5, [r9]
	ldr r9, addr_termopar
	
	//Reseta o tempo em que a pessoa deixou o ambiente
	mov r6, #10
	ldr r9, addr_timeTemperature
	str r6, [r9]

	b end

temp_noPeople:
	//Diminuiu a temperatura do ambiente
	ldr r5, addr_temperature
	ldr r5, [r5]
	sub r5, r5, #1
	
	ldr r9, addr_temperature
	str r5, [r9]

	//Incrementa o tempo que a pessoa deixou o ambiente	
	ldr r6, addr_timePeople
	ldr r6, [r6]
	add r6, r6, #1

	ldr r9, addr_timePeople
	str r6, [r9]
	
	//Matem o ar ligado e printa o valor
	mov r0, #1
	ldr r9, addr_isOn
	str r0, [r9]
	
	ldr r0, addr_query
	ldr r1, addr_isOn
	ldr r1, [r1]
	bl printf
	
	b end

temp_termopar:
	//Desliga o ar condicionado e printa
	mov r0, #0
	ldr r9, addr_isOn
	str r0, [r9]

	ldr r0, addr_query
	ldr r1, addr_isOn
	ldr r1, [r1]
	bl printf		

	//Incrementa o tempo em que o ar foi desligado devido ao termopar
	//e incrementa a temperatura do ambiente
	ldr r5, addr_timeTemperature
	ldr r5, [r5]
	add r5, r5, #1
	ldr r9, addr_timeTemperature
	str r5, [r9]
	ldr r6, addr_temperature
	add r6, r6, #1
	ldr r9, addr_temperature
	str r6, [r9]
	b end

turn_off:
	//Reseta o tempo que a pessoa deixou a sala
	mov r5, #0
	ldr r9, addr_timeTemperature
	str r5, [r9]
	ldr r9, addr_timePeople
	str r5, [r9]
	
	//Desliga o ar condicionado
	mov r0, #0
	ldr r9, addr_isOn	
	str r0, [r9]

	// Incrementa a temperatura do ambiente
	ldr r5, addr_temperature
	ldr r5, [r5]
	addr r5, r5, #1
	ldr r6, addr_temperature
	str r5, [r6]

	
	// Printa o resultado
	ldr r0, addr_query
	ldr r1, addr_isOn
	ldr r1, [r1]
	bl printf

	b end

isOn_module:
	ldr r5, addr_temperature
	ldr r5, [r5]
	ldr r6, addr_offTemperature
	ldr r6, [r6]
	
	//Verifica a temperatura do ambiente
	cmp r5, #17
	ble termopar_module
	cmpe r5, r6
	ble turn_off

	//Diminui o valor da temperatura ambiente
	ldr r5, addr_temperature
	ldr r5, [r5]
	sub r5, r5, #1

	//Printa a saida do ar condicionado
	ldr r0, addr_query
	ldr r1, addr_isOn
	ldr r1, [r1]
	bl printf
	
	//Guarda o valor da temperatura
	ldr r9, addr_temperature
	str r5, [r9]	
	
	b end

temopar_module:
	//Indica que o ar foi desligado devido ao termopar
	mov r5, #1
	ldr r9, addr_termopar
	str r5, [r9]
	
	//Começa a contagem de tempo para religar o ar
	mov r5, #0
	ldr r9, addr_timeTemperature
	str r5, [r9]
	
	//Desliga o ar e printa o valor
	mov r0, #0
	ldr r9, addr_isOn
	str r0, [r9]

	ldr r0, addr_query
	ldr r1, addr_isOn
	ldr r1, [r1]
	bl printf	

	b end

end:
	b loop
	ldr lr, addr_airreturn
	ldr lr, [lr]
	bx lr

addr_airreturn: .word air_return
addr_timePeople: .word time_people
addr_temperature: .word temperature
addr_timeTemperature: .word time_temperature
addr_timeOffset: .word time_offset
addr_onTemperature: .word onTemperature
addr_offTemperature: .word offTemperature
addr_isOn: .word isOn
addr_termopar: .word termopar
addr_sensor: .word sensor
addr_query: .word query

.gloabl printf
.global scanf

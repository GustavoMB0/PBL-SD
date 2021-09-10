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
inicial_temperature: .word 0
.balign 4
time_offset: .word 0
.balign 4
onTemperature: .word 0
.balign 4
offTemperature: .word 0
.balign 4
isOn: .word 0
balign 4
temopar: .word 0

.text
.global air_conditioner

air_conditioner:
	ldr r6, addr_airreturn
	str lr, [r6]

	//Gets time offset
	str r2, addr_timeOffset
	str r3, addr_onTemperature
	str r4, addr_offTemperature

	//Gets inicial temperature
	ldr r5, addr_inicialTemperature
	cmp r5, r1
	beq verify_people

	str r1, addr_inicialTemperature
	str r1, addr_temperature
	b verify_people

verify_people:
	//First case, the room is empty
	// For a certain amount of time

	cmp r0, #0
	beq no_people
	mov r5, #0
	str r5, addr_timePeople
	b temp_people

no_people:
	//Clock cycles counted from the source code
	//The result for this multiplication is
	//Aproximately 13 nano seconds

	//this value will be translated to 2 minutes to make
	// testing easier
	mov r7, #129
	mov r6, #1
	mul r5, r7, r6
	mov r5, #1
	ldr r6, addr_timePeople
	add r5, r6
	str r5, addr_timePeople
	ldr r7, addr_timeOffset
	cmp r5, r7
	bge turn_off
	b temp_noPeople

temp_people:
	ldr r5, addr_temperature
	ldr r6, addr_onTemperature
	ldr r5, [r5]
	ldr r6, [r6]
	cmp r5, r6
	bge turn_on
	ldr r0, addr_isOn
	ldr r0, [r0]
	mov r0, #0
	str r0, addr_isOn
	ldr r5, addr_temperature
	ldr r5, [r5]
	add r5, r5, #1
	str r5, addr_temperature
	b end

turn_on:
	ldr r6, addr_timeTemperature
	ldr r5, addr_termopar
	cmp r5, #1
	cmpeq r6, #5
	blt temp_termopar

	mov r0, #1
	str r0, addr_isOn
	ldr r5, addr_temperature
	sub r5, r5, #1
	str r5, addr_temperature

	mov r6, #10
	str r6, addr_timeTemperature

	b end

temp_noPeople:
	ldr r5, addr_temperature
	ldr r5, [r5]
	sub r5, r5, #1
	str r5, addr_temeprature

	ldr r6, addr_timePeople
	ldr r6, [r6]
	add r6, r6, #1
	str r6, addr_timePeople

	mov r0, #1
	str r0, addr_isOn

	b end

temp_termopar:
	mov r0, #0
	str r0, addr_isOn
	ldr r5, addr_timetemperature
	ldr r5, [r5]
	add r5, r5, #1
	str r5, addr_timeTemperature
	ldr r6, addr_temperature
	add r6, r6, #1
	str r6, addr_temperature
	b end

turn_off:
	mov r5, #0
	str r5, addr_timeTemperature
	str r5, addr_timePeople
	mov r0, #0
	str r0, addr_isOn
	b end

isOn_module:
	ldr r5, addr_temperature
	ldr r6, addr_offTemperature
	cmp r5, #17
	ble termopar_module
	cmpe r5, r6
	ble turn_off
	ldr r5, addr_temperature
	add r5, r5, #1
	str r5, addr_temperature

	b end

temopar_module:
	mov r5, #1
	str r5, addr_temopar
	mov r5, #0
	str r5, addr_timeTemperature
	mov r0, #0
	str r0, addr_isOn

	b end

end:
	ldr lr, addr_airreturn
	ldr lr, [r6]
	bx lr

addr_airreturn: .word air_return
addr_timePeople: .word time_people
addr_temperature: .word temperature
addr_timeTemperatyre: .word time_temperature
addr_incialTemperature: .word inicial temperature
addr_onTemperature: .word onTemperature
addr_offTemperature: .word offTemperature
addr_isOn: .word isOn
addr_termopar: .word termopar

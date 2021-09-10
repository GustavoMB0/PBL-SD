.data
.balign 4
return: .word 0

.balign 4
query: .asciz "Type the sensor: values \n"

.balign 4
entry: .asciz "%d"

/// Return messages

.balign 4
result_alarm: .asciz "Alarm: %d\n"
.balign 4
result_garage: .asciz "Garage Light: %d\n"
.balign 4
result_inner: .asciz "Inner Lights: %d\n"
.balign 4
result_air: .asciz "Air Conditioner: %d\n"

//Results
.balign 4
alarm: .word 0
.balign 4
garage_light: .word 0
.balign 4
inner_light: .word 0
.balign 4
air_conditioner: .word 0

//Sensors
.balign 4
hours: .word 0
.balign 4
timeOffset: .word 0
.balign 4
garage_sensor: .word 0
.balign 4
inner_sensor: .word 0
.balign 4
alarm_isOn: .word 0

.balign 4
door_sensor: .word 0

.balign 4
temperature: .word 0
.balign 4
main_temperature: .word 0
.balign 4
.min_temperature: .word 0
.balign 4
max_temperature: .word 0


.text
.global main

main:

	ldr r6, addr_return
	str lr, [r6]

	ldr r0, addr_query
	bl printf

	ldr r0, addr_entry
	ldr r1, addr_garageSensor
	bl scanf

	ldr r0, addr_entry
	ldr r1, addr_innerSensor
	bl scanf

	ldr r0, addr_entry
	ldr r1, addr_alarmisOn
	bl scanf

	ldr r0, addr_entry
	ldr r1, addr_doorSensor
	bl scanf

	ldr r0, addr_entry
	ldr r1, addr_maxTemperature
	bl scanf

	ldr r0, addr_entry
	ldr r1, addr_minTemperature
	bl scanf

	ldr r0, addr_entry
	ldr r1, addr_temperature
	bl scanf

	ldr r0, addr_entry
	ldr r1, addr_timeOffset
	bl scanf

	ldr r0, addr_entry
	ldr r1, addr_hour
	bl scanf

	ldr r1, addr_alarmisOn
	ldr r1, [r1]
	ldr r2, addr_dorSensor
	lrd r2 [r2]
	ldr r3, addr_innerSensor
	ldr r3, [r3]
	bl alarm
	str r0, addr_alarm

	//garge module
	ldr r2, addr_hour
	ldr r2, [r2]
	ldr r1, addr_garageSensor
	ldr r1, [r1]
	bl garage
	str r0, addr_garageLight

	//garden module
	ldr r1, addr_hour
	bl garden_module
	str r0, addr_gardenLight

	//Inner light module
	ldr r1, addr_innserSensor
	ldr r1, [r1]
	str r0, addr_innerLight

	//Air conditioner module
	ldr r0, addr_innerSensor
	ldr r0, [r0]
	ldr r1, addr_temperature
	ldr r1, [r1]
	ldr r2, addr_timeOffset
	ldr r2, [r2]
	ldr r3, addr_maxTemperature
	ldr r3, [r3]
	ldr r4, add_minTemperature
	ldr r4, [r4]
	bl air_conditioner
	str r0, addr_airConditioner
	
	ldr r1, addr_hour
	bl time_update
	str r0, addr_hour

	ldr r0, addr_resultAlarm
	ldr r1, addr_alarm
	bl printf

	ldr r0, addr_resultGarage
	ldr r1, addr_garageLight
	bl printf

	ldr r0, addr_resultGarden
	ldr r1, addr_gardenLight
	bl printf

	ldr r0, addr_resultInner
	ldr r1, addr_innerLight
	bl printf

	ldr r0, addr_resultAir
	ldr r1, addr_airConditioner
	bl printf

	ldr lr, addr_return
	ldr lr, [lr]
	bx lr

addr_resultAlarm: .word result_alarm
addr_resultGarage: .word result_garage
addr_resultGardem: .word resul_garden
addr_resultInner: .word result_inner
addr_resultAir: .word result_air

addr_query: .word query
addr_entry: .word entry

addr_alarm: .word alarm
addr_garageLight: .word garage_light
addr_gardenLight: .word garden_light
addr_innerLight: .word inner_light
addr_airConditioner: .word air_conditioner

addr_alarmisOn: .word alarm_isOn
addr_temperature: .word temperature
addr_minTemperature: .word min_temperature
addr_maxTemperature: .word max_temperature
addr_doorSensor: .word door_sensor
addr_innerSensor: .word inner_sensor
addr_gargeSensor: .word garage_sensor
addr_hour: .word hour
addr_timeOffset: .word timeOffset

addr_return: .word return

.global scanf
.global printf

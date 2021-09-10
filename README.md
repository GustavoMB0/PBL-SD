# PBL-SD

  Para compilar os codigos basta executar os seguintes comandos:
  
  as -o garage.o garage.s
  gcc shared -o garage.so garage.o
  
  as -o Alarm.o Alarm.s
  gcc shared -o Alarm.so Alarm.o
  
  as -o air_conditioner.o air_conditioner.s
  gcc shared -o air_conditioner.so air_conditioner.o
  
  as -o Ambient_lights.o Ambient_lights.s
  gcc shared -o Ambient_lights.so Ambient_lights.o
  
  as -o garden.o garden.s
  gcc shared -o garden.so garden.o
  
  as -o time.o time.s
  gcc shared -o time.so time.o
  
  as -o main_loop.o main_loop.s
  gcc -o main_loop main_loop.o -L. l:garage.so l:Alarm.s0 l:air_conditioner.so l:Ambient_lights.so l:garden.so l:time.so -Wl,-rpath,$(pwd)

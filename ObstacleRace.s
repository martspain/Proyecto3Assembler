/* 
**********

Proyecto 3

Universidad Del Valle de Guatemala

Autores:
- Diana Sosa			Carné: 
- Sebastián Maldonado 	Carné: 
- Martín España 		Carné: 19258

Fecha de creación: 17/05/2020

**********

Proyecto: Juego de Carrera de Obstáculos

**********
*/

.text
.align 2
.global main
.type main,%function

/*Inicio del programa (Muestra el banner)*/
main:
	stmfd sp!, {lr}
	
	/*Se muestra el titulo*/
	ldr r0,=titulo
	bl puts
	
	/*Se muestra el asciiArt*/
	ldr r0,=asciiArt
	bl puts
	
	/*Se inicializan las variables de las posiciones a 0*/
	mov r0, #0
	ldr r1,=posicion_juguno
	str r0,[r1]
	
	mov r0, #0
	ldr r1,=posicion_jugdos
	str r0,[r1]
	
	mov r0, #0
	ldr r1,=posicion_jugtres
	str r0,[r1]
	
	mov r0, #0
	ldr r1,=posicion_jugcuatro
	str r0,[r1]
	
	mov r0, #0
	ldr r1,=posicion_computa
	str r0,[r1]
	
/*Muestra el menu de opciones y dependiendo del input del usuario dirige el flujo
  del programa a la etiqueta correspondiente por medio de un branch*/
menu:
	/*Se muestra el menu*/
	ldr r0, =opciones
	bl puts
	
	/*Se solicita la opcion al usuario y se almacena en variable 'almacen' */
	ldr r0,=decimal
	ldr r1,=almacen
	bl scanf
	
	/*Se guarda el valor de 'almacen' en r4*/
	ldr r4,=almacen
	ldr r4,[r4]
	
	cmp r4, #1
	beq play
	
	cmp r4, #2
	beq showAscii
	
	cmp r4, #3
	beq exitGame
	
	b showError

showAscii:
	ldr r0,=asciiArt
	bl puts
	
	b menu
	
showError:
	ldr r0,=error_message
	bl puts
	
	b menu

play:

	numberOfPlayers:
		/*Se solicita el numero de jugadores*/
		ldr r0,=opciones_uno
		bl puts
		
		/*Se solicita la opcion al usuario y se almacena en variable 'almacen' */
		ldr r0,=decimal
		ldr r1,=almacen
		bl scanf
		
		/*Se guarda el valor de 'almacen' en r4*/
		ldr r4,=almacen
		ldr r4,[r4]
		
		cmp r4, #1
		moveq r10, #1
		beq computerParticipation
		
		cmp r4, #2
		moveq r10, #2
		beq computerParticipation
		
		cmp r4, #3
		moveq r10, #3
		beq computerParticipation
		
		cmp r4, #4
		moveq r10, #4
		beq computerParticipation
		
		b showInGameError
		
	computerParticipation:
		ldr r0,=opciones_dos
		bl puts
		
		/*Se solicita la opcion al usuario y se almacena en variable 'almacen' */
		ldr r0,=decimal
		ldr r1,=almacen
		bl scanf
		
		/*Se guarda el valor de 'almacen' en r4*/
		ldr r4,=almacen
		ldr r4,[r4]
		
		cmp r4, #1
		beq computerYes
		
		cmp r4, #2
		beq computerNo
		
		b showInGameErrorTwo
		
	computerYes:
		/*Si se quiere usar la computadora se resta un jugador al numero de jugadores*/
		sub r10, r10, #1
		
		/*Se guarda el numero de jugadores en una variable como backup*/
		ldr r0,=numero_jugadores
		str r10, [r0]
		
		/*Se utiliza r11 como bandera para saber si se juega con la computadora o no*/
		mov r11, #1
		
		b raceLength
		
	computerNo:
		
		/*Se utiliza r11 como bandera para saber si se juega con la computadora o no*/
		mov r11, #0
		
		b raceLength
		
	raceLength:
		ldr r0,=opciones_tres
		bl puts
		
		/*Se solicita la opcion al usuario y se almacena en variable 'largo_pista' */
		ldr r0,=decimal
		ldr r1,=largo_pista
		bl scanf
		
		/*Se guarda el valor de 'largo_pista' en r4*/
		ldr r4,=largo_pista
		ldr r4,[r4]
		
		cmp r4, #12
		blt showInGameErrorThree
		
		cmp r4, #50
		bgt showInGameErrorThree
		
		cmp r4, #50
		ble setTrackLength
		
		b showInGameErrorThree
		
	setTrackLength:
		/*Se utiliza r9 para saber cuantos obstaculos debe contar*/
		mov r9, r4
		
		/*Se resta uno porque esto servira como el indice del array mas adelante*/
		sub r9, r9, #1
		
	startGame:
		/*Se utiliza r8 como contador para saber a que jugador le toca jugar*/
		mov r8, #1
		
	playerTurn:
		ldr r10,=numero_jugadores
		ldr r10, [r10]
		cmp r8, r10
		ble throwDices
		
		bgt computerCheck
	
	throwDices:
		ldr r0,=instruccion_uno
		mov r1, r8
		bl printf
		
		/*Se solicita al usuario  presionar ENTER para continuar */
		ldr r0,=string
		ldr r1,=almacen
		bl scanf
	
	generateNumbers:
		/*Aqui se utiliza la subrutina para generar numeros aleatorios*/
		/*Se reserva r12 para el paso de parametros (numero maximo) */
		/*bl RANDOM*/
		/*El valor generado retornara en r12*/
		
		mov r5, #0
		
		mov r12, #6
		bl RANDOM
		
		add r5, r5, r12
		
		mov r12, #6
		bl RANDOM 
		
		/*Ahora r5 tiene la suma de los valores de ambos dados*/
		add r5, r5, r12
		
		ldr r0, =advance_info
		mov r1, r5
		bl printf
		
	/*Se añade la suma a la posicion actual de ambos*/
	trackPositions:
		cmp r8, #1
		beq getPlayerOne
		
		cmp r8, #2
		beq getPlayerTwo
		
		cmp r8, #3
		beq getPlayerThree
		
		cmp r8, #4
		beq getPlayerFour
		
		b getComputer
	
	getPlayerOne:
		ldr r3,=posicion_juguno
		ldr r3, [r3]
	
	getPlayerTwo:
		ldr r3,=posicion_jugdos
		ldr r3, [r3]
	
	getPlayerThree:
		ldr r3,=posicion_jugtres
		ldr r3, [r3]
	
	getPlayerFour:
		ldr r3,=posicion_jugcuatro
		ldr r3, [r3]
		
	getComputer:
		ldr r3,=posicion_computa
		ldr r3, [r3]
	
	add r3, r5, r3
	
	b showTrack
	
	showTrack:
		
		/*R7 tiene el contador para el recorrido del array*/
		mov r7, #1
		
	showArray:
		
		/*Muestra el primer elemento*/
		ldr r0,=string
		ldr r1,=track
		ldr r1, [r1]
		bl printf 
		
	loopTrack:
		mov r0, #4
		
		/*r6 tiene la posicion actual en el array*/
		mul r6, r7, r0
		
		/*Si la posicion actial en el array es igual a la posicion actual del jugador muestra al jugador*/
		cmp r6, r5
		beq showPlayer
		
		/*Si no, muestra el elemento normalmente*/
		ldr r0,=string
		ldr r1,=track
		add r1, r1, r7
		ldr r1, [r1]
		bl printf 
		
		/*Se suma uno al contador del array, y se compara para ver si ya termino de recorrerlo*/
		add r7, #1
		cmp r7, r9
		ble loopTrack
		bgt prepareTurn
	
	/*Muestra al jugador en el array y vuelve al recorrido*/
	showPlayer:
		ldr r0,=string
		ldr r1,=player
		ldr r1, [r1]
		bl printf
		
		add r7, #1
		cmp r7, r9
		ble loopTrack
		
	computerCheck:
		cmp r11, #1
		beq computerTurn
		blt repeatTurn
	
	computerTurn:
		
		b repeatTurn
	
	prepareTurn:
		add r8, r8, #1
		
		b playerTurn
	
	repeatTurn:
		mov r8, #1
		
		b playerTurn

	showInGameError:
		ldr r0,=error_message
		bl puts
		
		b numberOfPlayers
	
	showInGameErrorTwo:
		ldr r0,=error_message
		bl puts
		
		b computerParticipation
		
	showInGameErrorThree:
		ldr r0,=error_message
		bl puts
		
		b raceLength

exitGame:
	mov r0,#0
	mov r3,#0
	ldmfd sp!,{lr}
	bx lr
	
	
/* Asignación de datos*/
.data
.align 2
	

/*Variables*/
almacen:			.word 0
num_random_one: 	.word 0
num_random_two:		.word 0
numero_jugadores: 	.word 0
largo_pista: 		.word 0
posicion_juguno: 	.word 0
posicion_jugdos: 	.word 0
posicion_jugtres: 	.word 0
posicion_jugcuatro:	.word 0
posicion_computa:	.word 0

/*Mensajes para mostrar en pantalla*/
titulo: 			.asciz "Universidad del Valle de Guatemala \nCarrera de Obstáculos \nAutores: Diana Sosa, Sebastián Maldonado y Martín España \n"
opciones: 			.asciz "---------------- \nMenu de opciones \n---------------- \n1. Jugar \n2. Mostrar Ascii Art \n3. Salir... \n"
opciones_uno: 		.asciz "---------------- \nCuantos jugadores entraran a la carrera? \n---------------- \n1. Uno \n2. Dos \n3. Tres \n4. Cuatro \n"
opciones_dos: 		.asciz "---------------- \nDesea incluir a la computadora en la carrera? \n---------------- \n1. Si \n2. No \n"
opciones_tres: 		.asciz "Porfavor, ingrese el numero de obstaculos de la carrera (minimo 12 y maximo 50): \n"
instruccion_uno: 	.asciz "Jugador %d presione ENTER para tirar los dados... "
error_message: 		.asciz "Error: ingrese una opcion valida... \n"
error_message_two: 	.asciz "Error:  \n"
despedida: 			.asciz "***GAME OVER***GAME OVER***GAME OVER*** \nGano el jugador %d ! Felicidades... \n"
advance_info:		.asciz "WOW! Los dados no mienten! Avanzas %d espacios... \n"
decimal:			.asciz "%d"
string: 			.asciz "%s"
player: 			.asciz "O"
track:				.asciz "_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_","_"
asciiArt:		 	.asciz "            O O \n           dO Ob \n          dOO OOO \n         dOOO OOOb \n        dOOOO OOOOb \n        OOOOO OOOOO \n        OOOOO OOOOO \n        OOOOO OOOOO \n        YOOOO OOOOO \n         YOOO OOOP \n    oOOOOOOOOOOOOb \n  oOOOOOOOOOOOOOOOb \n oOOOb dOOOOOOOOOOO \nOOOOOOOOOOOOOOOOOOO \nOOOOOOOOOOOOOOOOOOP \nOOOOOOOOOOOOOOOOOP \n YOOOOOOOOOOOOOOP \n   YOOOOOOOOOOOP \n  %%%%%%%%%%%%%% \n %%%%%%OOOjgsOOO \n"


	

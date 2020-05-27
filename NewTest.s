/* 
**********

Proyecto 3

Universidad Del Valle de Guatemala

Autores:
- Diana Sosa			Carné: 
- Sebastián Maldonado 	Carné: 18003
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
		
		ldr r0,=numero_jugadores
		str r4,[r0]
		
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
		mov r8, #0
		mov r6, #0
		mov r2, #4
		mov r5, #1
		ldr r0, =turno_actual
		str r5, [r0]
		
		/* Offset del array*/
		mul r6, r8, r2
		
		loopGame:
			/*Muestra el turno actual*/
			ldr r0, =instruccion_uno
			ldr r1, =turno_actual
			ldr r1, [r1]
			bl printf
			
			/*Recopila el enter del usuario*/
			ldr r0, =string
			ldr r1, =almacen
			bl scanf
			
			ldr r0, =prueba
			bl puts
			
		b menu
		

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
turno_actual:       .word 0

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
prueba:				.asciz "Prueba"

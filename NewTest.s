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

	/*Se inicializan las posiciones de los jugadores*/
	ldr r0, =posicion_juguno
	mov r1, #0
	str r1, [r0]
	ldr r0, =posicion_jugdos
	mov r1, #0
	str r1, [r0]
	ldr r0, =posicion_jugtres
	mov r1, #0
	str r1, [r0]
	ldr r0, =posicion_jugcuatro
	mov r1, #0
	str r1, [r0]
	ldr r0, =posicion_computa
	mov r1, #0
	str r1, [r0]
	
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
		mov r5, #1
		ldr r0, =turno_actual
		str r5, [r0]
		
		loopGame:
			/*Muestra el turno actual*/
			ldr r0, =instruccion_uno
			ldr r1, =turno_actual
			ldr r1, [r1]
			bl printf
			
			/*Limpia el buffer*/
			bl getchar 
			
			/*Recopila el enter del usuario*/
			bl getchar
			
			throwDices:
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
			
				ldr r3, =turno_actual
				ldr r3, [r3]
				
				cmp r3, #1
				beq addPOne
				
				cmp r3, #2
				beq addPTwo
				
				cmp r3, #3
				beq addPThree
				
				cmp r3, #4
				beq addPFour
				
				ldr r1, =numero_jugadores
				ldr r1, [r1]
				
				cmp r3, r1
				bgt addComputer
				
				addPOne:
					mov r0, #0
				
					ldr r1, =posicion_juguno
					ldr r1, [r1]
					
					add r0, r1, r5
					
					ldr r1, =posicion_juguno
					str r0, [r1]
					
					mov r10, r0
					
					b showP1Track
				
				addPTwo:
					mov r0, #0
				
					ldr r1, =posicion_jugdos
					ldr r1, [r1]
					
					add r0, r1, r5
					
					ldr r1, =posicion_jugdos
					str r0, [r1]
					
					mov r10, r0
					
					b showP2Track
					
				addPThree:
					mov r0, #0
				
					ldr r1, =posicion_jugtres
					ldr r1, [r1]
					
					add r0, r1, r5
					
					ldr r1, =posicion_jugtres
					str r0, [r1]
					
					mov r10, r0
					
					b showP3Track
					
				addPFour:
					mov r0, #0
				
					ldr r1, =posicion_jugcuatro
					ldr r1, [r1]
					
					add r0, r1, r5
					
					ldr r1, =posicion_jugcuatro
					str r0, [r1]
					
					mov r10, r0
					
					b showP4Track
					
				addComputer:
					mov r0, #0
				
					ldr r1, =posicion_computa
					ldr r1, [r1]
					
					add r0, r1, r5
					
					ldr r1, =posicion_computa
					str r0, [r1]
					
					mov r10, r0
					
					b showCPTrack
			
			showP1Track:
				ldr r0, =posicion_juguno
				ldr r1, [r0]
				
				/*Maximo del loop*/
				ldr r5, =largo_pista
				ldr r5, [r5]
				
				/*Contador del loop*/
				mov r6, #1
				
				loopOne:
					cmp r1, r6
					beq showPlayer
					
					ldr r0, =track
					bl puts
					
					cmp r6, r5
					addle r6, r6, r1
					ble loopOne
					
					b changeTurn
			showP2Track:
				b menu
			showP3Track:
				b menu
			showP4Track:
				b menu
			showCPTrack:
				b menu
			
			showPlayer:
				ldr r0, =player
				bl puts
			
			changeTurn:
				ldr r0, =turno_actual
				ldr r0, [r0]
				
				ldr r1, =numero_jugadores
				ldr r1, [r1]
				
				cmp r0, r1
				blt nextPlayer
				bge computerTurn 
				
				nextPlayer:
					ldr r0, =turno_actual
					ldr r3, [r0]
					add r3, r3, #1
					str r3, [r0]
					
					b loopGame
				
				computerTurn:
					cmp r11, #1
					beq doYourThingComputer
					
					ldr r0, =turno_actual
					mov r3, #0
					str r3, [r0]
					
					b loopGame
			
			doYourThingComputer:
				/*Hacer el proceso automata de la computadora*/
				
				ldr r0, =turno_actual
				mov r3, #0
				str r3, [r0]
				
				b loopGame
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
char:				.asciz "%c "
player: 			.asciz "O"
track:				.ascii "_"
asciiArt:		 	.asciz "            O O \n           dO Ob \n          dOO OOO \n         dOOO OOOb \n        dOOOO OOOOb \n        OOOOO OOOOO \n        OOOOO OOOOO \n        OOOOO OOOOO \n        YOOOO OOOOO \n         YOOO OOOP \n    oOOOOOOOOOOOOb \n  oOOOOOOOOOOOOOOOb \n oOOOb dOOOOOOOOOOO \nOOOOOOOOOOOOOOOOOOO \nOOOOOOOOOOOOOOOOOOP \nOOOOOOOOOOOOOOOOOP \n YOOOOOOOOOOOOOOP \n   YOOOOOOOOOOOP \n  %%%%%%%%%%%%%% \n %%%%%%OOOjgsOOO \n"
prueba:				.asciz "Prueba"

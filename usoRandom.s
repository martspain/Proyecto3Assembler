/*
 * ------------------------------------------------------------
 *  usoRandom.s v1.0.0
 * ------------------------------------------------------------
 */

/**
 *  Programa principal para la generacion de un numero
 *  entero aleatorio en ARM assembly, usando un valor maximo
 *  ---------------------------------------------------------
 *  AUTH: Juan Jose Celada 
 *  DATE: 2020-05-13
 *  ---------------------------------------------------------
 *  DEPS: randGen.s
 *	COMP: gcc -o random usoRandom.s randGen.s
 */ 

/**
 * ------------------------------------------------------------
 *    Data & variables
 */
.data
.align 2
range_msg:
	.asciz "Ingrese un numero del valor maximo del random (0 para salir): "
range_form:
	.asciz "%d"
range_val:
	.word 0
	
disp_rand:
	.asciz "Valor aleatorio: %d\n"
	
bye:
	.asciz "\n***** Bye! *****\n\n"


.text 
.align 2 
.global main
.type main, %function 

main: 

loop:

	/**
	 * Ingreso de rango maximo
	 */
	LDR R0,=range_msg
	BL puts
	LDR R0,=range_form
	LDR R1,=range_val
	BL scanf
	
	/**
	 * Test salir
	 */
	LDR R0,=range_val
	LDR R0,[R0]
	CMP R0,#0
	BEQ exit	
	
	/**
	 * Generacion de random
	 */
	LDR R12,=range_val
	LDR R12,[R12]
	BL    RANDOM
	MOV   R1,R12
	LDR   R0, =disp_rand
	BL    printf
	
	B loop

exit:	
	LDR R0,=bye
	BL puts

	MOV   R7, #1
	SWI   0

/*
 * ------------------------------------------------------------
 *  randGen.s v1.1.0
 * ------------------------------------------------------------
 */

/**
 *    Subrutina para generar un numero aleatorio usando un
 *    valor maximo de entrada
 *    --------------------------------------------------------
 *    AUTH: Pablo Sao 
 *    DATE: 2019-04-21
 *    MODF: Juan Jose Celada (2020-05-12)
 *    --------------------------------------------------------
 *    DEPS: random.s
 */ 

.global	__aeabi_idivmod
.align	2
.global	RANDOM
.type	RANDOM, %function

@**    R12 <- Al inicio indica el valor máximo de random
@**    R12 <- Al terminar contiene el valor generado
RANDOM:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	
	PUSH  {FP, LR}
	
	ADD   FP, SP, #4
	SUB   SP, #8
	STR   R12, [FP, #-8]
	MOV   R0, #0
	
	@@ Paso 
	BL    time
	MOV   R12, R0
	MOV   R0, R12
	BL    srand
	BL    rand
	MOV   R12, R0
	LDR   R1, [FP, #-8]
	MOV   R0, R12
	BL    __aeabi_idivmod
	MOV   R12, R1
	ADD   R12, R12, #1
	SUB   SP, FP, #4
	
	POP   {FP, PC}

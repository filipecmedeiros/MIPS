#include<iregdef.h>
.data
n: .word 3
s: .word -2
sd: .word

.text
TextB: .asciiz "fatorial :  %d\n"
.globl start
.ent start

start:
     lw a0, n				# carrega n no acumulador
     jal L2					# fatorial
    
     move t1, v0			# guarda em t1 o retorno da funcao
    
	
    lw a0, s				# carrega s no acumular
    jal L2					# chama fatorial
  
	move t2, v0			# guarda em t2 o retorno da funcao

  	 lw t5,n				# carregando temporárias
	 lw t4, s				# t4 = s e t5 = n
	 
	 sub t3,t5,t4			# subtraindo (n-s)
	 move a0, t3				# carregando o valor da sub em a0
	 jal L2					# chamando fatorial para (n-s)
	 
	 move t3, v0			# guardando o retorno em t3 = (n-s)!
	 
	 mult t2, t2, t3		# s! . (n-s)! guardado em t4
	 div t1, t1, t2			# n! / s!(n-s)!
	 
	 sw t1,sd 			# colocando o resultado na variável sd
	
	slt v1,t5,t4                        #se n < s entao v1 = 1; se for >= recebe v1=0
    beq t5,t4,Igual  				    # se n == s                 
    beq t4,zero,Zerox                    # se s==0
    beq t5, zero, Zerox					 # se n==0
                     
	slt v0, t5,0						# n<0 e/ou s<0, v1 = 2   
	beq v0, 1, Menor
	slt v0, t4,0
	beq v0, 1, Menor		
						   
    j fim

Igual:
        li v1, 3
        j fim
Zerox:
        li v1,4

        j fim
Menor:
		li v1, 2
		j fim  
    	
L2:    
    addi sp,sp,-8
    sw ra, 4(sp)
    sw a0, 0(sp)
    slti t0,a0,1
        beq t0,zero,L1
        addi v0,zero,1
        addi sp,sp,8
        jr ra
    L1:
        addi a0,a0,-1
         jal L2
    lw a0,0(sp)
    lw ra, 4(sp)
    addi sp,sp,8
    mul v0,a0,v0
    jr ra
    
fim:    

	la a0, TextB
	move a1, v1
	jal printf
	
.end start
break
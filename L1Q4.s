.data 
a: .word 3
b: .word -4
SD: .word 10

.text
.globl start
.ent start
start: 
		lw $5, a
		lw $6, b
		addi $21, $0, 0 //SD inicializa com 0
		addi $15, $0, 0 //contador
		
		slt $7, $5, $0  //if ($5 < $0) $7 = 1
		slt $8, $6, $0 // if ($6 < $0) $8 = 1
		
		bne $7, $8, dif //são diferentes, pode ser + ou -
		bne $7, $0, negative //if (a < 0) jump to negative
		
		//ambos são +
		 
begin:	add $21, $21, $5  //for ($15=0; $15 != $6 (b); $15 ++)     $21(SD) += $5(a)
		addi $15, $15, 1
		bne $15, $6, begin
		j fim

		
negative: //ambos são negativos
		
		addi $16, $0, 0
		add $18, $0, $5 //$18 = a
volte:	addi $16, $16, 1  //for ($16=0, $18=a; $18 !=0; $18--, $16++) -> $16 == +a
		addi $18, $18, 1
		bne $18, $0, volte		
		
		add $18, $0, $6 //$18 = b
		
loop:	add $21, $21, $16 //for ($15=0; $15 != $18 (b); $15 ++)     $21(SD) += $16(a)
		addi $15, $15, -1
		bne $15, $18, loop
		
		bne $7, $8, gab
		
		j fim
		
dif: //sinais diferentes
	
	add $16, $0, $5 //$16 = a
	add $18, $0, $6
	beq $7, $0, loop //if (a>0) jump to loop (a == + and b== -)
	
	add $16, $0, $6 //$16 = b
	add $18, $0, $5
	j loop

gab:
	sub $21, $0, $21
	


fim: sw $21, SD	
.end start	